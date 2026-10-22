
-- Fashek Store
-- Portfolio 1: Database Design and Implementation
-- Purpose: Test foreign-key and CHECK constraints.
-- IMPORTANT: These invalid INSERT statements are expected
-- to fail. Run each test separately.

-- TEST 1: Foreign-key constraint.
-- Customer ID 9999 should not exist.
-- Expected: Foreign-key violation.
INSERT INTO orders (customer_id, status)
VALUES (9999, 'Pending');


-- TEST 2: CHECK constraint.
-- Product price must be greater than zero.
-- Expected: CHECK constraint violation.
INSERT INTO products (product_name, size, colour, price)
VALUES ('Test Shirt', 'M', 'Red', 0);
