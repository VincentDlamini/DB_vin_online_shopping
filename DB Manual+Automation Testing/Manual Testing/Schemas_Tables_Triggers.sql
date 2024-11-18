CREATE SCHEMA vin_online_shopping;
USE vin_online_shopping;

CREATE TABLE customers (
customer_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR (50) NOT NULL,
last_name VARCHAR (50) NOT NULL,
email VARCHAR (100) NOT NULL,
password VARCHAR (250) NOT NULL,
address VARCHAR (250) NOT NULL,
city VARCHAR (100) NOT NULL,
province VARCHAR (100) NOT NULL,
postal_code INT NOT NULL,
county VARCHAR (250) NOT NULL
);

ALTER TABLE customers AUTO_INCREMENT = 100;

INSERT INTO customers (first_name, last_name, email, password, address, city, province, postal_code, country) VALUES
('Bogani', 'Dlamini', 'BonganiD@yahoo.com', 'Bongani@123', '123 John Doe Street', 'Johannesburg', 'Gauteng', '2001', 'South Africa'),
('John', 'Doe', 'johnD@gmail.com', 'Doe@123', '245 John Doe Street', 'John Doe', 'New York', '3481', 'United State America'),
('Tebogo', 'Zondoo', 'TZ@yahoo.com', 'TZ@123', '123 John Doe Street', 'LiverPool', 'London', '56358', 'England');


DELETE FROM customers WHERE customer_id = 103;		-- Delete single transaction
DELETE FROM customers WHERE customer_id IN (100, 101, 102);		-- Delete multiple transactions


					-- =============================== Categories Section ===============================

CREATE TABLE categories (
category_id INT PRIMARY KEY AUTO_INCREMENT,
category_name VARCHAR (50)
);

ALTER TABLE categories AUTO_INCREMENT = 300;

INSERT INTO categories (category_name) VALUES
('Games'),
('Laptops'),
('Watches'),
('Internet Routers'),
('Phone');

DELETE FROM categories WHERE category_id IN (300, 301, 302, 303, 304);	


					-- =============================== Products Section ===============================
                    
CREATE TABLE products (
product_id INT PRIMARY KEY AUTO_INCREMENT,
product_name VARCHAR (50) NOT NULL,
product_description TEXT,
price DECIMAL (10, 2),
quantity_on_hand INT,
category_id INT
);

ALTER TABLE `vin_online_shopping`.`products`
ADD FOREIGN KEY (`category_id`)
REFERENCES categories (category_id);

ALTER TABLE products AUTO_INCREMENT = 200;

INSERT INTO products (product_name, product_description, price, quantity_on_hand, category_id) VALUES
('iPhone 16', 'Blue Cover', 1149.51, 20, 304),
('iPhone 15', 'Black Cover', 949.43, 13, 304),
('Honor Band 9', 'Black Band', 19.55, 120, 302),
('Lenovo Ideapad', 'Core i3 500GB', 5149.12, 10, 301),
('Huawei MateBook', 'D14 i3 512GB', 6528.43, 5, 301),
('Play Station 5', 'PS5 Digital Slim', 1149.55, 20, 300),
('Huawei B535', 'Home Router', 1253.28, 15, 303);

DELETE FROM products WHERE product_id IN (200, 201, 202, 203, 204, 205, 206);	


					-- =============================== Orders Section ===============================

CREATE TABLE orders (
order_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT,
FOREIGN KEY (customer_id)
REFERENCES customers (customer_id),
order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
total_cost DECIMAL (10, 2)
);

ALTER TABLE orders AUTO_INCREMENT = 400;

DROP TRIGGER IF EXISTS update_payment_amount;

INSERT INTO orders (customer_id) VALUES (100);

DELETE FROM orders WHERE order_id = 400;


					-- =============================== Ordered Items Section ===============================

CREATE TABLE ordered_items (
ordered_item_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT,
FOREIGN KEY (order_id)
REFERENCES orders (order_id),
product_id INT,
FOREIGN KEY (product_id)
REFERENCES products (product_id),
quantit INT,
unit_price DECIMAL (10, 2)
);

ALTER TABLE `vin_online_shopping`.`ordered_items`
ADD COLUMN customer_id INT AFTER ordered_item_id,
ADD FOREIGN KEY (`customer_id`)
REFERENCES customers (`customer_id`);

ALTER TABLE ordered_items AUTO_INCREMENT = 500;

INSERT INTO ordered_items (order_id, product_id, quantity, unit_price) VALUES
(400, 200, 02, 1149.51);

DELETE FROM ordered_items WHERE ordered_item_id = 500;


					-- =============================== Payments Section ===============================

CREATE TABLE payments (
payment_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT,
FOREIGN KEY (order_id)
REFERENCES orders (order_id),
payment_method VARCHAR (50),
payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
amount DECIMAL (10, 2)
);

ALTER TABLE payments AUTO_INCREMENT = 600;

INSERT INTO payments (payment_method) VALUES
('Credit Card');

DELETE FROM payments WHERE payment_id = 600;


CALL SelectAllCustomers;
CALL SelectAllCategories;
CALL SelectAllProducts;
CALL SelectAllOrders;
CALL SelectAllOrdedItems;
CALL SelectAllPayments;

CALL DeleteAllMultipleTablesData;


						-- ==================== Trigger Section  ================================

-- Trigger to update order_id on payments table and ordered_items
DELIMITER //
CREATE TRIGGER update_foreign_keys
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
	UPDATE ordered_items
    SET order_id = NEW.order_id 
    WHERE order_id IS NULL;
    
    UPDATE payments
    SET order_id = NEW.order_id
    WHERE order_id IS NULL;
END;
//
DELIMITER ;

-- Trigger upon insert onto Order_Items table by updating amount column in payments table:
CREATE TRIGGER update_payment_amount
AFTER INSERT ON orders
FOR EACH ROW
    UPDATE payments
    SET amount = (SELECT (total_cost) FROM orders
	WHERE order_id = NEW.order_id)
	WHERE order_id = NEW.order_id;
    
-- Trigger to update order_id on payments table and ordered_items
CREATE TRIGGER update_payment_orderID
AFTER INSERT ON orders
FOR EACH ROW
    UPDATE payments
    SET order_id = (SELECT (order_id) FROM orders
	WHERE order_id = NEW.order_id)
	WHERE order_id = NEW.order_id;

-- Trigger upon insert onto Order_Items table by updating total_cost column in Orders table:
CREATE TRIGGER update_total_cost
AFTER INSERT ON ordered_items
FOR EACH ROW
	UPDATE orders
		SET total_cost = (SELECT sum(unit_price * quantity) FROM ordered_items
        WHERE order_id = NEW.order_id)
		WHERE order_id = NEW.order_id;
        
-- Trigger to update 'quantity_on_hand'on Products table
CREATE TRIGGER update_product_quantity
AFTER INSERT ON ordered_items
FOR EACH ROW
	UPDATE products
		SET quantity_on_hand = quantity_on_hand - NEW.quantity
        WHERE product_id = NEW.product_id;
