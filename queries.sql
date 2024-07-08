-- Multi-Table Query Practice --

-- Display the ProductName and CategoryName for all products in the database. Shows 77 records. --

SELECT p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID;


-- Display the order Id and shipper CompanyName for all orders placed before August 9 2012. Shows 429 records. --

SELECT o.OrderID, c.CompanyName
FROM Orders o
JOIN Shippers s ON o.ShipVia = s.ShipperID
WHERE o.OrderDate < '2012-08-09';

-- Display the name and quantity of the products ordered in order with Id 10251. Sort by ProductName. Shows 3 records. --

SELECT p.ProductName, od.Quantity
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
WHERE od.OrderID = 10251
ORDER BY p.ProductName;

-- Display the OrderID, Customer's Company Name and the employee's LastName for every order. All columns should be labeled clearly. Displays 16,789 records. --

SELECT o.OrderID, c.CompanyName AS CustomerName, e.LastName AS EmployeeLastName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID;

-- STRETCH PROBLEMS --

-- Number of shipments by each shipper --

SELECT s.ShipperName, COUNT(*) AS Shipments
FROM Orders o
JOIN Shippers s ON o.ShipperID = s.ShipperID
GROUP BY s.ShipperName;

-- Top 5 best performing employees  measured in number of orders --

SELECT e.LastName, COUNT(*) AS NumberOfOrders
FROM Orders o
JOIN Employees e ON o.EmployeeID = e.EmployeeID
GROUP BY e.LastName
ORDER BY NumberOfOrders DESC
LIMIT 5;

-- Top 5 best performing employees measured in revenue --

SELECT e.LastName, SUM(od.Quantity * od.UnitPrice) AS Revenue
FROM Orders o
JOIN Employees e ON o.EmployeeID = e.EmployeeID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY e.LastName
ORDER BY Revenue DESC
LIMIT 5;

-- Category that brings in the least revenue --

SELECT c.CategoryName, SUM(od.Quantity * od.UnitPrice) AS Revenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY Revenue ASC
LIMIT 1;

-- Customer country with the most orders --

SELECT c.Country, COUNT(*) AS NumberOfOrders
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Country
ORDER BY NumberOfOrders DESC
LIMIT 1;

-- Shipper that moves the most cheese measured in units --

SELECT s.CompanyName, SUM(od.Quantity) AS CheeseUnits
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Shippers s ON o.ShipVia = s.ShipperID
WHERE p.ProductName LIKE '%cheese%'
GROUP BY s.CompanyName
ORDER BY CheeseUnits DESC
LIMIT 1;