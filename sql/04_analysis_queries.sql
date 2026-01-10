-- Crimes per year
SELECT
    year,
    COUNT(*) AS total_crimes
FROM chicago.crime_subset
GROUP BY year
ORDER BY year;

-- Arrest rate by crime type
SELECT
    primary_type,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN arrest THEN 1 ELSE 0 END) AS arrests,
    ROUND(
        100.0 * SUM(CASE WHEN arrest THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS arrest_rate_percent
FROM chicago.crime_subset
GROUP BY primary_type
ORDER BY arrest_rate_percent DESC;
