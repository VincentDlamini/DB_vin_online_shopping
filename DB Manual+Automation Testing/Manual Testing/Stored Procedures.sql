USE vin_online_shopping;

-- Stored Procedures

	-- Customers table
DELIMITER //
CREATE PROCEDURE SelectAllCustomers()
BEGIN
	SELECT * FROM customers;
END //
DELIMITER ;

	-- Categories table
DELIMITER //
CREATE PROCEDURE SelectAllCategories()
BEGIN
	SELECT * FROM categories;
END //
DELIMITER ;

	-- Ordered Items table
DELIMITER //
CREATE PROCEDURE SelectAllOrdedItems()
BEGIN
	SELECT * FROM ordered_items;
END //
DELIMITER ;

	-- Ordered table
DELIMITER //
CREATE PROCEDURE SelectAllOrders()
BEGIN
	SELECT * FROM orders;
END //
DELIMITER ;

	-- Payments table
DELIMITER //
CREATE PROCEDURE SelectAllPayments()
BEGIN
	SELECT * FROM payments;
END //

DELIMITER ;

	-- Products table
DELIMITER //
CREATE PROCEDURE SelectAllProducts()
BEGIN
	SELECT * FROM products;
END //
DELIMITER ;

	-- Delete from all tables
DELIMITER //
CREATE PROCEDURE DeleteAllMultipleTablesData()
BEGIN
	DELETE FROM payments WHERE payment_id = 600;
    DELETE FROM ordered_items WHERE ordered_item_id = 500;
    DELETE FROM orders WHERE order_id = 400;
    DELETE FROM products WHERE product_id IN (200, 201, 202, 203, 204, 205, 206);
    DELETE FROM categories WHERE category_id IN (300, 301, 302, 303, 304);
	DELETE FROM customers WHERE customer_id IN (100, 101, 102);
END //
DELIMITER ;

-- Verify the number of columns in table
DELIMITER //
CREATE PROCEDURE NumberOfColumns(IN countCol VARCHAR (50))
BEGIN
	SELECT count(*) AS NumberOfColumns FROM information_schema.columns WHERE table_name = countCol;
END //
DELIMITER ;

-- Check column names in the tables
DELIMITER //
CREATE PROCEDURE column_names(IN colName VARCHAR (50))
BEGIN
	SELECT column_name FROM information_schema.columns WHERE table_name = colName;
END //
DELIMITER ;

-- Confirm datatypes of columns on tables
DELIMITER //
CREATE PROCEDURE datatypes(IN dTypes VARCHAR (50))
BEGIN
	SELECT column_name, data_type FROM information_schema.columns WHERE table_name = dTypes;
END //
DELIMITER ;

-- Check column size in a table
DELIMITER //
CREATE PROCEDURE colSize(IN size VARCHAR (50))
BEGIN
	SELECT column_name, column_type FROM information_schema.columns WHERE table_name = size;
END //
DELIMITER ;

-- Verify null fields in tables
DELIMITER //
CREATE PROCEDURE nullFields(IN nullField VARCHAR (50))
BEGIN
	SELECT column_name, is_nullable FROM information_schema.columns WHERE table_name = nullField;
END //
DELIMITER ;

-- Check column keys in tables
DELIMITER //
CREATE PROCEDURE column_keys(IN colKeys VARCHAR (50))
BEGIN
	SELECT column_name, column_key FROM information_schema.columns WHERE table_name = colKeys;
END //
DELIMITER ;