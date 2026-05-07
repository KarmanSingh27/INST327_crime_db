USE montgomery_crime_db;

CREATE OR REPLACE VIEW view_crime_frequency AS
SELECT 
    cr.crime_name1,
    cr.crime_name2,
    COUNT(*) AS total_incidents
FROM specific_incidents si
JOIN crimes cr 
    ON si.offence_code = cr.offence_code
GROUP BY cr.crime_name1, cr.crime_name2;

CREATE OR REPLACE VIEW view_crime_by_city AS
SELECT 
    c.city_name,
    cr.crime_name2,
    COUNT(*) AS total_incidents
FROM specific_incidents si
JOIN addresses a 
    ON si.address_id = a.address_id
JOIN cities c 
    ON a.city_id = c.city_id
JOIN crimes cr 
    ON si.offence_code = cr.offence_code
GROUP BY c.city_name, cr.crime_name2;

CREATE OR REPLACE VIEW view_incidents_by_hour AS
SELECT 
    t.incident_hour,
    COUNT(*) AS total_incidents
FROM incidents i
JOIN time_tbl t 
    ON i.time_id = t.time_id
GROUP BY t.incident_hour;

CREATE OR REPLACE VIEW view_multiple_victim_incidents AS
SELECT 
    i.incident_id,
    i.cr_number,
    v.victim_count,
    pd.police_district_name
FROM incidents i
JOIN victims v 
    ON i.incident_id = v.incident_id
JOIN police_districts pd 
    ON i.police_district_number = pd.police_district_number
WHERE v.victim_count > 1;

CREATE OR REPLACE VIEW view_crime_by_police_district AS
SELECT 
    pd.police_district_number,
    pd.police_district_name,
    cr.crime_name2,
    COUNT(*) AS total_incidents
FROM specific_incidents si
JOIN incidents i 
    ON si.incident_id = i.incident_id
JOIN police_districts pd 
    ON i.police_district_number = pd.police_district_number
JOIN crimes cr 
    ON si.offence_code = cr.offence_code
GROUP BY 
    pd.police_district_number,
    pd.police_district_name,
    cr.crime_name2;

CREATE OR REPLACE VIEW view_incidents_by_year AS
SELECT 
    t.incident_year,
    COUNT(*) AS total_incidents
FROM incidents i
JOIN time_tbl t 
    ON i.time_id = t.time_id
GROUP BY t.incident_year;

CREATE OR REPLACE VIEW view_city_totals AS
SELECT 
    c.city_name,
    COUNT(*) AS total_incidents
FROM specific_incidents si
JOIN addresses a 
    ON si.address_id = a.address_id
JOIN cities c 
    ON a.city_id = c.city_id
GROUP BY c.city_name;