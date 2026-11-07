-- Check existing indexes
SELECT
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;


-- Create customer ID index
CREATE INDEX IF NOT EXISTS idx_orders_customer_id
ON orders (customer_id);


-- Test query performance
EXPLAIN ANALYZE
SELECT
    order_id,
    customer_id,
    status
FROM orders
WHERE customer_id = 1;