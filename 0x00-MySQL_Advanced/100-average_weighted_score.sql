-- Script to create a stored procedure to compute and store the average weighted scores for a student

DELIMITER //

-- Create the procedure with one input
CREATE PROCEDURE ComputeAverageWeightedScoreForUser (IN user_id INT)
BEGIN
-- Declare the variables to be used
    DECLARE total_score_weight FLOAT;
    DECLARE total_weights FLOAT;
    DECLARE average_weighted_score FLOAT;
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
END //

DELIMITER ;
