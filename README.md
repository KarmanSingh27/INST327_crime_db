# INST327_crime_db
This is for our INST327 project we are looking at a database for crime in montgomery county

Group Members

* Tiffany Bonilla
* Skye Crane
* Timothy Likhachoff
* Karman Singh
* Samuel Williams

Course Information

* Course: INST327 – Database Design and Modeling
* Professor: Prof. Dewitt
* Semester: Spring 2026

⸻

Project Overview

This project is a relational database system designed to organize and analyze crime data from Montgomery County, Maryland. The database was built using MySQL and focuses specifically on crime incidents that occurred during the month of February between 2017 and 2020.

The purpose of this project was to take a large raw CSV dataset and transform it into a normalized relational database structure that supports efficient querying, filtering, aggregation, and analysis of crime trends.

The database allows users to:

* Analyze crime trends over time
* View crime patterns by city or police district
* Identify common offense types
* Explore incident and victim information
* Perform SQL-based analytical queries using views

⸻

Dataset Source

The dataset used for this project comes from the Montgomery County Open Data Portal.

Dataset:

* Montgomery County Crime Dataset
* https://data.montgomerycountymd.gov/Public-Safety/Crime/icn6-v9z3/about_data

⸻

Technologies Used

* MySQL
* MySQL Workbench
* SQL
* CSV Importing
* GitHub

⸻

Database Features

Logical Design

The database was normalized into approximately Third Normal Form (3NF) to reduce redundancy and improve consistency. Main entities include:

* incidents
* crimes
* addresses
* cities
* victims
* police districts
* specific_incidents
* raw_data staging table

Relationships were implemented using primary keys and foreign keys.

⸻

Physical Design

The database was implemented in MySQL Workbench using:

* Primary keys
* Foreign keys
* Appropriate datatypes (INT, VARCHAR, DATETIME)
* SQL views
* Staging table (raw_data) for preprocessing

⸻

Data Cleaning Process

Before insertion into normalized tables, the dataset required extensive cleaning due to:

* inconsistent formatting
* extra whitespace
* duplicate values
* blank strings
* invalid date formats

We used SQL functions such as:

* TRIM()
* NULLIF()
* datatype conversions

The raw_data staging table was created to simplify debugging and data transformation before inserting records into the final relational tables.

⸻

Views Included

The project includes multiple SQL views demonstrating CRUD “read” operations and advanced querying techniques.

Examples include:

* crime incidents with offense details
* crime counts by city
* district crime statistics
* high victim incidents
* monthly crime totals

The views demonstrate:

* JOIN operations
* filtering (WHERE, HAVING)
* aggregation (COUNT, GROUP BY)
* linking tables
* subqueries
