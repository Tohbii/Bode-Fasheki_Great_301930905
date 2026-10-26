# Fashek Store — Transaction Control

## 1. Objective

The objective of this practical exercise was to demonstrate how PostgreSQL transactions control changes to a relational database using `BEGIN`, `ROLLBACK`, and `COMMIT`.

## 2. Experiment A: ROLLBACK

A transaction was started using `BEGIN`. A temporary customer record with the email `transaction.test@example.com` was inserted into the `customers` table.

Before the transaction ended, a `SELECT` query confirmed that the record was visible. The transaction was then cancelled using `ROLLBACK`.

A verification query was executed after the rollback:

```sql
SELECT *
FROM customers
WHERE email = 'transaction.test@example.com';
```

**Result:** Zero rows were returned. This confirmed that the uncommitted insertion had been cancelled.

## 3. Experiment B: COMMIT

A second transaction inserted a customer record with the email `commit.test@example.com`. The transaction was completed using `COMMIT`.

The following verification query was executed:

```sql
SELECT *
FROM customers
WHERE email = 'commit.test@example.com';
```

**Result:** One row was returned, confirming that the insertion was retained.

## 4. Comparison

| Command | Behaviour observed |
|---|---|
| `BEGIN` | Started a transaction |
| `ROLLBACK` | Cancelled the uncommitted insertion |
| `COMMIT` | Retained the insertion |

## 5. Conclusion

The experiments demonstrated that PostgreSQL transactions allow changes to be committed or cancelled as a unit. This helps applications preserve database consistency when an operation contains multiple related changes.

The experiments used the Fashek Store sample database in PostgreSQL 18 through pgAdmin 4. Screenshots of the transaction tests and verification results are stored in the evidence folder.
