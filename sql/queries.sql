USE montgomery_crime_db;

SELECT * FROM view_crime_frequency
ORDER BY total_incidents DESC;

SELECT * FROM view_crime_by_city
ORDER BY city_name, total_incidents DESC;

SELECT * FROM view_incidents_by_hour
ORDER BY total_incidents DESC;

SELECT * FROM view_multiple_victim_incidents
ORDER BY victim_count DESC;

SELECT * FROM view_crime_by_police_district
ORDER BY police_district_number, total_incidents DESC;

SELECT * FROM view_incidents_by_year
ORDER BY incident_year;

SELECT * FROM view_city_totals
ORDER BY total_incidents DESC;

SELECT COUNT(*) AS raw_data_rows FROM raw_data;
SELECT COUNT(*) AS city_rows FROM cities;
SELECT COUNT(*) AS address_rows FROM addresses;
SELECT COUNT(*) AS crime_rows FROM crimes;
SELECT COUNT(*) AS police_district_rows FROM police_districts;
SELECT COUNT(*) AS time_rows FROM time_tbl;
SELECT COUNT(*) AS incident_rows FROM incidents;
SELECT COUNT(*) AS victim_rows FROM victims;
SELECT COUNT(*) AS specific_incident_rows FROM specific_incidents;