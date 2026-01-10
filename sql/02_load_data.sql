-- sql/02_load_data.sql
-- Load Chicago crime subset data into PostgreSQL

COPY chicago.crime_subset (
    crime_id,
    case_number,
    crime_date,
    primary_type,
    description,
    location_description,
    arrest,
    domestic,
    community_area,
    year,
    latitude,
    longitude
)
FROM '/path/to/chicago_crime_subset.csv'
DELIMITER ','
CSV HEADER;
