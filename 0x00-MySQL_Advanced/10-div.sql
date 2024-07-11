-- Script to create a function that divides the firts by the second number and returns it
-- or return 0 if the second number is 0

DELIMITER //

CREATE FUNCTION SafeDiv (a INT, b INT)
RETURNS FLOAT
DETERMINISTIC

BEGIN
    DECLARE result FLOAT;
    IF b = 0 THEN
       SET result = 0;
    ELSE
        SET result = a DIV b;
    END IF;

    RETURN result;
END //

DELIMITER ;
