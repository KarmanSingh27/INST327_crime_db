USE montgomery_crime_db;

INSERT INTO cities (city_name, state, zip_code, place)
SELECT DISTINCT city, state, zip_code, place
FROM raw_data
WHERE city IS NOT NULL
  AND state IS NOT NULL;

INSERT INTO addresses (
    block_address,
    address_number,
    street_prefix,
    street_name,
    street_suffix,
    street_type,
    city_id
)
SELECT DISTINCT
    r.block_address,
    r.address_number,
    r.street_prefix,
    r.street_name,
    r.street_suffix,
    r.street_type,
    c.city_id
FROM raw_data r
JOIN cities c
    ON r.city = c.city_name
   AND r.state = c.state
   AND (r.zip_code <=> c.zip_code)
   AND (r.place <=> c.place);

INSERT INTO crimes (
    offence_code,
    crime_name1,
    crime_name2,
    crime_name3
)
SELECT DISTINCT
    offence_code,
    crime_name1,
    crime_name2,
    crime_name3
FROM raw_data
WHERE offence_code IS NOT NULL;

INSERT INTO police_districts (
    police_district_number,
    police_district_name
)
SELECT DISTINCT
    police_district_number,
    police_district_name
FROM raw_data
WHERE police_district_number IS NOT NULL;

INSERT INTO time_tbl (
    start_date_time,
    end_date_time,
    incident_year,
    incident_month,
    incident_day,
    incident_hour,
    incident_weekday
)
SELECT DISTINCT
    start_date_time,
    end_date_time,
    YEAR(start_date_time),
    MONTH(start_date_time),
    DAY(start_date_time),
    HOUR(start_date_time),
    DAYNAME(start_date_time)
FROM raw_data
WHERE start_date_time IS NOT NULL
  AND YEAR(start_date_time) BETWEEN 2017 AND 2020;

INSERT INTO incidents (
    incident_id,
    cr_number,
    police_district_number,
    time_id
)
SELECT DISTINCT
    r.incident_id,
    r.cr_number,
    r.police_district_number,
    t.time_id
FROM raw_data r
JOIN time_tbl t
    ON r.start_date_time = t.start_date_time
   AND (r.end_date_time <=> t.end_date_time)
WHERE r.incident_id IS NOT NULL
  AND YEAR(r.start_date_time) BETWEEN 2017 AND 2020;

INSERT INTO victims (
    incident_id,
    victim_count
)
SELECT DISTINCT
    incident_id,
    victims
FROM raw_data
WHERE incident_id IS NOT NULL
  AND YEAR(start_date_time) BETWEEN 2017 AND 2020;

INSERT INTO specific_incidents (
    incident_id,
    address_id,
    victim_id,
    offence_code
)
SELECT DISTINCT
    r.incident_id,
    a.address_id,
    v.victim_id,
    r.offence_code
FROM raw_data r
JOIN cities c
    ON r.city = c.city_name
   AND r.state = c.state
   AND (r.zip_code <=> c.zip_code)
   AND (r.place <=> c.place)
JOIN addresses a
    ON (r.block_address <=> a.block_address)
   AND (r.address_number <=> a.address_number)
   AND (r.street_prefix <=> a.street_prefix)
   AND (r.street_name <=> a.street_name)
   AND (r.street_suffix <=> a.street_suffix)
   AND (r.street_type <=> a.street_type)
   AND c.city_id = a.city_id
JOIN victims v
    ON r.incident_id = v.incident_id
WHERE r.incident_id IS NOT NULL
  AND r.offence_code IS NOT NULL
  AND YEAR(r.start_date_time) BETWEEN 2017 AND 2020;