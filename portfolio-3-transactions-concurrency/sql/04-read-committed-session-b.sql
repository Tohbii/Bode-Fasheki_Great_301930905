-- PORTFOLIO 3: TRANSACTIONS AND CONCURRENCY
-- Experiment 3: READ COMMITTED Isolation
-- Session B
-- Purpose: Update the stock quantity while Session A
-- has an active transaction.

-- Start a separate transaction.
BEGIN;

-- Change the stock quantity from 10 to 7.
UPDATE transaction_demo
SET stock_quantity = 7
WHERE id = 1;

-- Save the change so that other sessions can see it.
COMMIT;

-- Verify the committed stock quantity.
SELECT * FROM transaction_demo
WHERE id = 1;