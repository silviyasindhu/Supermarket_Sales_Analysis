-- Create Product Categories Table
CREATE TABLE Categories (
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50)
);

-- Create Products Table
CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
CategoryID INT,
Price DECIMAL(10,2),
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Create Customers Table
CREATE TABLE Customers (
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(100),
City VARCHAR(50)
);

-- Create Sales Table
CREATE TABLE Sales (
SaleID INT PRIMARY KEY,
ProductID INT,
CustomerID INT,
Quantity INT,
SaleDate DATE,
FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert Sample Data into Categories
INSERT INTO Categories VALUES
(1, 'Beverages'),
(2, 'Snacks'),
(3, 'Household');

-- Insert Sample Data into Products
INSERT INTO Products VALUES
(101, 'Coke', 1, 35),
(102, 'Chips', 2, 20),
(103, 'Detergent', 3, 80);

-- Insert Sample Data into Customers
INSERT INTO Customers VALUES
(1, 'Sindhu', 'Chennai'),
(2, 'Rahul', 'Bangalore'),
(3, 'Asha', 'Hyderabad');

-- Insert Sample Data into Sales
INSERT INTO Sales VALUES
(1, 101, 1, 2, '2024-06-01'),
(2, 102, 2, 3, '2024-06-02'),
(3, 103, 3, 1, '2024-06-02'),
(4, 101, 1, 1, '2024-06-03'),
(5, 102, 3, 2, '2024-06-04');

-- Total Sales Amount per Product
SELECT P.ProductName, SUM(S.Quantity * P.Price) AS TotalSales
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY P.ProductName;

-- Total Sales Quantity by Category
SELECT C.CategoryName, SUM(S.Quantity) AS TotalQuantity
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
JOIN Categories C ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName;

-- Top Spending Customer
SELECT CU.CustomerName, SUM(S.Quantity * P.Price) AS TotalSpent
FROM Sales S
JOIN Customers CU ON S.CustomerID = CU.CustomerID
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY CU.CustomerName
ORDER BY TotalSpent DESC
LIMIT 1;

-- Daily Sales Summary
SELECT SaleDate, SUM(S.Quantity * P.Price) AS DailySales
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY SaleDate
ORDER BY SaleDate;
