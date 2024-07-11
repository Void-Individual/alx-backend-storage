-- Script to list all the bands with a sppecific style, ranked

CREATE TEMPORARY TABLE glam_rock_style AS
SELECT
    band_name,
    style,
    formed,
    COALESCE(split, 2022) AS split,
    (COALESCE(split, 2022) - formed) as lifespan
FROM
    metal_bands
WHERE
    style LIKE '%Glam rock%';

SELECT band_name, lifespan FROM glam_rock_style ORDER BY lifespan DESC;
