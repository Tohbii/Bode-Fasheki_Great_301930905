-- PORTFOLIO 2: QUERY PROCESSING AND OPTIMISATION
-- Experiment 3: Product ID Index
-- Purpose: Investigate how an index on product_id affects a JOIN query.

-- Create an index on product_id in the order_items table.
CREATE INDEX IF NOT EXISTS idx_order_items_product_id
ON order_items (product_id);


-- Execute the JOIN query and analyse its actual execution plan.
-- The query retrieves order item details for a specific product.
EXPLAIN ANALYZE
SELECT
    oi.order_item_id,
    oi.order_id,
    oi.product_id,
    p.product_name,
    oi.quantity
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
WHERE oi.product_id = 1;