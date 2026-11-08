
-- Fashek Store
-- Portfolio 1: Database Design and Implementation
-- Purpose: Retrieve order details by joining related tables.

SELECT
    o.order_id,
    c.full_name,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS item_total
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON oi.product_id = p.product_id
ORDER BY o.order_id;
