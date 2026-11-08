# READ COMMITTED Concurrency Experiment

## Objective
To observe how PostgreSQL's default READ COMMITTED isolation level handles concurrent transactions that access the same stock record.

## Test Setup
- Database: `fashek_store`
- Table: `transaction_demo`
- Record ID: `1`
- Initial stock quantity: `10`
- Session A: Reads the stock quantity.
- Session B: Updates the stock quantity to `7`.

## Procedure and Observations

1. Session A began a transaction and read a stock quantity of `10`.
2. Session B began a separate transaction, updated the quantity to `7`, and read its own uncommitted change.
3. Before Session B committed, Session A queried the same record and still read `10`.
4. Session B committed its transaction.
5. Session A ran the SELECT statement again and read `7`.
6. Session A committed its transaction. The final stored quantity remained `7`.

## Results and Analysis

The experiment demonstrated that Session A did not see Session B's uncommitted update. After Session B committed, a subsequent SELECT statement in Session A returned the new value.

This behaviour is consistent with PostgreSQL's READ COMMITTED isolation level. Each statement reads data committed before that statement begins, so separate SELECT statements in the same transaction may return different values.

## Conclusion

The experiment demonstrated how READ COMMITTED prevents dirty reads while allowing a transaction to observe newly committed data in a later statement. The result illustrates statement-level snapshots in PostgreSQL.

## Evidence
- `03-initial-stock-10.png`
- `04-session-a-initial-read.png`
- `05-session-b-uncommitted-update.png`
- `06-session-a-sees-10-before-commit.png`
- `07-session-a-sees-7-after-commit.png`
