-- Script to create an index on a table

ALTER TABLE names
ADD COLUMN idx_first_letter VARCHAR(1) GENERATED ALWAYS AS (SUBSTRING(name, 1, 1)) STORED,
ADD COLUMN idx_score INT GENERATED ALWAYS AS (score) STORED;

CREATE INDEX idx_name_first_score ON names (idx_first_letter, idx_score);
