-- ==============================================================================
-- FULL HISTORY DATA LOAD FOR MANAGER: mjones (U4P8L)
-- TIME SPAN: Jan 2023 - Dec 2025
-- CLIENTS: Michael Thompson, Victoria Clarke, BlackRock Inc, Royal Bank of Canada
-- FIX: Adjusted lot_id values to VARCHAR(5) to match schema constraints
-- ==============================================================================

USE backoffice;

-- ==============================================================================
-- 1. TRADE HISTORY (Chronological Order)
-- ==============================================================================

-- --- 2023 Q1 & Q2 Activity ---

-- [Institutional] BlackRock buys JPM block (Jan 2023)
INSERT INTO Trade (trade_id, account_id, cusip, counterparty_id, transaction_type, price, units, trade_date, settlement_date, status) 
VALUES ('T_230115_JPM', 'G8Y4K2N9M5_01', '46625H100', 'C8M2K', 'BUY', 135.50, 5000, '2023-01-15 10:00:00', '2023-01-17', 'SETTLED');

-- [Individual] Michael Thompson buys SPY ETF (Mar 2023)
INSERT INTO Trade (trade_id, account_id, cusip, counterparty_id, transaction_type, price, units, trade_date, settlement_date, status) 
VALUES ('T_230310_SPY', 'E2W7J4M8Q1_01', '78462F103', 'C3P7L', 'BUY', 390.00, 100, '2023-03-10 11:30:00', '2023-03-14', 'SETTLED');

-- [Institutional] RBC buys Treasury Bonds (Apr 2023)
INSERT INTO Trade (trade_id, account_id, cusip, counterparty_id, transaction_type, price, units, trade_date, settlement_date, status) 
VALUES ('T_230420_TRY', 'H3Z9T7L4B8_01', '912828ZT0', 'C2X6V', 'BUY', 950.00, 2000, '2023-04-20 14:00:00', '2023-04-21', 'SETTLED');

-- [Individual] Victoria Clarke buys NVDA (May 2023)
INSERT INTO Trade (trade_id, account_id, cusip, counterparty_id, transaction_type, price, units, trade_date, settlement_date, status) 
VALUES ('T_230515_NVDA', 'F6X1V9H3Y7_01', '91324P102', 'C8M2K', 'BUY', 305.00, 100, '2023-05-15 10:30:00', '2023-05-17', 'SETTLED');

-- --- 2023 Q3 & Q4 Activity ---

-- [Individual] Victoria Clarke buys MSFT (Aug 2023)
INSERT INTO Trade (trade_id, account_id, cusip, counterparty_id, transaction_type, price, units, trade_date, settlement_date, status) 
VALUES ('T_230820_MSFT', 'F6X1V9H3Y7_01', '594918104', 'C3P7L', 'BUY', 320.00, 200, '2023-08-20 14:15:00', '2023-08-22', 'SETTLED');

-- [Institutional] BlackRock buys Berkshire Hathaway (Nov 2023)
INSERT INTO Trade (trade_id, account_id, cusip, counterparty_id, transaction_type, price, units, trade_date, settlement_date, status) 
VALUES ('T_231105_BRK', 'G8Y4K2N9M5_02', '09247X101', 'C9Q4N', 'BUY', 350.25, 2000, '2023-11-05 09:45:00', '2023-11-07', 'SETTLED');

-- --- 2024 Q1 & Q2 Activity ---

-- [Individual] Victoria Clarke takes Profit on NVDA (Feb 2024)
INSERT INTO Trade (trade_id, account_id, cusip, counterparty_id, transaction_type, price, units, trade_date, settlement_date, status) 
VALUES ('T_240210_NVDA_S', 'F6X1V9H3Y7_01', '91324P102', 'C8M2K', 'SELL', 720.00, 50, '2024-02-10 09:45:00', '2024-02-12', 'SETTLED');

-- [Institutional] RBC buys Microsoft Corporate Bonds (Mar 2024)
INSERT INTO Trade (trade_id, account_id, cusip, counterparty_id, transaction_type, price, units, trade_date, settlement_date, status) 
VALUES ('T_240315_MSB', 'H3Z9T7L4B8_02', '594918BG4', 'C1N5M', 'BUY', 985.00, 5000, '2024-03-15 13:30:00', '2024-03-16', 'SETTLED');

-- [Institutional] BlackRock sells some JPM to rebalance (May 2024)
INSERT INTO Trade (trade_id, account_id, cusip, counterparty_id, transaction_type, price, units, trade_date, settlement_date, status) 
VALUES ('T_240520_JPM_S', 'G8Y4K2N9M5_01', '46625H100', 'C8M2K', 'SELL', 195.00, 1000, '2024-05-20 10:15:00', '2024-05-22', 'SETTLED');

-- [Individual] Victoria Clarke buys AAPL (Jun 2024)
INSERT INTO Trade (trade_id, account_id, cusip, counterparty_id, transaction_type, price, units, trade_date, settlement_date, status) 
VALUES ('T_240615_AAPL', 'F6X1V9H3Y7_01', '037833100', 'C9Q4N', 'BUY', 215.00, 300, '2024-06-15 11:30:00', '2024-06-17', 'SETTLED');

-- --- 2024 Q3 & Q4 Activity ---

-- [Individual] Michael Thompson buys Bond ETF for safety (Aug 2024)
INSERT INTO Trade (trade_id, account_id, cusip, counterparty_id, transaction_type, price, units, trade_date, settlement_date, status) 
VALUES ('T_240810_IVV', 'E2W7J4M8Q1_01', '464287200', 'C3P7L', 'BUY', 440.00, 50, '2024-08-10 15:00:00', '2024-08-12', 'SETTLED');

-- [Individual] Victoria Clarke Stop Loss on AAPL (Nov 2024)
INSERT INTO Trade (trade_id, account_id, cusip, counterparty_id, transaction_type, price, units, trade_date, settlement_date, status) 
VALUES ('T_241120_AAPL_S', 'F6X1V9H3Y7_01', '037833100', 'C9Q4N', 'SELL', 205.00, 100, '2024-11-20 15:00:00', '2024-11-22', 'SETTLED');

-- --- 2025 Activity ---

-- [Institutional] RBC Sells Treasuries (Jan 2025)
INSERT INTO Trade (trade_id, account_id, cusip, counterparty_id, transaction_type, price, units, trade_date, settlement_date, status) 
VALUES ('T_250115_TRY_S', 'H3Z9T7L4B8_01', '912828ZT0', 'C2X6V', 'SELL', 975.00, 500, '2025-01-15 11:00:00', '2025-01-16', 'SETTLED');

-- [Institutional] BlackRock buys GOOGL (Mar 2025)
INSERT INTO Trade (trade_id, account_id, cusip, counterparty_id, transaction_type, price, units, trade_date, settlement_date, status) 
VALUES ('T_250310_GOOG', 'G8Y4K2N9M5_01', '02079K305', 'C8M2K', 'BUY', 175.50, 1000, '2025-03-10 09:30:00', '2025-03-12', 'SETTLED');

-- [Individual] Victoria Clarke buys TSLA (Sept 2025)
INSERT INTO Trade (trade_id, account_id, cusip, counterparty_id, transaction_type, price, units, trade_date, settlement_date, status) 
VALUES ('T_250905_TSLA', 'F6X1V9H3Y7_02', '88160R101', 'C5W8J', 'BUY', 245.00, 100, '2025-09-05 14:45:00', '2025-09-07', 'SETTLED');

-- [Individual] Michael Thompson Rebalances SPY (Oct 2025)
INSERT INTO Trade (trade_id, account_id, cusip, counterparty_id, transaction_type, price, units, trade_date, settlement_date, status) 
VALUES ('T_251012_SPY_S', 'E2W7J4M8Q1_01', '78462F103', 'C3P7L', 'SELL', 495.00, 20, '2025-10-12 10:00:00', '2025-10-14', 'SETTLED');


-- ==============================================================================
-- 2. TAX LOTS (Cost Basis for BUYs)
-- FIX: lot_id truncated to 5 chars max
-- ==============================================================================

INSERT INTO Lot (lot_id, trade_id, account_id, cusip, units, cost_basis, acquisition_date) VALUES
('LJP01', 'T_230115_JPM', 'G8Y4K2N9M5_01', '46625H100', 5000, 677500.00, '2023-01-16'),
('LSP01', 'T_230310_SPY', 'E2W7J4M8Q1_01', '78462F103', 100, 39000.00, '2023-03-11'),
('LTR01', 'T_230420_TRY', 'H3Z9T7L4B8_01', '912828ZT0', 2000, 1900000.00, '2023-04-21'),
('LNV01', 'T_230515_NVDA', 'F6X1V9H3Y7_01', '91324P102', 100, 30500.00, '2023-05-16'),
('LMS01', 'T_230820_MSFT', 'F6X1V9H3Y7_01', '594918104', 200, 64000.00, '2023-08-21'),
('LBR01', 'T_231105_BRK', 'G8Y4K2N9M5_02', '09247X101', 2000, 700500.00, '2023-11-06'),
('LMB01', 'T_240315_MSB', 'H3Z9T7L4B8_02', '594918BG4', 5000, 4925000.00, '2024-03-16'),
('LAA01', 'T_240615_AAPL', 'F6X1V9H3Y7_01', '037833100', 300, 64500.00, '2024-06-16'),
('LIV01', 'T_240810_IVV', 'E2W7J4M8Q1_01', '464287200', 50, 22000.00, '2024-08-11'),
('LGO01', 'T_250310_GOOG', 'G8Y4K2N9M5_01', '02079K305', 1000, 175500.00, '2025-03-11'),
('LTS01', 'T_250905_TSLA', 'F6X1V9H3Y7_02', '88160R101', 100, 24500.00, '2025-09-06');


-- ==============================================================================
-- 3. JOURNALS (Cash Movements)
-- BUY = CREDIT (Cost), SELL = DEBIT (Proceeds)
-- ==============================================================================

INSERT INTO Journal (journal_id, trade_id, account_id, journal_type, amount, entry_date) VALUES
-- 2023
('J_01', 'T_230115_JPM', 'G8Y4K2N9M5_01', 'CREDIT', 677500.00, '2023-01-15'),
('J_02', 'T_230310_SPY', 'E2W7J4M8Q1_01', 'CREDIT', 39000.00, '2023-03-10'),
('J_03', 'T_230420_TRY', 'H3Z9T7L4B8_01', 'CREDIT', 1900000.00, '2023-04-20'),
('J_04', 'T_230515_NVDA', 'F6X1V9H3Y7_01', 'CREDIT', 30500.00, '2023-05-15'),
('J_05', 'T_230820_MSFT', 'F6X1V9H3Y7_01', 'CREDIT', 64000.00, '2023-08-20'),
('J_06', 'T_231105_BRK', 'G8Y4K2N9M5_02', 'CREDIT', 700500.00, '2023-11-05'),
-- 2024
('J_07', 'T_240210_NVDA_S', 'F6X1V9H3Y7_01', 'DEBIT', 36000.00, '2024-02-10'),
('J_08', 'T_240315_MSB', 'H3Z9T7L4B8_02', 'CREDIT', 4925000.00, '2024-03-15'),
('J_09', 'T_240520_JPM_S', 'G8Y4K2N9M5_01', 'DEBIT', 195000.00, '2024-05-20'),
('J_10', 'T_240615_AAPL', 'F6X1V9H3Y7_01', 'CREDIT', 64500.00, '2024-06-15'),
('J_11', 'T_240810_IVV', 'E2W7J4M8Q1_01', 'CREDIT', 22000.00, '2024-08-10'),
('J_12', 'T_241120_AAPL_S', 'F6X1V9H3Y7_01', 'DEBIT', 20500.00, '2024-11-20'),
-- 2025
('J_13', 'T_250115_TRY_S', 'H3Z9T7L4B8_01', 'DEBIT', 487500.00, '2025-01-15'),
('J_14', 'T_250310_GOOG', 'G8Y4K2N9M5_01', 'CREDIT', 175500.00, '2025-03-10'),
('J_15', 'T_250905_TSLA', 'F6X1V9H3Y7_02', 'CREDIT', 24500.00, '2025-09-05'),
('J_16', 'T_251012_SPY_S', 'E2W7J4M8Q1_01', 'DEBIT', 9900.00, '2025-10-12');


-- ==============================================================================
-- 4. CURRENT POSITIONS (Snapshot as of Late 2025)
-- ==============================================================================

-- Cleanup old data for mjones's clients to avoid collisions
DELETE FROM Position WHERE account_id IN (
    'E2W7J4M8Q1_01', 
    'F6X1V9H3Y7_01', 'F6X1V9H3Y7_02', 
    'G8Y4K2N9M5_01', 'G8Y4K2N9M5_02', 
    'H3Z9T7L4B8_01', 'H3Z9T7L4B8_02'
);

INSERT INTO Position (account_id, cusip, as_of_date, units) VALUES
-- Michael Thompson
('E2W7J4M8Q1_01', '78462F103', '2025-11-08', 80),   -- SPY (100 - 20)
('E2W7J4M8Q1_01', '464287200', '2025-11-08', 50),   -- IVV

-- Victoria Clarke
('F6X1V9H3Y7_01', '91324P102', '2025-11-08', 50),   -- NVDA (100 - 50)
('F6X1V9H3Y7_01', '594918104', '2025-11-08', 200),  -- MSFT
('F6X1V9H3Y7_01', '037833100', '2025-11-08', 200),  -- AAPL (300 - 100)
('F6X1V9H3Y7_02', '88160R101', '2025-11-08', 100),  -- TSLA (Margin)

-- BlackRock Inc
('G8Y4K2N9M5_01', '46625H100', '2025-11-08', 4000), -- JPM (5000 - 1000)
('G8Y4K2N9M5_01', '02079K305', '2025-11-08', 1000), -- GOOGL
('G8Y4K2N9M5_02', '09247X101', '2025-11-08', 2000), -- BRK.B

-- Royal Bank of Canada
('H3Z9T7L4B8_01', '912828ZT0', '2025-11-08', 1500), -- Treasury Bond (2000 - 500)
('H3Z9T7L4B8_02', '594918BG4', '2025-11-08', 5000); -- Corp Bond

USE backoffice;

-- 1. Clear potentially desynchronized positions for M.Jones's clients
DELETE FROM Position WHERE account_id IN (
    'E2W7J4M8Q1_01', -- Michael Thompson
    'F6X1V9H3Y7_01', 'F6X1V9H3Y7_02', -- Victoria Clarke
    'G8Y4K2N9M5_01', 'G8Y4K2N9M5_02', -- BlackRock
    'H3Z9T7L4B8_01', 'H3Z9T7L4B8_02'  -- RBC
);

-- 2. Re-calculate and Insert Positions based on the SUM of ALL Trades
-- This logic sums all BUYs and subtracts all SELLs to get the true net holding.
INSERT INTO Position (account_id, cusip, as_of_date, units)
SELECT 
    t.account_id, 
    t.cusip, 
    CURRENT_DATE() as as_of_date, 
    SUM(CASE WHEN t.transaction_type = 'BUY' THEN t.units ELSE -t.units END) as units
FROM Trade t
WHERE t.account_id IN (
    'E2W7J4M8Q1_01', 
    'F6X1V9H3Y7_01', 'F6X1V9H3Y7_02', 
    'G8Y4K2N9M5_01', 'G8Y4K2N9M5_02', 
    'H3Z9T7L4B8_01', 'H3Z9T7L4B8_02'
)
GROUP BY t.account_id, t.cusip
HAVING units > 0; -- Only insert if they actually hold shares (exclude closed positions)

-- 3. Verify the Fix
SELECT * FROM Position WHERE account_id = 'G8Y4K2N9M5_01';