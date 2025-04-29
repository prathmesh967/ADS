CREATE DATABASE business_hq;
USE business_hq;

-- Headquarters Relation
CREATE TABLE Headqarters (
    City_id INT PRIMARY KEY,
    City_name VARCHAR(255) NOT NULL,
    Headquarter_addr TEXT NOT NULL,
    State VARCHAR(100) NOT NULL,
);

-- Product and Inventory Relations
CREATE TABLE Items (
    Item_id INT PRIMARY KEY,
    Description TEXT,
    Size VARCHAR(50),
    Weight DECIMAL(10,2),
    Unit_price DECIMAL(10,2),
);

CREATE TABLE Stored_items (
    Store_id INT,
    Item_id INT,
    Quantity_held INT,
    PRIMARY KEY (Store_id, Item_id)
);

-- Order Relations
CREATE TABLE `Order` (
    Order_no INT PRIMARY KEY,
    Order_date DATE NOT NULL,
    Customer_id INT NOT NULL
);

CREATE TABLE Ordered_item (
    Order_no INT,
    Item_id INT,
    Quantity_ordered INT NOT NULL,
    Ordered_price DECIMAL(10,2),
    PRIMARY KEY (Order_no, Item_id)
);
