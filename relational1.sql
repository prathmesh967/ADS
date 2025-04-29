CREATE DATABASE business_sales;
USE business_sales;

CREATE TABLE Customer (
    Customer_id INT PRIMARY KEY,
    Customer_name VARCHAR(255) NOT NULL,
    City_id INT NOT NULL,
    First_order_date DATE
);

CREATE TABLE Walk_in_customers (
    Customer_id INT PRIMARY KEY,
    Tourism_guide VARCHAR(255),
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id)
);

CREATE TABLE Mail_order_customers (
    Customer_id INT PRIMARY KEY,
    Post_address TEXT,
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id)
);

CREATE TABLE Stores (
    Store_id INT PRIMARY KEY,
    City_id INT NOT NULL,
    Phone VARCHAR(20),
);
