CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `montgomery_crime_db`.`view_city_totals` AS
    SELECT 
        `c`.`city_name` AS `city_name`,
        COUNT(0) AS `total_incidents`
    FROM
        ((`montgomery_crime_db`.`specific_incidents` `si`
        JOIN `montgomery_crime_db`.`addresses` `a` ON ((`si`.`address_id` = `a`.`address_id`)))
        JOIN `montgomery_crime_db`.`cities` `c` ON ((`a`.`city_id` = `c`.`city_id`)))
    GROUP BY `c`.`city_name`