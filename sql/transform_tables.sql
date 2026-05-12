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
    NULLIF(TRIM(r.block_address), ''),
    CAST(NULLIF(TRIM(r.address_number), '') AS UNSIGNED),
    NULLIF(TRIM(r.street_prefix), ''),
    NULLIF(TRIM(r.street_name), ''),
    NULLIF(TRIM(r.street_suffix), ''),
    NULLIF(TRIM(r.street_type), ''),
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
    STR_TO_DATE(NULLIF(TRIM(start_date_time), ''), '%c/%e/%Y %H:%i'),
    STR_TO_DATE(NULLIF(TRIM(end_date_time), ''), '%c/%e/%Y %H:%i'),

    YEAR(STR_TO_DATE(NULLIF(TRIM(start_date_time), ''), '%c/%e/%Y %H:%i')),
    MONTH(STR_TO_DATE(NULLIF(TRIM(start_date_time), ''), '%c/%e/%Y %H:%i')),
    DAY(STR_TO_DATE(NULLIF(TRIM(start_date_time), ''), '%c/%e/%Y %H:%i')),
    HOUR(STR_TO_DATE(NULLIF(TRIM(start_date_time), ''), '%c/%e/%Y %H:%i')),
    DAYNAME(STR_TO_DATE(NULLIF(TRIM(start_date_time), ''), '%c/%e/%Y %H:%i'))

FROM raw_data

WHERE NULLIF(TRIM(start_date_time), '') IS NOT NULL
  AND STR_TO_DATE(NULLIF(TRIM(start_date_time), ''), '%c/%e/%Y %H:%i') IS NOT NULL
  AND YEAR(STR_TO_DATE(NULLIF(TRIM(start_date_time), ''), '%c/%e/%Y %H:%i')) BETWEEN 2017 AND 2020;

INSERT INTO incidents (
    incident_id,
    cr_number,
    police_district_number,
    time_id
)
SELECT DISTINCT
    CAST(NULLIF(TRIM(r.incident_id), '') AS UNSIGNED),
    NULLIF(TRIM(r.cr_number), ''),
    NULLIF(TRIM(r.police_district_number), ''),
    t.time_id
FROM raw_data r
JOIN time_tbl t
    ON STR_TO_DATE(NULLIF(TRIM(r.start_date_time), ''), '%c/%e/%Y %H:%i') = t.start_date_time
   AND (
        STR_TO_DATE(NULLIF(TRIM(r.end_date_time), ''), '%c/%e/%Y %H:%i') <=> t.end_date_time
   )
WHERE NULLIF(TRIM(r.incident_id), '') IS NOT NULL
  AND STR_TO_DATE(NULLIF(TRIM(r.start_date_time), ''), '%c/%e/%Y %H:%i') IS NOT NULL
  AND YEAR(STR_TO_DATE(NULLIF(TRIM(r.start_date_time), ''), '%c/%e/%Y %H:%i')) BETWEEN 2017 AND 2020;

INSERT INTO victims (
    incident_id,
    victim_count
)
SELECT DISTINCT
    CAST(NULLIF(TRIM(r.incident_id), '') AS UNSIGNED),
    CAST(NULLIF(TRIM(r.victims), '') AS UNSIGNED)
FROM raw_data r
JOIN incidents i
    ON CAST(NULLIF(TRIM(r.incident_id), '') AS UNSIGNED) = i.incident_id
WHERE NULLIF(TRIM(r.incident_id), '') IS NOT NULL
  AND STR_TO_DATE(NULLIF(TRIM(r.start_date_time), ''), '%c/%e/%Y %H:%i') IS NOT NULL
  AND YEAR(STR_TO_DATE(NULLIF(TRIM(r.start_date_time), ''), '%c/%e/%Y %H:%i')) BETWEEN 2017 AND 2020;

INSERT INTO specific_incidents (
    incident_id,
    address_id,
    victim_id,
    offence_code
)
SELECT DISTINCT
    CAST(NULLIF(TRIM(r.incident_id), '') AS UNSIGNED),
    a.address_id,
    v.victim_id,
    NULLIF(TRIM(r.offence_code), '')
FROM raw_data r
JOIN cities c
    ON NULLIF(TRIM(r.city), '') = c.city_name
   AND NULLIF(TRIM(r.state), '') = c.state
   AND (NULLIF(TRIM(r.zip_code), '') <=> c.zip_code)
   AND (NULLIF(TRIM(r.place), '') <=> c.place)
JOIN addresses a
    ON (NULLIF(TRIM(r.block_address), '') <=> a.block_address)
   AND (CAST(NULLIF(TRIM(r.address_number), '') AS UNSIGNED) <=> a.address_number)
   AND (NULLIF(TRIM(r.street_prefix), '') <=> a.street_prefix)
   AND (NULLIF(TRIM(r.street_name), '') <=> a.street_name)
   AND (NULLIF(TRIM(r.street_suffix), '') <=> a.street_suffix)
   AND (NULLIF(TRIM(r.street_type), '') <=> a.street_type)
   AND c.city_id = a.city_id
JOIN victims v
    ON CAST(NULLIF(TRIM(r.incident_id), '') AS UNSIGNED) = v.incident_id
WHERE NULLIF(TRIM(r.incident_id), '') IS NOT NULL
  AND NULLIF(TRIM(r.offence_code), '') IS NOT NULL
  AND STR_TO_DATE(NULLIF(TRIM(r.start_date_time), ''), '%c/%e/%Y %H:%i') IS NOT NULL
  AND YEAR(STR_TO_DATE(NULLIF(TRIM(r.start_date_time), ''), '%c/%e/%Y %H:%i')) BETWEEN 2017 AND 2020;