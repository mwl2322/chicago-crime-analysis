-- sql/02_load_data.sql
-- Load Chicago crime subset data into PostgreSQL
-- Tip:
--   - Use \copy (psql client-side) for local files (most portable).
--   - If you are running this on the DB server and the file is accessible to the server user, you can use COPY instead.

-- Option A (recommended): psql client-side load
\copy chicago.crime_subset (
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
FROM 'data/chicago_crime_subset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL '');

-- Option B (server-side): only if the CSV is on the database server
-- COPY chicago.crime_subset (
--     crime_id, case_number, crime_date, primary_type, description,
--     location_description, arrest, domestic, community_area, year, latitude, longitude
-- )
-- FROM '/absolute/server/path/chicago_crime_subset.csv'
-- WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL '');
