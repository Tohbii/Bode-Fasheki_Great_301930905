-- PORTFOLIO 3: TRANSACTIONS AND CONCURRENCY
-- Experiment 4: REPEATABLE READ Isolation
-- Session B
-- Purpose: Update the stock quantity while Session A
-- maintains a REPEATABLE READ transaction.

-- Begin a separate transaction.
BEGIN;

-- Change the stock quantity from 7 to 4.
UPDATE transaction_demo
SET stock_quantity = 4
WHERE id = 1;

-- Commit the update.
COMMIT;

-- Verify the latest committed stock quantity.
SELECT * FROM transaction_demo
WHERE id = 1;