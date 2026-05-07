USE montgomery_crime_db;

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE '#NAME OF CLEANED CSV FILE PATH HERE'
INTO TABLE raw_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    incident_id,
    offence_code,
    cr_number,
    victims,
    crime_name1,
    crime_name2,
    crime_name3,
    police_district_name,
    block_address,
    city,
    state,
    zip_code,
    place,
    address_number,
    street_prefix,
    street_name,
    street_suffix,
    street_type,
    start_date_time,
    end_date_time,
    police_district_number
);