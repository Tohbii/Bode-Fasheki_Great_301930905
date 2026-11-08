
# Fashek Store — Baseline Query Performance

## 1. Test Environment

- DBMS: PostgreSQL 18
- Database: fashek_store
- Tool: pgAdmin 4
- Test: Multi-table JOIN query

## 2. Baseline Measurements

The query was measured using PostgreSQL's `EXPLAIN ANALYZE` command.

| Metric | Measured value |
|---|---:|
| Planning Time | 0.285 ms |
| Execution Time | 0.424 ms |

## 3. Execution Plan Observations

The execution plan included Sequential Scan (Seq Scan) and Hash Join operations.

A Sequential Scan reads table rows to find the required records. A Hash Join uses a hash-based strategy to match rows from two inputs.

These are normal execution strategies. Their presence alone does not indicate poor performance.

## 4. Limitations

The database contains only a small sample dataset. Consequently, these measurements represent a baseline for learning and comparison rather than evidence of performance at production scale.

Execution times can vary between runs due to caching, system load and other factors.

## 5. Next Step

Test an appropriate index and compare the resulting execution plan and measured performance. Record the index definition, test conditions and actual results before drawing conclusions.

## 6. Four-Table JOIN Experiment

### Query
The query joins `order_items`, `orders`, `customers`, and `products` to retrieve order details, customer names, product names, quantities, and calculated item totals.

### Measurements

| Metric | Observed value |
|---|---:|
| Planning Time | 0.728 ms |
| Execution Time | 0.376 ms |
| Rows returned | 1 |

### Execution Plan Observations

The execution plan contained Nested Loop joins and a Hash Join. PostgreSQL used an Index Scan on `orders_pkey` and Sequential Scans on `customers`, `order_items`, and `products`.

The Sequential Scans are reasonable for this small sample database. The plan shows that PostgreSQL combines different execution strategies within one query.

### Limitations

The dataset is small, so these timings cannot establish how the query will perform at production scale. Execution times can also vary between runs. The results are recorded as observations rather than proof of a performance improvement.
