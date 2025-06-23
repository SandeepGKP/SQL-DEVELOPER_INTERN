-- Create Database

CREATE DATABASE elevates_lab;

USE elevates_lab;

-- Customer Table
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT
);

-- Product Table
CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    stock_quantity INT
);

-- Category Table
CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE
);

-- ProductCategory Table (Many-to-Many)
CREATE TABLE ProductCategory (
    product_id INT,
    category_id INT,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

-- Order Table
CREATE TABLE `Order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- OrderItem Table (Line items in an order)
CREATE TABLE OrderItem (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);


-- STEP 3: Insert Records

INSERT INTO Customer (name, email, phone, address) VALUES
('Alice Smith', 'alice@example.com', '1234567890', '123 Maple St'),
('Bob Johnson', 'bob@example.com', '2345678901', '456 Oak St'),
('Charlie Brown', 'charlie@example.com', '3456789012', '789 Pine St'),
('David Miller', 'david@example.com', '4567890123', '321 Birch St'),
('Emma Davis', 'emma@example.com', '5678901234', '654 Cedar St'),
('Fiona Lee', 'fiona@example.com', '6789012345', '987 Walnut St'),
('George White', 'george@example.com', '7890123456', '111 Elm St'),
('Hannah Clark', 'hannah@example.com', '8901234567', '222 Spruce St'),
('Irene Lewis', 'irene@example.com', '9012345678', '333 Fir St'),
('Jack Walker', 'jack@example.com', '0123456789', '444 Redwood St');

INSERT INTO Product (name, price, stock_quantity) VALUES
('Laptop', 75000.00, 20),
('Smartphone', 30000.00, 50),
('Tablet', 20000.00, 30),
('Headphones', 1500.00, 100),
('Keyboard', 800.00, 70),
('Mouse', 500.00, 90),
('Smartwatch', 5000.00, 25),
('Monitor', 12000.00, 15),
('USB Drive', 600.00, 200),
('Charger', 1000.00, 80);

INSERT INTO Category (name) VALUES
('Electronics'),
('Computers'),
('Accessories'),
('Mobile Devices'),
('Wearables');

INSERT INTO ProductCategory (product_id, category_id) VALUES
(1, 1), (1, 2),
(2, 1), (2, 4),
(3, 1), (3, 4),
(4, 1), (4, 3),
(5, 3),
(6, 3),
(7, 1), (7, 5),
(8, 1), (8, 2),
(9, 3),
(10, 3);

INSERT INTO `Order` (customer_id, order_date, total_amount) VALUES
(1, '2024-06-01', 78000.00),
(2, '2024-06-02', 31500.00),
(3, '2024-06-03', 7500.00),
(4, '2024-06-04', 2100.00),
(5, '2024-06-05', 32000.00),
(6, '2024-06-06', 60500.00),
(7, '2024-06-07', 2600.00),
(8, '2024-06-08', 8500.00),
(9, '2024-06-09', 1800.00),
(10, '2024-06-10', 500.00);

INSERT INTO OrderItem (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 5, 2),
(2, 2, 1),
(2, 4, 1),
(3, 7, 1),
(4, 5, 1),
(4, 6, 1),
(5, 3, 1),
(5, 10, 2),
(6, 1, 1),
(6, 2, 1),
(7, 6, 2),
(8, 8, 1),
(9, 9, 3),
(10, 9, 1);


SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM OrderItem WHERE order_id = 1;
