USE business_warehouse;

-- Extract and Load Customers
INSERT INTO Dim_Customer (Customer_id, Customer_name, City_id, First_order_date)
SELECT Customer_id, Customer_name, City_id, First_order_date FROM business_sales.Customer;

-- Extract and Load Stores
INSERT INTO Dim_Store (Store_id, City_id, Store_phone)
SELECT Store_id, City_id, Phone FROM business_sales.Stores;

-- Extract and Load Items
INSERT INTO Dim_Item (Item_id, Description, Size, Weight, Unit_price)
SELECT Item_id, Description, Size, Weight, Unit_price FROM business_hq.Items;

-- Extract and Load Locations
INSERT INTO Dim_Location (City_id, City_name, State)
SELECT City_id, City_name, State FROM business_hq.Headqarters;

-- Extract and Load Sales Fact Table
INSERT INTO Fact_Sales (Order_no, Customer_id, Store_id, Item_id, Quantity_ordered, Ordered_price)
SELECT o.Order_no, o.Customer_id, s.Store_id, oi.Item_id, oi.Quantity_ordered, oi.Ordered_price
FROM business_hq.Ordered_item oi
JOIN business_hq.`Order` o ON oi.Order_no = o.Order_no
JOIN business_hq.Stored_items si ON oi.Item_id = si.Item_id
JOIN business_sales.Stores s ON si.Store_id = s.Store_id;


