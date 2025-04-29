USE business_warehouse;

-- Query 1: Find all stores holding a particular item
SELECT s.Store_id, l.City_name, l.State, s.Store_phone, i.Description, i.Size, i.Weight, i.Unit_price
FROM Dim_Store s
JOIN Dim_Location l ON s.City_id = l.City_id
JOIN Fact_Sales f ON s.Store_id = f.Store_id
JOIN Dim_Item i ON f.Item_id = i.Item_id
WHERE i.Item_id = 301;  

-- Query 2: Find orders that can be fulfilled by a given store
SELECT f.Order_no, f.Customer_id, c.Customer_name, f.Quantity_ordered
FROM Fact_Sales f
JOIN Dim_Customer c ON f.Customer_id = c.Customer_id
WHERE f.Store_id = 101;  

-- Query 3: Find all stores holding items ordered by a specific customer
SELECT DISTINCT s.Store_id, l.City_name, s.Store_phone
FROM Dim_Store s
JOIN Dim_Location l ON s.City_id = l.City_id
JOIN Fact_Sales f ON s.Store_id = f.Store_id
WHERE f.Customer_id = 201;  

-- Query 4: Find headquarters address of stores holding items above a stock level
SELECT l.City_name, l.State
FROM Dim_Location l
JOIN Fact_Sales f ON l.City_id = f.Store_id
WHERE f.Quantity_ordered > 10; 

-- Query 5: Find items, quantity ordered, and stores for each order
SELECT f.Order_no, i.Description, f.Quantity_ordered, s.Store_id, l.City_name
FROM Fact_Sales f
JOIN Dim_Item i ON f.Item_id = i.Item_id
JOIN Dim_Store s ON f.Store_id = s.Store_id
JOIN Dim_Location l ON s.City_id = l.City_id;

-- Query 6: Find the city and state where a specific customer lives
SELECT l.City_name, l.State
FROM Dim_Customer c
JOIN Dim_Location l ON c.City_id = l.City_id
WHERE c.Customer_id = 202; 

-- Query 7: Find the stock level of a specific item in all stores in a particular city
SELECT s.Store_id, f.Quantity_ordered
FROM Fact_Sales f
JOIN Dim_Store s ON f.Store_id = s.Store_id
WHERE f.Item_id = 301 AND s.City_id = 1;  

-- Query 8: Find items, quantity ordered, customer, store, and city of an order
SELECT f.Order_no, i.Description, f.Quantity_ordered, c.Customer_name, s.Store_id, l.City_name
FROM Fact_Sales f
JOIN Dim_Customer c ON f.Customer_id = c.Customer_id
JOIN Dim_Item i ON f.Item_id = i.Item_id
JOIN Dim_Store s ON f.Store_id = s.Store_id
JOIN Dim_Location l ON s.City_id = l.City_id
WHERE f.Order_no = 401;  

-- Query 9: Find walk-in, mail-order, and dual customers
SELECT c.Customer_id, c.Customer_name,
       CASE 
           WHEN w.Customer_id IS NOT NULL AND m.Customer_id IS NOT NULL THEN 'Dual Customer'
           WHEN w.Customer_id IS NOT NULL THEN 'Walk-in Customer'
           WHEN m.Customer_id IS NOT NULL THEN 'Mail Order Customer'
       END AS Customer_Type
FROM Dim_Customer c
LEFT JOIN business_sales.Walk_in_customers w ON c.Customer_id = w.Customer_id
LEFT JOIN business_sales.Mail_order_customers m ON c.Customer_id = m.Customer_id;


-- Insert sample data into Dim_Customer
INSERT INTO Dim_Customer (Customer_id, Customer_name, City_id, First_order_date) VALUES
(201, 'Amit Sharma', 1, '2025-01-01'),
(202, 'Priya Verma', 2, '2025-02-15'),
(203, 'Rahul Mehta', 3, '2025-03-10'),
(204, 'Sanya Kapoor', 4, '2025-04-05');

-- Insert sample data into Dim_Store
INSERT INTO Dim_Store (Store_id, City_id, Store_phone) VALUES
(101, 1, '9876543210'),
(102, 2, '9123456780'),
(103, 3, '9988776655'),
(104, 4, '9001122334');

-- Insert sample data into Dim_Item
INSERT INTO Dim_Item (Item_id, Description, Size, Weight, Unit_price) VALUES
(301, 'Dell Laptop', '15 inch', 1.5, 60000.00),
(302, 'Samsung Galaxy', '6 inch', 0.2, 25000.00),
(303, 'Sony Headphones', 'Medium', 0.5, 5000.00),
(304, 'Apple iPad', '10 inch', 1.0, 45000.00);

-- Insert sample data into Dim_Location
INSERT INTO Dim_Location (City_id, City_name, State) VALUES
(1, 'Mumbai', 'Maharashtra'),
(2, 'Delhi', 'Delhi'),
(3, 'Bengaluru', 'Karnataka'),
(4, 'Kolkata', 'West Bengal');

-- Insert sample data into Fact_Sales
INSERT INTO Fact_Sales (Order_no, Customer_id, Store_id, Item_id, Quantity_ordered, Ordered_price) VALUES
(401, 201, 101, 301, 1, 60000.00),
(402, 202, 102, 302, 2, 50000.00),
(403, 203, 103, 303, 1, 5000.00),
(404, 204, 104, 304, 1, 45000.00);