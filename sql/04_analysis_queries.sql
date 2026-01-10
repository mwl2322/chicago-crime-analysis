-- sql/04_analysis_queries.sql
-- Analysis queries for chicago.crime_subset

-- 1) Crimes per year
SELECT
    year,
    COUNT(*) AS total_crimes
FROM chicago.crime_subset
GROUP BY year
ORDER BY year;

-- 2) Top 10 primary crime types
SELECT
    primary_type,
    COUNT(*) AS total_cases
FROM chicago.crime_subset
WHERE primary_type IS NOT NULL AND primary_type <> ''
GROUP BY primary_type
ORDER BY total_cases DESC
LIMIT 10;

-- 3) Arrest rate by crime type (min 50 cases to avoid tiny-sample noise)
SELECT
    primary_type,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN arrest THEN 1 ELSE 0 END) AS arrests,
    ROUND(
        100.0 * SUM(CASE WHEN arrest THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0),
        2
    ) AS arrest_rate_percent
FROM chicago.crime_subset
WHERE primary_type IS NOT NULL AND primary_type <> ''
GROUP BY primary_type
HAVING COUNT(*) >= 50
ORDER BY arrest_rate_percent DESC, total_cases DESC;

-- 4) Arrest rate over time (by year)
SELECT
    year,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN arrest THEN 1 ELSE 0 END) AS arrests,
    ROUND(100.0 * SUM(CASE WHEN arrest THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS arrest_rate_percent
FROM chicago.crime_subset
WHERE year IS NOT NULL
GROUP BY year
ORDER BY year;

-- 5) Domestic vs non-domestic (counts + percent)
SELECT
    domestic,
    COUNT(*) AS total_cases,
    ROUND(100.0 * COUNT(*) / NULLIF((SELECT COUNT(*) FROM chicago.crime_subset), 0), 2) AS percent_of_total
FROM chicago.crime_subset
GROUP BY domestic
ORDER BY total_cases DESC;

-- 6) Crimes by month (trend)
SELECT
    DATE_TRUNC('month', crime_date)::DATE AS month,
    COUNT(*) AS total_crimes
FROM chicago.crime_subset
WHERE crime_date IS NOT NULL
GROUP BY month
ORDER BY month;

-- 7) Day-of-week pattern
SELECT
    TO_CHAR(crime_date, 'Dy') AS day_name,
    EXTRACT(DOW FROM crime_date) AS dow,
    COUNT(*) AS total_crimes
FROM chicago.crime_subset
WHERE crime_date IS NOT NULL
GROUP BY day_name, dow
ORDER BY dow;

-- 8) Time-of-day distribution (hourly)
SELECT
    EXTRACT(HOUR FROM crime_date) AS hour_of_day,
    COUNT(*) AS total_crimes
FROM chicago.crime_subset
WHERE crime_date IS NOT NULL
GROUP BY hour_of_day
ORDER BY hour_of_day;

-- 9) Community areas with most crimes (Top 15)
SELECT
    community_area,
    COUNT(*) AS total_crimes
FROM chicago.crime_subset
WHERE community_area IS NOT NULL
GROUP BY community_area
ORDER BY total_crimes DESC
LIMIT 15;

-- 10) Top crime types by year (Top 5 per year using window functions)
WITH counts AS (
    SELECT
        year,
        primary_type,
        COUNT(*) AS total_cases,
        ROW_NUMBER() OVER (PARTITION BY year ORDER BY COUNT(*) DESC) AS rn
    FROM chicago.crime_subset
    WHERE year IS NOT NULL AND primary_type IS NOT NULL AND primary_type <> ''
    GROUP BY year, primary_type
)
SELECT
    year,
    primary_type,
    total_cases
FROM counts
WHERE rn <= 5
ORDER BY year, total_cases DESC;
