
CREATE DATABASE elevates_task2;
USE elevates_task2;
-- Creating sample tables for demonstration
CREATE TABLE Customers (
    CustomerID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,
    Email TEXT,
    Phone TEXT
);

CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    CustomerID INTEGER,
    Product TEXT NOT NULL,
    Quantity INTEGER DEFAULT 1,
    OrderDate TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 1. INSERT statements (handling NULLs and default values)
INSERT INTO Customers (CustomerID, Name, Email, Phone) VALUES
(1, 'Alice', 'alice@example.com', '9876543210'),
(2, 'Bob', NULL, '9876500000'), -- Email is NULL
(3, 'Charlie', 'charlie@example.com', NULL); -- Phone is NULL

INSERT INTO Orders (OrderID, CustomerID, Product, Quantity, OrderDate) VALUES
(101, 1, 'Laptop', 2, '2025-06-01'),
(102, 2, 'Keyboard', NULL, '2025-06-05'), -- Quantity is NULL, will use default 1
(103, 3, 'Monitor', 1, NULL); -- OrderDate is NULL


-- 2. UPDATE statements (fixing missing data or updating info)
UPDATE Customers
SET Email = 'bob@example.com'
WHERE CustomerID = 2;

UPDATE Orders
SET OrderDate = '2025-06-07'
WHERE OrderID = 103;

-- 3. DELETE statements (remove specific entries)
DELETE FROM Customers
WHERE CustomerID = 3;

DELETE FROM Orders
WHERE OrderID = 102;

SELECT * FROM Customers;
SELECT * FROM orders;
