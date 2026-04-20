USE montgomery_crime_db;

DROP TABLE IF EXISTS specific_incidents;
DROP TABLE IF EXISTS victims;
DROP TABLE IF EXISTS incidents;
DROP TABLE IF EXISTS crimes;
DROP TABLE IF EXISTS addresses;
DROP TABLE IF EXISTS police_districts;
DROP TABLE IF EXISTS time_tbl;
DROP TABLE IF EXISTS cities;

CREATE TABLE cities (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(255) NOT NULL,
    state VARCHAR(2) NOT NULL,
    zip_code VARCHAR(10),
    place VARCHAR(150)
    UNIQUE (city_name, state, zip_code, place)
);

CREATE TABLE addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    block_address VARCHAR(255) NOT NULL,
    address_number INT,
    street_prefix VARCHAR(20),
    street_name VARCHAR(100),
    street_suffix VARCHAR(20),
    street_type VARCHAR(20),
    city_id INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES cities(city_id),
    UNIQUE (
        block_address,
        address_number,
        street_prefix,
        street_name,
        street_suffix,
        street_type,
        city_id
    )
);

CREATE TABLE crimes (
    offence_code INT PRIMARY KEY,
    crime_name1 VARCHAR(100),
    crime_name2 VARCHAR(150),
    crime_name3 VARCHAR(150)
);

CREATE TABLE police_districts (
    police_district_number VARCHAR(10) PRIMARY KEY,
    police_district_name VARCHAR(100)
);

CREATE TABLE time_tbl (
    time_id INT AUTO_INCREMENT PRIMARY KEY,
    start_date_time DATETIME NOT NULL,
    end_date_time DATETIME,
    incident_year INT NOT NULL,
    incident_month INT NOT NULL,
    incident_day INT NOT NULL,
    incident_hour INT NOT NULL,
    incident_weekday VARCHAR(20) NOT NULL,
    UNIQUE (start_date_time, end_date_time)
);

CREATE TABLE incidents (
    incident_id BIGINT PRIMARY KEY,
    cr_number BIGINT,
    police_district_number VARCHAR(10),
    time_id INT NOT NULL,
    FOREIGN KEY (police_district_number) REFERENCES police_districts(police_district_number),
    FOREIGN KEY (time_id) REFERENCES time_dim(time_id)
);

CREATE TABLE victims (
    victim_id INT AUTO_INCREMENT PRIMARY KEY,
    incident_id BIGINT NOT NULL,
    victim_count INT NOT NULL,
    FOREIGN KEY (incident_id) REFERENCES incidents(incident_id),
    UNIQUE (incident_id)
);

CREATE TABLE specific_incidents (
    specific_incident_id INT AUTO_INCREMENT PRIMARY KEY,
    incident_id BIGINT NOT NULL,
    address_id INT NOT NULL,
    victim_id INT NOT NULL,
    offence_code INT NOT NULL,
    FOREIGN KEY (incident_id) REFERENCES incidents(incident_id),
    FOREIGN KEY (address_id) REFERENCES addresses(address_id),
    FOREIGN KEY (victim_id) REFERENCES victims(victim_id),
    FOREIGN KEY (offence_code) REFERENCES crimes(offence_code),
    UNIQUE (incident_id, address_id, victim_id, offence_code)
);