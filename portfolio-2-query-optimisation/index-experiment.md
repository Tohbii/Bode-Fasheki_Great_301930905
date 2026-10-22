# Fashek Store — Index Experiment

## 1. Objective

The objective was to investigate how PostgreSQL executes a query that filters orders by customer ID and observe whether an index changes the execution plan.

## 2. Index Created

```sql
CREATE INDEX idx_orders_customer_id
ON orders (customer_id);
```

This index is intended to support queries that filter or search orders using `customer_id`.

## 3. Test Query

```sql
EXPLAIN ANALYZE
SELECT
    order_id,
    customer_id,
    status
FROM orders
WHERE customer_id = 1;
```

## 4. Observed Results

| Metric | Result |
|---|---|
| Scan operation | Sequential Scan (`Seq Scan`) |
| Planning time | 0.095 ms |
| Execution time | 0.049 ms |
| Rows returned | 2 |

## 5. Analysis

PostgreSQL selected a sequential scan even though an index on `orders.customer_id` existed. A sequential scan reads the table and checks which rows satisfy the filter.

This is reasonable for the small sample dataset used in this project. When a table contains very few rows, scanning the table can be cheaper than accessing an index and then retrieving matching rows.

The result demonstrates that creating an index does not guarantee that PostgreSQL will use it. The query planner chooses an execution plan based on its cost estimates and the available data.

## 6. Limitations

The database contains only a small sample dataset. Execution times can vary with caching, system load and other conditions. These measurements are useful for learning but are not sufficient to establish how the index would perform on a large production dataset.

## 7. Conclusion

The experiment demonstrated how to inspect an execution plan using `EXPLAIN ANALYZE` and how to interpret PostgreSQL's sequential-scan decision. Further testing with a larger dataset and controlled comparisons would be needed to evaluate the index's performance benefits.
