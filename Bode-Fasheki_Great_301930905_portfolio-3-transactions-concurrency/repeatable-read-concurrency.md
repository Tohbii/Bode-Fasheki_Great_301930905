# REPEATABLE READ Concurrency Experiment

## Objective
To observe how PostgreSQL's REPEATABLE READ isolation level maintains a consistent snapshot during concurrent transactions.

## Test Setup
- Database: `fashek_store`
- Table: `transaction_demo`
- Record ID: `1`
- Initial stock quantity: `7`
- Session A: Uses REPEATABLE READ.
- Session B: Updates the stock quantity to `4`.

## Procedure and Observations

1. Session A began a transaction using REPEATABLE READ and read a stock quantity of `7`.
2. Session B began a separate transaction, updated the quantity to `4`, and read its own uncommitted change.
3. Before Session B committed, Session A queried the record and still read `7`.
4. Session B committed its update.
5. Session A queried the record again and continued to read `7`.
6. Session A committed its transaction.
7. A new query after Session A's transaction ended returned the committed stock quantity of `4`.

## Results and Analysis

The experiment showed that Session A continued to see the same stock quantity throughout its transaction, even after Session B committed a newer value.

This behaviour is consistent with PostgreSQL's REPEATABLE READ isolation level, which uses a transaction-level snapshot. It differs from READ COMMITTED, where a later SELECT statement can see newly committed data.

## Conclusion

The experiment demonstrated how REPEATABLE READ provides a stable view of data within a transaction. The committed update became visible to a new transaction after Session A ended.

## Evidence
- `08-repeatable-read-initial-value.png`
- `09-repeatable-read-session-b-update.png`
- `10-repeatable-read-before-commit.png`
- `11-repeatable-read-after-commit.png`
