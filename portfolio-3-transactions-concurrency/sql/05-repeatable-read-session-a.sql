-- PORTFOLIO 3: TRANSACTIONS AND CONCURRENCY
-- Experiment 4: REPEATABLE READ Isolation
-- Session A
-- Purpose: Demonstrate snapshot consistency within a transaction.

-- Begin a transaction using REPEATABLE READ isolation.
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Read the initial stock quantity.
-- At this stage, the expected value is 7.
SELECT * FROM transaction_demo
WHERE id = 1;

-- Keep this transaction open while Session B updates and commits.
-- Then execute the following SELECT again.

-- Read the stock quantity a second time.
-- REPEATABLE READ should continue showing the original snapshot value.
SELECT * FROM transaction_demo
WHERE id = 1;

-- End the transaction.
COMMIT;

-- Start a new transaction to observe the latest committed value.
SELECT * FROM transaction_demo
WHERE id = 1;