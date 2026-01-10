-- sql/06_views.sql
-- Reusable views for analysis

-- 1) Yearly crime summary
CREATE OR REPLACE VIEW chicago.v_yearly_crime_summary AS
SELECT
    year,
    COUNT(*) AS total_crimes,
    SUM(CASE WHEN arrest THEN 1 ELSE 0 END) AS total_arrests,
    ROUND(100.0 * SUM(CASE WHEN arrest THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS arrest_rate_percent
FROM chicago.crime_subset
WHERE year IS NOT NULL
GROUP BY year;

-- 2) Monthly crime trend
CREATE OR REPLACE VIEW chicago.v_monthly_crime_trend AS
SELECT
    DATE_TRUNC('month', crime_date)::DATE AS month,
    COUNT(*) AS total_crimes
FROM chicago.crime_subset
WHERE crime_date IS NOT NULL
GROUP BY month;

-- 3) Arrest rate by primary type (min 50 cases)
CREATE OR REPLACE VIEW chicago.v_arrest_rate_by_primary_type AS
SELECT
    primary_type,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN arrest THEN 1 ELSE 0 END) AS arrests,
    ROUND(100.0 * SUM(CASE WHEN arrest THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS arrest_rate_percent
FROM chicago.crime_subset
WHERE primary_type IS NOT NULL AND primary_type <> ''
GROUP BY primary_type
HAVING COUNT(*) >= 50;
