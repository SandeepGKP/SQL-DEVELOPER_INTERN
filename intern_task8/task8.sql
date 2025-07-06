CREATE DATABASE elevate_task8;
use elevate_task8;

-- Task 8: Stored Procedures and Functions - Single SQL Script

-- 1. Create Tables
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  email VARCHAR(100)
);

CREATE TABLE orders (
  id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT,
  amount DECIMAL(10,2),
  status VARCHAR(20),
  created_at DATE,
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- 2. Insert Sample Data
INSERT INTO customers (name, email)
VALUES ('Alice', 'alice@example.com'),
       ('Bob', 'bob@example.com');

INSERT INTO orders (customer_id, amount, status, created_at)
VALUES
  (1, 250.00, 'Completed', '2025-07-01'),
  (1, 150.00, 'Pending', '2025-07-03'),
  (2, 300.00, 'Completed', '2025-07-04');

-- 3. Create Stored Procedure
DELIMITER $$

CREATE PROCEDURE GetCustomerOrders (
    IN cust_id INT,
    IN order_status VARCHAR(20)
)
BEGIN
    SELECT o.id, o.amount, o.status, o.created_at
    FROM orders o
    WHERE o.customer_id = cust_id AND o.status = order_status;
END$$

-- 4. Create Function
CREATE FUNCTION GetTotalSpent(cust_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    
    SELECT SUM(amount) INTO total
    FROM orders
    WHERE customer_id = cust_id AND status = 'Completed';

    RETURN IFNULL(total, 0.00);
END$$

DELIMITER ;

-- 5. Example Usage

-- Call Stored Procedure
CALL GetCustomerOrders(1, 'Completed');

-- Use Function
SELECT GetTotalSpent(1) AS total_spent;
