-- sql/03_data_quality_checks.sql
-- Basic data quality checks for chicago.crime_subset

-- 1) Duplicate primary keys (should be 0 rows)
SELECT crime_id, COUNT(*) AS cnt
FROM chicago.crime_subset
GROUP BY crime_id
HAVING COUNT(*) > 1;

-- 2) Missing critical fields (should be low / ideally 0 for key columns)
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE crime_date IS NULL) AS missing_crime_date,
    COUNT(*) FILTER (WHERE primary_type IS NULL OR primary_type = '') AS missing_primary_type,
    COUNT(*) FILTER (WHERE year IS NULL) AS missing_year,
    COUNT(*) FILTER (WHERE arrest IS NULL) AS missing_arrest,
    COUNT(*) FILTER (WHERE domestic IS NULL) AS missing_domestic
FROM chicago.crime_subset;

-- 3) Year and date sanity (spot weird values)
SELECT
    MIN(crime_date) AS min_crime_date,
    MAX(crime_date) AS max_crime_date,
    MIN(year) AS min_year,
    MAX(year) AS max_year
FROM chicago.crime_subset;

-- 4) Rows where extracted year doesn't match crime_date year (should be 0 or explainable)
SELECT COUNT(*) AS year_mismatch_rows
FROM chicago.crime_subset
WHERE crime_date IS NOT NULL
  AND year IS NOT NULL
  AND EXTRACT(YEAR FROM crime_date)::INT <> year;

-- 5) Latitude/Longitude validity checks (Chicago roughly: lat 41–43, lon -88–-87)
SELECT
    COUNT(*) FILTER (WHERE latitude IS NULL OR longitude IS NULL) AS missing_coordinates,
    COUNT(*) FILTER (
        WHERE latitude IS NOT NULL AND (latitude < 41 OR latitude > 43)
    ) AS out_of_range_lat,
    COUNT(*) FILTER (
        WHERE longitude IS NOT NULL AND (longitude < -88 OR longitude > -87)
    ) AS out_of_range_lon
FROM chicago.crime_subset;

-- 6) Community area sanity (Chicago community areas are typically 1–77; allow NULLs)
SELECT
    COUNT(*) FILTER (WHERE community_area IS NULL) AS missing_community_area,
    COUNT(*) FILTER (WHERE community_area IS NOT NULL AND (community_area < 1 OR community_area > 77)) AS invalid_community_area
FROM chicago.crime_subset;
