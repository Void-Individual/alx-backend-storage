-- Script to create a procedure to add a new correction for a student

DELIMITER //

CREATE PROCEDURE AddBonus (
    IN user_id INT,
    IN project_name VARCHAR(255),
    IN score INT)
BEGIN
    -- Create a new variable
    DECLARE project_id INT;

    -- Check if project_name exists on the table and save the id
    SELECT id INTO project_id FROM projects WHERE name = project_name LIMIT 1;

    if project_id IS NULL THEN
    -- Insert new project_name into the projects table
        INSERT INTO projects (name) VALUES (project_name);
        SET project_id = LAST_INSERT_ID(); -- Get the last autogenerated project_id
    END IF;

    -- Insert the correction into the corrections table
    INSERT INTO corrections (user_id, project_id, score)
    VALUES (user_id, project_id, score);

END //

-- Reset the delimiter
DELIMITER ;
