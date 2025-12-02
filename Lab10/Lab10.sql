CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    balance DECIMAL(10, 2) DEFAULT 0.00
);
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    shop VARCHAR(100) NOT NULL,
    product VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);
-- Insert test data
INSERT INTO accounts (name, balance) VALUES
    ('Alice', 1000.00),
    ('Bob', 500.00),
    ('Wally', 750.00);
INSERT INTO products (shop, product, price) VALUES
    ('Joe''s Shop', 'Coke', 2.50),
    ('Joe''s Shop', 'Pepsi', 3.00);


--Task 1
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE name='Alice';
UPDATE accounts SET balance = balance + 100 WHERE name='Bob';
COMMIT;
--a) Alice - 900.00, Bob - 600.00
--b) If not in a transaction, one could succeed while the other fails
--c) If the system freezes between operations, the money will disappear.


--Task 2
BEGIN;
UPDATE accounts SET balance = balance - 500.00
WHERE name = 'Alice';
SELECT * FROM accounts WHERE name = 'Alice';
ROLLBACK;
SELECT * FROM accounts WHERE name = 'Alice';
--a) Before rollback - 500.00
--b) After rollback - 1000.00
--c) When input/input error/validation fails


--Task 3
BEGIN;
UPDATE accounts SET balance = balance - 100.00
    WHERE name = 'Alice';
SAVEPOINT my_savepoint;
UPDATE accounts SET balance = balance + 100.00
    WHERE name = 'Bob';
ROLLBACK TO my_savepoint;
UPDATE accounts SET balance = balance + 100.00
    WHERE name = 'Wally';
COMMIT;
--a) Alice: 900 , Bob: 500 , Wally: 850
--b) Bob was credited first, then rollback — final balance unchanged
--c) SAVEPOINT allows rollback only part, without restarting whole transaction