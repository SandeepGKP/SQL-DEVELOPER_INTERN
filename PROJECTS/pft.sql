-- PERSONAL FINANCE TRACKER DATABASE WITH ADVANCED FEATURES

CREATE DATABASE project_pft;
USE project_pft;

-- 1. Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. Categories Table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    type ENUM('Income', 'Expense') NOT NULL
);

-- 3. Income Table
CREATE TABLE Income (
    income_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    category_id INT,
    amount DECIMAL(10, 2),
    source VARCHAR(255),
    received_at DATE,
    FOREIGN KEY(user_id) REFERENCES Users(user_id),
    FOREIGN KEY(category_id) REFERENCES Categories(category_id)
);

-- 4. Expenses Table
CREATE TABLE Expenses (
    expense_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    category_id INT,
    amount DECIMAL(10, 2),
    description VARCHAR(255),
    spent_at DATE,
    receipt_url TEXT,
    payment_mode ENUM('Cash', 'Credit', 'Debit', 'UPI', 'NetBanking'),
    currency VARCHAR(10) DEFAULT 'INR',
    exchange_rate DECIMAL(10, 4) DEFAULT 1.0,
    converted_amount DECIMAL(10, 2) GENERATED ALWAYS AS (amount * exchange_rate) STORED,
    FOREIGN KEY(user_id) REFERENCES Users(user_id),
    FOREIGN KEY(category_id) REFERENCES Categories(category_id)
);

-- 5. Budget Limits per User
CREATE TABLE BudgetLimits (
    user_id INT,
    month VARCHAR(7),
    limit_amount DECIMAL(10,2),
    PRIMARY KEY(user_id, month),
    FOREIGN KEY(user_id) REFERENCES Users(user_id)
);

-- 6. Audit Table for Expense Changes
CREATE TABLE ExpenseAudit (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    expense_id INT,
    old_amount DECIMAL(10,2),
    new_amount DECIMAL(10,2),
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 7. Recurring Transactions Table
CREATE TABLE RecurringTransactions (
    recurring_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    category_id INT,
    amount DECIMAL(10,2),
    description VARCHAR(255),
    recurrence_type ENUM('Monthly', 'Weekly'),
    next_due DATE,
    active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY(user_id) REFERENCES Users(user_id),
    FOREIGN KEY(category_id) REFERENCES Categories(category_id)
);

-- 8. Shared Expenses Table
CREATE TABLE ExpenseParticipants (
    expense_id INT,
    user_id INT,
    share DECIMAL(10,2),
    PRIMARY KEY(expense_id, user_id),
    FOREIGN KEY(expense_id) REFERENCES Expenses(expense_id),
    FOREIGN KEY(user_id) REFERENCES Users(user_id)
);

-- 9. Savings Goals Table
CREATE TABLE SavingsGoals (
    goal_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    target_amount DECIMAL(10,2),
    duration_months INT,
    start_date DATE,
    current_saved DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY(user_id) REFERENCES Users(user_id)
);

-- 10. Notifications Table
CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    message TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    read_flag BOOLEAN DEFAULT FALSE,
    FOREIGN KEY(user_id) REFERENCES Users(user_id)
);

-- 11. Tags and ExpenseTags Tables
CREATE TABLE Tags (
    tag_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE ExpenseTags (
    expense_id INT,
    tag_id INT,
    PRIMARY KEY(expense_id, tag_id),
    FOREIGN KEY(expense_id) REFERENCES Expenses(expense_id),
    FOREIGN KEY(tag_id) REFERENCES Tags(tag_id)
);

-- ✅ Sample Data for Testing
INSERT INTO Users (name, email) VALUES
('Sandeep Nishad', 'sandeep@example.com'),
('Anita Rao', 'anita@example.com');

INSERT INTO Categories (name, type) VALUES
('Salary', 'Income'),
('Freelancing', 'Income'),
('Rent', 'Expense'),
('Groceries', 'Expense'),
('Transport', 'Expense'),
('Utilities', 'Expense'),
('Netflix', 'Expense'),
('Loan EMI', 'Expense');

INSERT INTO Income (user_id, category_id, amount, source, received_at) VALUES
(1, 1, 50000, 'Monthly Salary', '2025-07-01'),
(1, 2, 8000, 'Website Project', '2025-07-10');

INSERT INTO Expenses (user_id, category_id, amount, description, spent_at, receipt_url, payment_mode, currency, exchange_rate) VALUES
(1, 3, 12000, 'July Rent', '2025-07-02', 'url1', 'UPI', 'INR', 1.0),
(1, 4, 3500, 'Big Bazaar', '2025-07-04', 'url2', 'Cash', 'INR', 1.0),
(1, 7, 499, 'Netflix', '2025-07-05', 'url3', 'Credit', 'INR', 1.0),
(1, 5, 1200, 'Auto Fare', '2025-07-05', NULL, 'Cash', 'INR', 1.0),
(1, 6, 2500, 'Electricity Bill', '2025-07-07', NULL, 'NetBanking', 'INR', 1.0);

INSERT INTO BudgetLimits VALUES
(1, '2025-07', 20000);

INSERT INTO RecurringTransactions (user_id, category_id, amount, description, recurrence_type, next_due) VALUES
(1, 3, 12000, 'Monthly Rent', 'Monthly', '2025-08-01');

INSERT INTO SavingsGoals (user_id, target_amount, duration_months, start_date) VALUES
(1, 50000, 3, '2025-07-01');

INSERT INTO Tags (name) VALUES ('vacation'), ('emergency'), ('monthly');

INSERT INTO ExpenseTags (expense_id, tag_id) VALUES (1, 3), (2, 1);

-- 12. Trigger: Limit Expense Amount
DELIMITER //
CREATE TRIGGER LimitExpenseCheck
BEFORE INSERT ON Expenses
FOR EACH ROW
BEGIN
    IF NEW.amount > 100000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Expense exceeds allowed limit of ₹1,00,000';
    END IF;
END;//
DELIMITER ;

-- 13. Trigger: Overspending Alert
DELIMITER //
CREATE TRIGGER OverspendingAlert
AFTER INSERT ON Expenses
FOR EACH ROW
BEGIN
    DECLARE total_spent DECIMAL(10,2);
    DECLARE budget DECIMAL(10,2);

    SELECT SUM(amount) INTO total_spent
    FROM Expenses
    WHERE user_id = NEW.user_id
    AND DATE_FORMAT(spent_at, '%Y-%m') = DATE_FORMAT(NEW.spent_at, '%Y-%m');

    SELECT limit_amount INTO budget
    FROM BudgetLimits
    WHERE user_id = NEW.user_id
    AND month = DATE_FORMAT(NEW.spent_at, '%Y-%m');

    IF total_spent > budget THEN
        INSERT INTO Notifications (user_id, message)
        VALUES (NEW.user_id, CONCAT('You have exceeded your monthly budget for ', DATE_FORMAT(NEW.spent_at, '%Y-%m')));
    END IF;
END;//
DELIMITER ;

-- 14. Trigger: Expense Change Audit Log
DELIMITER //
CREATE TRIGGER LogExpenseChange
AFTER UPDATE ON Expenses
FOR EACH ROW
BEGIN
    IF OLD.amount != NEW.amount THEN
        INSERT INTO ExpenseAudit (expense_id, old_amount, new_amount)
        VALUES (OLD.expense_id, OLD.amount, NEW.amount);
    END IF;
END;//
DELIMITER ;

-- 15. View: CategoryWiseSpending
CREATE VIEW CategoryWiseSpending AS
SELECT
    u.name AS user_name,
    c.name AS category,
    SUM(e.amount) AS total_spent
FROM Expenses e
JOIN Users u ON u.user_id = e.user_id
JOIN Categories c ON c.category_id = e.category_id
GROUP BY u.user_id, c.name;

-- 16. View: UserMonthlyBalance
CREATE VIEW UserMonthlyBalance AS
SELECT
    u.user_id,
    u.name AS user_name,
    IFNULL(i.total_income, 0) - IFNULL(e.total_expense, 0) AS net_balance,
    i.month
FROM
    (SELECT user_id, DATE_FORMAT(received_at, '%Y-%m') AS month, SUM(amount) AS total_income
     FROM Income GROUP BY user_id, month) i
LEFT JOIN
    (SELECT user_id, DATE_FORMAT(spent_at, '%Y-%m') AS month, SUM(amount) AS total_expense
     FROM Expenses GROUP BY user_id, month) e
ON i.user_id = e.user_id AND i.month = e.month
JOIN Users u ON u.user_id = i.user_id;

-- 17. CTE: Category Spending Trend
WITH CategoryTrend AS (
    SELECT
        c.name AS category,
        DATE_FORMAT(e.spent_at, '%Y-%m') AS month,
        SUM(e.amount) AS total
    FROM Expenses e
    JOIN Categories c ON c.category_id = e.category_id
    GROUP BY category, month
)
SELECT * FROM CategoryTrend ORDER BY category, month;

-- 18. Stored Procedure: Get Monthly Report
DELIMITER //
CREATE PROCEDURE GetMonthlyReport(IN uid INT, IN ymonth VARCHAR(7))
BEGIN
    SELECT 'Income' AS Type, c.name AS Category, i.amount, i.received_at AS Date
    FROM Income i
    JOIN Categories c ON c.category_id = i.category_id
    WHERE i.user_id = uid AND DATE_FORMAT(i.received_at, '%Y-%m') = ymonth
    UNION
    SELECT 'Expense', c.name, e.amount, e.spent_at
    FROM Expenses e
    JOIN Categories c ON c.category_id = e.category_id
    WHERE e.user_id = uid AND DATE_FORMAT(e.spent_at, '%Y-%m') = ymonth
    ORDER BY Date;
END;//
DELIMITER ;
