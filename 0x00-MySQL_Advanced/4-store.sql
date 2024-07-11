-- Script to create a trigger to decrease quantity of an item after a new order

-- Change the end of each statement from ; to // to prevent confusion while parsing
DELIMITER //

CREATE TRIGGER decrease_item_quantity
-- This trigger will be activated after every INSERT call on the orders table
AFTER INSERT ON orders
-- It will only execute once for each row inserted into the table
FOR EACH ROW
-- Begin the trigger body
BEGIN
-- Update the quantity column on the items table
    UPDATE items
    SET quantity = quantity - NEW.number
-- Match the inserted row with the proper name
    WHERE name = NEW.item_name;
-- End the trigger body
END //

-- Reset the delimiter to the default
DELIMITER ;
