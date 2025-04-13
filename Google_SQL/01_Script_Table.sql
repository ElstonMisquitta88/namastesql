CREATE TABLE transactions_g (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    amount INT,
    tran_Date datetime
);

delete from transactions_g;
INSERT INTO transactions_g VALUES (1, 101, 500, '2025-01-01 10:00:01');
INSERT INTO transactions_g VALUES (2, 201, 500, '2025-01-01 10:00:01');
INSERT INTO transactions_g VALUES (3, 102, 300, '2025-01-02 00:50:01');
INSERT INTO transactions_g VALUES (4, 202, 300, '2025-01-02 00:50:01');
INSERT INTO transactions_g VALUES (5, 101, 700, '2025-01-03 06:00:01');
INSERT INTO transactions_g VALUES (6, 202, 700, '2025-01-03 06:00:01');
INSERT INTO transactions_g VALUES (7, 103, 200, '2025-01-04 03:00:01');
INSERT INTO transactions_g VALUES (8, 203, 200, '2025-01-04 03:00:01');
INSERT INTO transactions_g VALUES (9, 101, 400, '2025-01-05 00:10:01');
INSERT INTO transactions_g VALUES (10, 201, 400, '2025-01-05 00:10:01');
INSERT INTO transactions_g VALUES (11, 101, 500, '2025-01-07 10:10:01');
INSERT INTO transactions_g VALUES (12, 201, 500, '2025-01-07 10:10:01');
INSERT INTO transactions_g VALUES (13, 102, 200, '2025-01-03 10:50:01');
INSERT INTO transactions_g VALUES (14, 202, 200, '2025-01-03 10:50:01');
INSERT INTO transactions_g VALUES (15, 103, 500, '2025-01-01 11:00:01');
INSERT INTO transactions_g VALUES (16, 101, 500, '2025-01-01 11:00:01');
INSERT INTO transactions_g VALUES (17, 203, 200, '2025-11-01 11:00:01');
INSERT INTO transactions_g VALUES (18, 201, 200, '2025-11-01 11:00:01');