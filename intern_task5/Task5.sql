CREATE DATABASE elevate_task5;
USE elevate_task5;
-- Drop existing tables if they exist (to avoid errors when rerunning)
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50)
);

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert data into Customers
INSERT INTO Customers (CustomerID, Name, City) VALUES
(1, 'Alice', 'Delhi'),
(2, 'Bob', 'Mumbai'),
(3, 'Charlie', 'Bangalore'),
(4, 'David', 'Hyderabad');

-- Insert data into Orders
INSERT INTO Orders (OrderID, OrderDate, CustomerID, Amount) VALUES
(101, '2025-06-01', 1, 2500.00),
(102, '2025-06-02', 2, 1500.00),
(103, '2025-06-03', 1, 3200.00),
(104, '2025-06-04', 4, 2100.00); -- Note: CustomerID 5 does not exist in Customers

-- -----------------------------------------
-- 1. INNER JOIN
-- Only matching records between Customers and Orders
-- -----------------------------------------
SELECT 'INNER JOIN' AS Join_Type, Customers.Name, Orders.OrderID, Orders.Amount
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- -----------------------------------------
-- 2. LEFT JOIN
-- All customers, even if they don’t have orders
-- -----------------------------------------
SELECT 'LEFT JOIN' AS Join_Type, Customers.Name, Orders.OrderID, Orders.Amount
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- -----------------------------------------
-- 3. RIGHT JOIN
-- All orders, even if they don’t match any customer
-- -----------------------------------------
SELECT 'RIGHT JOIN' AS Join_Type, Customers.Name, Orders.OrderID, Orders.Amount
FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- -----------------------------------------
-- All customers and all orders, matching where possible
-- -----------------------------------------
SELECT 'FULL JOIN' AS Join_Type, Customers.Name, Orders.OrderID, Orders.Amount
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
UNION
SELECT 'FULL JOIN' AS Join_Type, Customers.Name, Orders.OrderID, Orders.Amount
FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
