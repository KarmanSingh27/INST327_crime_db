USE montgomery_crime_db;

CREATE OR REPLACE VIEW crime_count_by_city AS
SELECT c.city_name, cr.crime_name2, COUNT(*) AS total_incidents
FROM specific_incidents si
JOIN addresses a ON si.address_id = a.address_id
JOIN cities c ON a.city_id = c.city_id
JOIN crimes cr ON si.offence_code = cr.offence_code
GROUP BY c.city_name, cr.crime_name2;

CREATE OR REPLACE VIEW crime_count_by_hour AS
SELECT t.incident_hour, COUNT(*) AS total_incidents
FROM incidents i
JOIN time_dim t ON i.time_id = t.time_id
GROUP BY t.incident_hour;

SELECT cr.crime_name2, COUNT(*) AS crime_amount
FROM specific_incidents si
JOIN crimes cr ON si.offence_code = cr.offence_code
GROUP BY cr.crime_name2
ORDER BY crime_amount DESC;
