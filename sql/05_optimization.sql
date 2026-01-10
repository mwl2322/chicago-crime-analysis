-- Check index usage
EXPLAIN ANALYZE
SELECT *
FROM chicago.crime_subset
WHERE year = 2022
  AND primary_type = 'THEFT';
