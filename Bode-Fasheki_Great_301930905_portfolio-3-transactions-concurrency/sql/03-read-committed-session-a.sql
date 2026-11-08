-- PORTFOLIO 3: TRANSACTIONS AND CONCURRENCY
-- Experiment 3: READ COMMITTED Isolation
-- Session A
-- Purpose: Observe how READ COMMITTED handles changes
-- committed by another database session.

-- Set the transaction isolation level.
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Read the initial stock quantity.
-- Expected initial value: 10.
SELECT * FROM transaction_demo
WHERE id = 1;

-- Keep this transaction open while Session B performs its update.
-- Run the next SELECT after Session B commits its transaction.

-- Read the stock quantity again.
-- Under READ COMMITTED, this statement can see Session B's committed update.
SELECT * FROM transaction_demo
WHERE id = 1;

-- Finish the transaction.
COMMIT;