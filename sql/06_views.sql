-- View for yearly crime summary
CREATE OR REPLACE VIEW chicago.v_yearly_crime_summary AS
SELECT
    year,
    COUNT(*) AS total_crimes,
    SUM(CASE WHEN arrest THEN 1 ELSE 0 END) AS total_arrests
FROM chicago.crime_subset
GROUP BY year;
