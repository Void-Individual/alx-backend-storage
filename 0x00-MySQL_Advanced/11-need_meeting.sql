-- Script to creat a view that lists all students in a specified range condition

DELIMITER //

CREATE VIEW need_meeting AS
SELECT name
FROM students
WHERE (score < 80 AND (last_meeting IS NULL OR last_meeting <= DATE_SUB(NOW(), INTERVAL 1 MONTH)));

DELIMITER ;
