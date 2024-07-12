-- Script to create an index to a table

-- DROP INDEX idx_name_first ON names;

-- Generate a new column for the first letter of each name
ALTER TABLE names
ADD COLUMN name VARCHAR(1) GENERATED ALWAYS AS (SUBSTRING(name, 1, 1)) STORED;

-- Create the index on the column generated for the first letter
CREATE INDEX idx_name_first ON names (idx_first_letter);
