# Fashek Store — Product Index Experiment

## 1. Objective

The objective was to investigate whether a separate index on `order_items.product_id` would be used by PostgreSQL when filtering order items and joining them to products.

## 2. Index Created

```sql
CREATE INDEX idx_order_items_product_id
ON order_items (product_id);
```

## 3. Test Query

```sql
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
```

## 4. Observed Results

| Metric | Result |
|---|---:|
| Planning time | 7.156 ms |
| Execution time | 0.870 ms |
| Rows returned | 1 |
| Join method | Nested Loop |
| Scan on `order_items` | Sequential Scan |
| Scan on `products` | Index Scan using `products_pkey` |

## 5. Analysis

PostgreSQL used a sequential scan on `order_items` despite the newly created `idx_order_items_product_id` index. It used the primary-key index on `products` to find the matching product.

The sequential scan is reasonable because the sample `order_items` table contains only one row. For such a small table, using an index may not be more efficient than scanning the available rows.

## 6. Limitations

The dataset is too small to establish whether the new index improves performance on larger workloads. Planning and execution times can vary between runs, so this single measurement should not be treated as proof that the index improves or reduces performance.

## 7. Conclusion

This experiment demonstrated how to create an index, inspect an execution plan, and evaluate the query planner's choice. The new index was not selected for this query. A larger dataset and controlled performance tests would be needed to assess whether the index provides a practical benefit.
