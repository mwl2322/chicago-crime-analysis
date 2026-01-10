-- sql/05_optimization.sql
-- Performance checks and indexing examples for chicago.crime_subset

-- After loading data, update planner statistics (recommended)
ANALYZE chicago.crime_subset;

-- 1) Check query plan for a common filter pattern (year + primary_type)
EXPLAIN (ANALYZE, BUFFERS)
SELECT crime_id, crime_date, primary_type, arrest
FROM chicago.crime_subset
WHERE year = 2022
  AND primary_type = 'THEFT';

-- 2) If you frequently filter on BOTH year and primary_type together,
-- a composite index can outperform two single-column indexes.
-- Create it, then re-run the EXPLAIN above and compare.
CREATE INDEX IF NOT EXISTS idx_subset_year_primary_type
    ON chicago.crime_subset (year, primary_type);

-- Re-check plan after adding composite index
EXPLAIN (ANALYZE, BUFFERS)
SELECT crime_id, crime_date, primary_type, arrest
FROM chicago.crime_subset
WHERE year = 2022
  AND primary_type = 'THEFT';

-- 3) Example: aggregation performance (often used in analysis)
EXPLAIN (ANALYZE, BUFFERS)
SELECT primary_type, COUNT(*) AS total_cases
FROM chicago.crime_subset
WHERE year = 2022
GROUP BY primary_type
ORDER BY total_cases DESC;
