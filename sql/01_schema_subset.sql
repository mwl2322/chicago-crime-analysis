-- sql/01_schema_subset.sql
-- Schema matching the Chicago crime subset used in analysis

CREATE SCHEMA IF NOT EXISTS chicago;

CREATE TABLE IF NOT EXISTS chicago.crime_subset (

crime_id             BIGINT PRIMARY KEY,
case_number          TEXT,
crime_date           TIMESTAMP,
primary_type         TEXT,
description          TEXT,
location_description TEXT,
arrest               BOOLEAN,
domestic             BOOLEAN,
community_area       INTEGER,
year                 INTEGER,
latitude             DOUBLE PRECISION,
longitude            DOUBLE PRECISION
);

-- Indexes to support analysis queries
CREATE INDEX IF NOT EXISTS idx_subset_primary_type
    ON chicago.crime_subset(primary_type);

CREATE INDEX IF NOT EXISTS idx_subset_year
    ON chicago.crime_subset(year);

CREATE INDEX IF NOT EXISTS idx_subset_arrest
    ON chicago.crime_subset(arrest);
