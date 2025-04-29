CREATE DATABASE business_warehouse;
USE business_warehouse;

-- Dimensional Model (Star Schema)
CREATE TABLE Dim_Customer (
    Customer_id INT PRIMARY KEY,
    Customer_name VARCHAR(255),
    City_id INT,
    First_order_date DATE
);

CREATE TABLE Dim_Store (
    Store_id INT PRIMARY KEY,
    City_id INT,
    Store_phone VARCHAR(20)
);

CREATE TABLE Dim_Item (
    Item_id INT PRIMARY KEY,
    Description TEXT,
    Size VARCHAR(50),
    Weight DECIMAL(10,2),
    Unit_price DECIMAL(10,2)
);

CREATE TABLE Dim_Location (
    City_id INT PRIMARY KEY,
    City_name VARCHAR(255),
    State VARCHAR(100)
);

CREATE TABLE Fact_Sales (
    Order_no INT,
    Customer_id INT,
    Store_id INT,
    Item_id INT,
    Quantity_ordered INT,
    Ordered_price DECIMAL(10,2),
    PRIMARY KEY (Order_no, Item_id),
    FOREIGN KEY (Customer_id) REFERENCES Dim_Customer(Customer_id),
    FOREIGN KEY (Store_id) REFERENCES Dim_Store(Store_id),
    FOREIGN KEY (Item_id) REFERENCES Dim_Item(Item_id)
);
