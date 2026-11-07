-- PORTFOLIO 2: QUERY PROCESSING AND OPTIMISATION
-- Experiment 1: Baseline Four-Table JOIN
-- Purpose: Examine how PostgreSQL executes a query involving four related tables.

-- Display the estimated execution plan without running the query.
EXPLAIN
SELECT
    o.order_id,
    c.full_name,
    p.product_name,
    oi.quantity
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON oi.product_id = p.product_id;


-- Execute the query and display the actual execution plan and performance statistics.
EXPLAIN ANALYZE
SELECT
    o.order_id,
    c.full_name,
    p.product_name,
    oi.quantity
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON oi.product_id = p.product_id;