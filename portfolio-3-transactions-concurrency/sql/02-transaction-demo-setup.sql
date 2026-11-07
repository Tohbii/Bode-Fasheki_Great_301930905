-- PORTFOLIO 3: TRANSACTIONS AND CONCURRENCY
-- Experiment 2: Transaction Demo Table Setup
-- Purpose: Create a table for testing transaction behaviour.

-- Create the transaction_demo table if it does not already exist.
CREATE TABLE IF NOT EXISTS transaction_demo (
    id INT PRIMARY KEY,
    stock_quantity INT NOT NULL
);

-- Insert the initial stock record.
-- ON CONFLICT prevents duplicate primary-key errors.
INSERT INTO transaction_demo (id, stock_quantity)
VALUES (1, 10)
ON CONFLICT (id) DO NOTHING;

-- Display the initial table contents.
SELECT * FROM transaction_demo;