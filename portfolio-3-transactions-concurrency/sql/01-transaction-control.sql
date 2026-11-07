-- PORTFOLIO 3: TRANSACTIONS AND CONCURRENCY
-- Experiment 1: Transaction Control
-- Purpose: Demonstrate COMMIT and ROLLBACK in PostgreSQL.

-- Start a new transaction.
BEGIN;

-- View the current records before making changes.
SELECT * FROM transaction_demo;

-- Make a temporary update to the stock quantity.
UPDATE transaction_demo
SET stock_quantity = 5
WHERE id = 1;

-- Verify the update inside the current transaction.
SELECT * FROM transaction_demo;

-- Undo the update and restore the previous database state.
ROLLBACK;

-- Confirm that the original stock quantity has been restored.
SELECT * FROM transaction_demo;


-- Experiment 2: COMMIT
-- Start another transaction.
BEGIN;

-- Update the stock quantity.
UPDATE transaction_demo
SET stock_quantity = 7
WHERE id = 1;

-- Permanently save the transaction.
COMMIT;

-- Verify that the committed change remains in the database.
SELECT * FROM transaction_demo;