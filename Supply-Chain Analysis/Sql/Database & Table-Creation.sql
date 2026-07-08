/*=========================================
Create Database
=========================================*/

CREATE DATABASE supply_chain_db;

/*=========================================
Main Supply Chain Table
Stores raw dataset imported from CSV
=========================================*/

CREATE TABLE supply_chain (

    "Type" VARCHAR(50),
    "Days for shipping (real)" INTEGER,
    "Days for shipment (scheduled)" INTEGER,
    "Benefit per order" NUMERIC(12,2),
    "Sales per customer" NUMERIC(12,2),

    "Delivery Status" VARCHAR(100),
    "Late_delivery_risk" INTEGER,

    "Category Id" INTEGER,
    "Category Name" VARCHAR(100),

    "Customer City" VARCHAR(100),
    "Customer Country" VARCHAR(100),
    "Customer Email" VARCHAR(200),
    "Customer Fname" VARCHAR(100),
    "Customer Id" INTEGER,
    "Customer Lname" VARCHAR(100),
    "Customer Password" VARCHAR(255),
    "Customer Segment" VARCHAR(100),
    "Customer State" VARCHAR(100),
    "Customer Street" TEXT,
    "Customer Zipcode" VARCHAR(20),

    "Department Id" INTEGER,
    "Department Name" VARCHAR(100),

    Latitude NUMERIC(10,6),
    Longitude NUMERIC(10,6),

    Market VARCHAR(100),

    "Order City" VARCHAR(100),
    "Order Country" VARCHAR(100),
    "Order Customer Id" INTEGER,
    "order_date" TIMESTAMP,
    "Order Id" INTEGER,
    "Order Item Cardprod Id" INTEGER,
    "Order Item Discount" NUMERIC(12,2),
    "Order Item Discount Rate" NUMERIC(12,2),
    "Order Item Id" INTEGER,
    "Order Item Product Price" NUMERIC(12,2),
    "Order Item Profit Ratio" NUMERIC(12,2),
    "Order Item Quantity" INTEGER,
    Sales NUMERIC(12,2),
    "Order Item Total" NUMERIC(12,2),
    "Order Profit Per Order" NUMERIC(12,2),
    "Order Region" VARCHAR(100),
    "Order State" VARCHAR(100),
    "Order Status" VARCHAR(100),
    "Order Zipcode" VARCHAR(20),

    "Product Card Id" INTEGER,
    "Product Category Id" INTEGER,
    "Product Description" TEXT,
    "Product Image" TEXT,
    "Product Name" VARCHAR(255),
    "Product Price" NUMERIC(12,2),
    "Product Status" INTEGER,

    shipping_date TIMESTAMP,

    "Shipping Mode" VARCHAR(100)
);


-- Here I User Import Method to load the data--

/*=========================================
Display Table Structure
=========================================*/

SELECT *
FROM supply_chain
LIMIT 10;