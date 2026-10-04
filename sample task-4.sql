CREATE DATABASE orders;
USE orders;
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50) NOT NULL
);
INSERT INTO Customer VALUES
(1, 'Dharshini'),
(2, 'Priya'),
(3, 'Anu');
CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);
INSERT INTO Product VALUES
(1, 'Mobile Phone', 25000),
(2, 'Laptop', 50000),
(3, 'Headphone', 1500);
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Order_Date DATE,
    Total_Amount DECIMAL(10,2),
    Status VARCHAR(20),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    CHECK (Total_Amount >= 0)
);
CREATE TABLE Order_Details (
    Order_Detail_ID INT PRIMARY KEY,
    Order_ID INT,
    Product_ID INT,
    Quantity INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    CHECK (Quantity > 0)
);
INSERT INTO Orders VALUES
(101, 1, '2026-10-01', 5000, 'Pending'),
(102, 2, '2026-10-02', 3000, 'Delivered'),
(103, 3, '2026-10-03', 4500, 'Pending');
INSERT INTO Order_Details VALUES
(1, 101, 1, 2, 2500),
(2, 102, 2, 1, 3000),
(3, 103, 3, 3, 1500);
UPDATE Orders
SET Status = 'Delivered'
WHERE Order_ID = 101;
UPDATE Order_Details
SET Quantity = 3
WHERE Order_Detail_ID = 1;
DELETE FROM Order_Details
WHERE Order_ID = 103;

DELETE FROM Orders
WHERE Order_ID = 103;
SELECT Customer.Customer_Name,
       Orders.Order_ID,
       Orders.Order_Date,
       Orders.Total_Amount,
       Orders.Status
FROM Customer
JOIN Orders
ON Customer.Customer_ID = Orders.Customer_ID;
SELECT Customer.Customer_Name,
       SUM(Orders.Total_Amount) AS Total_Spending
FROM Customer
JOIN Orders
ON Customer.Customer_ID = Orders.Customer_ID
GROUP BY Customer.Customer_Name;
SELECT SUM(Total_Amount) AS Total_Sales
FROM Orders;
SELECT 
    Customer.Customer_Name,
    COUNT(Orders.Order_ID) AS Total_Orders
FROM Customer
JOIN Orders
ON Customer.Customer_ID = Orders.Customer_ID
GROUP BY Customer.Customer_ID, Customer.Customer_Name
ORDER BY Total_Orders DESC;
