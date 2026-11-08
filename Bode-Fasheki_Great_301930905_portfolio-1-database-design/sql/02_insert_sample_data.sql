
-- Fashek Store
-- Portfolio 1: Database Design and Implementation
-- Purpose: Insert sample customers, products, orders,
-- order items, and payment records.

-- 1. Insert customers
INSERT INTO customers (full_name, phone, email)
VALUES
    ('Tobi Ade', '08030000001', 'tobi.test@example.com'),
    ('Ada Bello', '08030000002', 'ada.test@example.com'),
    ('Kunle James', '08030000003', 'kunle.test@example.com');

-- 2. Insert products
INSERT INTO products (product_name, size, colour, price)
VALUES
    ('Vintage Shirt', 'M', 'Cream', 15000.00),
    ('Bootcut Trousers', '32', 'Black', 25000.00),
    ('Henley Shirt', 'L', 'Wine', 18000.00);

-- 3. Insert two orders for Tobi Ade.
-- Assumes the sample customer IDs are 1, 2, and 3.
INSERT INTO orders (customer_id, status)
VALUES
    (1, 'Pending'),
    (1, 'Paid');

-- 4. Add a Vintage Shirt to the first order.
-- Assumes order ID 1 and product ID 1.
INSERT INTO order_items
    (order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 1, 15000.00);

-- 5. Record a successful payment for the first order.
INSERT INTO payments (order_id, amount, status)
VALUES
    (1, 15000.00, 'Successful');
