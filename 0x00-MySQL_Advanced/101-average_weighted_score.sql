-- Script to create a stored procedure to compute and store the average weighted scores for all students

DELIMITER //

-- Create the procedure with one input
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers ()
BEGIN
-- Declare the variables to be used
    DECLARE done INT DEFAULT FALSE;
    DECLARE user_id INT;
    DECLARE total_score_weight FLOAT;
    DECLARE total_weights FLOAT;
    DECLARE average_weighted_score FLOAT;
    DECLARE user_cursor CURSOR FOR SELECT id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN user_cursor;

    -- Loop through all users
    read_loop: LOOP
        FETCH user_cursor INTO user_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

    -- Initialize these with a value of 0
        SET total_score_weight = 0;
        SET total_weights = 0;
    -- Calculate the total weighted score and sum of weights from corrections table and projects table
        SELECT SUM(c.score * p.weight), SUM(p.weight)
        INTO total_score_weight, total_weights
        FROM corrections c
        JOIN projects p ON c.project_id = p.id
        WHERE c.user_id = user_id;

        IF total_weights > 0 THEN
            SET average_weighted_score = total_score_weight / total_weights;
        ELSE
            SET average_weighted_score = NULL;
        END IF;

    -- Update the average score on the users table
        UPDATE users
        SET average_score = average_weighted_score
        where id = user_id;
    END LOOP;

    -- Close the cursor
    CLOSE user_cursor;
END //

DELIMITER ;
