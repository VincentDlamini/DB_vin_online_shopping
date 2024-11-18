USE vin_online_shopping;

SHOW procedure status WHERE db = 'vin_online_shopping';

SHOW PROCEDURE STATUS WHERE Name = 'SelectAllCustomers';

-- === ST_TC-001 ===
use vin_online_shopping;

-- === ST_TC-002 ===
show tables;

-- === ST_TC-003 ===
SELECT count(*) AS NumberOfColumns FROM information_schema.columns WHERE table_name = 'customers';
SELECT count(*) AS NumberOfColumns FROM information_schema.columns WHERE table_name = 'categories';
SELECT count(*) AS NumberOfColumns FROM information_schema.columns WHERE table_name = 'ordered_items';
SELECT count(*) AS NumberOfColumns FROM information_schema.columns WHERE table_name = 'orders';
SELECT count(*) AS NumberOfColumns FROM information_schema.columns WHERE table_name = 'payments';
SELECT count(*) AS NumberOfColumns FROM information_schema.columns WHERE table_name = 'products';

CALL NumberOfColumns('categories');

-- === ST_TC-004 ===
SELECT column_name FROM information_schema.columns WHERE table_name = 'customers';
SELECT column_name FROM information_schema.columns WHERE table_name = 'categories';
SELECT column_name FROM information_schema.columns WHERE table_name = 'ordered_items';
SELECT column_name FROM information_schema.columns WHERE table_name = 'orders';
SELECT column_name FROM information_schema.columns WHERE table_name = 'payments';
SELECT column_name FROM information_schema.columns WHERE table_name = 'products';

CALL column_names('payments');

-- === ST_TC-005 ===
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'customers';
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'categories';
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'ordered_items';
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'orders';
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'payments';
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'products';

CALL datatypes('products');

-- === ST_TC-006 ===
SELECT column_name, column_type FROM information_schema.columns WHERE table_name = 'customers';
SELECT column_name, column_type FROM information_schema.columns WHERE table_name = 'categories';
SELECT column_name, column_type FROM information_schema.columns WHERE table_name = 'ordered_items';
SELECT column_name, column_type FROM information_schema.columns WHERE table_name = 'orders';
SELECT column_name, column_type FROM information_schema.columns WHERE table_name = 'payments';
SELECT column_name, column_type FROM information_schema.columns WHERE table_name = 'products';

CALL colSize('ordered_items');

-- === ST_TC-007 ===
SELECT column_name, is_nullable FROM information_schema.columns WHERE table_name = 'customers';
SELECT column_name, is_nullable FROM information_schema.columns WHERE table_name = 'categories';
SELECT column_name, is_nullable FROM information_schema.columns WHERE table_name = 'ordered_items';
SELECT column_name, is_nullable FROM information_schema.columns WHERE table_name = 'orders';
SELECT column_name, is_nullable FROM information_schema.columns WHERE table_name = 'payments';
SELECT column_name, is_nullable FROM information_schema.columns WHERE table_name = 'products';

CALL nullFields('payments');

-- === ST_TC-008 ===
SELECT column_name, column_key FROM information_schema.columns WHERE table_name = 'customers';
SELECT column_name, column_key FROM information_schema.columns WHERE table_name = 'categories';
SELECT column_name, column_key FROM information_schema.columns WHERE table_name = 'ordered_items';
SELECT column_name, column_key FROM information_schema.columns WHERE table_name = 'orders';
SELECT column_name, column_key FROM information_schema.columns WHERE table_name = 'payments';
SELECT column_name, column_key FROM information_schema.columns WHERE table_name = 'products';

CALL column_keys('ordered_items');