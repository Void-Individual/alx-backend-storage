-- Script to rank country origins of bands

-- Create a temp table to hold the vlaues that we need
CREATE TEMPORARY TABLE metal_bands_sorted AS
SELECT
-- Select the 2 columns that you need from the desired table
    origin,
-- Collect all the fans for each origin selected and sum any similar ones
    SUM(fans) AS nb_fans
FROM
    metal_bands
GROUP BY
    origin;

-- Now select the new created columns from the temp table
SELECT origin, nb_fans FROM metal_bands_sorted ORDER BY nb_fans DESC;
