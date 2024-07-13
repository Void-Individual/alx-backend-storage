-- Script to create an index to a table

-- Create the index on the first letter of every name on the column
CREATE INDEX idx_name_first ON names (name(1));
