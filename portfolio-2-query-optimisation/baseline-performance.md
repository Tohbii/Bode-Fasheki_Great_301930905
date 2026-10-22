
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
