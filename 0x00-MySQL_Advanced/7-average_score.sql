-- Script to create a stored procedure to compute and store rhe average score for a student

DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser (IN user_id INT)
BEGIN
    DECLARE total FLOAT;
    DECLARE number_of_corrections INT;

    SELECT SUM(score), COUNT(*) INTO total, number_of_corrections
    FROM corrections
    WHERE user_id = user_id;

    -- Check if there have been corrections made
    IF number_of_corrections > 0 THEN
        -- Compute the average score
        SET total = total / number_of_corrections;

        -- Update the users table
        UPDATE users
        SET average_score = total
        WHERE id = user_id;
    ELSE
    -- If there are no corrections
    UPDATE users
    -- Set a default value
    SET average_score = NULL
    WHERE id = user_id;
    END IF;
END //

-- Reset the delimiter
DELIMITER ;
