-- PORTFOLIO 2: QUERY PROCESSING AND OPTIMISATION
-- Experiment 4: Sequential Scan
-- Purpose: Observe query execution when index scans are disabled.

-- Disable regular index scans for this database session.
SET enable_indexscan = off;

-- Disable bitmap index scans for this database session.
SET enable_bitmapscan = off;


-- Execute the customer lookup query and inspect its execution plan.
-- PostgreSQL is encouraged to use a sequential scan instead of index scans.
EXPLAIN ANALYZE
SELECT
    order_id,
    customer_id,
    status
FROM orders
WHERE customer_id = 1;


-- Restore PostgreSQL's default planner settings for this session.
RESET enable_indexscan;
RESET enable_bitmapscan;