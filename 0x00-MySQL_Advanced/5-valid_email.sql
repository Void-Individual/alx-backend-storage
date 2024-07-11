-- Script to create a trigger to reset the attribute valid email only when email is changed

DELIMITER //

-- Create a new trigger
CREATE TRIGGER check_email
-- MySQL does not allow a trigger to update a table after it has been called so
-- you have to do it before it is updated
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
-- If the email volumn is changed, this condition should run
    IF NEW.email != OLD.email THEN
        SET NEW.valid_email = 0;
    END IF;
END //

DELIMITER ;
