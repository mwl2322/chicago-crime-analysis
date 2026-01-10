-- Check for duplicate crime IDs
SELECT crime_id, COUNT(*)
FROM chicago.crime_subset
GROUP BY crime_id
HAVING COUNT(*) > 1;

-- Check missing critical fields
SELECT
    COUNT(*) FILTER (WHERE crime_date IS NULL) AS missing_dates,
    COUNT(*) FILTER (WHERE primary_type IS NULL) AS missing_types
FROM chicago.crime_subset;
