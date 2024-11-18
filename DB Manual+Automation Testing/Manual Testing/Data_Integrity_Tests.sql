-- === DI_TC-001 ===

ALTER TABLE customers AUTO_INCREMENT = 100;

INSERT INTO customers (first_name, last_name, email, password, address, city, province, postal_code, country) VALUES
('Bogani', 'Dlamini', 'BonganiD@yahoo.com', 'Bongani@123', '123 John Doe Street', 'Johannesburg', 'Gauteng', '2001', 'South Africa');

INSERT INTO customers (customer_id, first_name, last_name, email, password, address, city, province, postal_code, country) VALUES
(100, 'Bogani', 'Dlamini', 'BonganiD@yahoo.com', 'Bongani@123', '123 John Doe Street', 'Johannesburg', 'Gauteng', '2001', 'South Africa');

INSERT INTO customers (first_name, last_name, email, password, address, city, province, postal_code, country) VALUES
('', '', 'johnD@gmail.com', '', '', '', 'New York', '', 'United State America');

-- === DI_TC-002 ===
INSERT INTO categories (category_name) VALUES
('Laptops');

INSERT INTO categories (category_id, category_name) VALUES
(300, 'Games');

INSERT INTO categories (category_id, category_name) VALUES
('Testing category column size with data longer than the table size of 50');

-- === DI_TC-003 ===
ALTER TABLE products AUTO_INCREMENT = 200;

INSERT INTO products (product_name, product_description, price, quantity_on_hand, category_id) VALUES
('iPhone 16', 'Blue Cover', 1149.51, 20, 300);

INSERT INTO products (product_name, product_description, price, quantity_on_hand, category_id) VALUES
('Lenovo Ideapad', 'Core i3 500GB', 5149.12, 10, 301);

INSERT INTO products (product_name, product_description, price, quantity_on_hand, category_id) VALUES
('iPhone 16', 'Blue Cover', 1145621849.513, 20, 304);

-- === DI_TC-004 ===
ALTER TABLE orders AUTO_INCREMENT = 400;

INSERT INTO orders (customer_id) VALUES (100);
INSERT INTO orders (customer_id) VALUES(200);

-- === DI_TC-005 ===
ALTER TABLE ordered_items AUTO_INCREMENT = 500;

INSERT INTO ordered_items (order_id, product_id, quantity, unit_price) VALUES
(400, 208, 02, 1149.51);

INSERT INTO ordered_items (order_id, product_id, quantity, unit_price) VALUES
(401, 200, 02, 1149.51);

-- === DI_TC-006 ===
ALTER TABLE payments AUTO_INCREMENT = 600;

INSERT INTO payments (order_id, payment_method, amount) VALUES
(400, 'Credit Card', 2299.02);

INSERT INTO payments (order_id, payment_method, amount) VALUES
(500, 'Credit Card', 2299.02);

INSERT INTO payments (order_id, payment_method, amount) VALUES
(400, Credit-Card, 2299.02);

-- === DI_TC-007 ===
DELETE FROM orders WHERE order_id = 400;

-- === DI_TC-008 ===
DELETE FROM customers WHERE customer_id = 100;

DESCRIBE payments;