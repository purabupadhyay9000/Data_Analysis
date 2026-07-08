/*====================================================
STEP 1 : Create Fact Table
Stores all numerical business transactions
====================================================*/

CREATE TABLE fact_sales AS
SELECT
    "Order Id",
    "Customer Id",
    "Product Card Id",
    "Category Id",
    "Department Id",
    "Order Item Quantity",
    "Sales",
    "Order Profit Per Order",
    "Shipping Mode",
    "Delivery Status",
    "order_date",
    "shipping_date"
FROM supply_chain;

/*====================================================
STEP 2 : Create Customer Dimension
Stores customer-related information
====================================================*/

CREATE TABLE dim_customer AS
SELECT DISTINCT
    "Customer Id",
    "Customer Fname",
    "Customer Lname",
    "Customer Segment",
    "Customer City",
    "Customer State"
FROM supply_chain;

/*====================================================
STEP 2 : Create Customer Dimension
Stores customer-related information
====================================================*/

CREATE TABLE dim_customer AS
SELECT DISTINCT
    "Customer Id",
    "Customer Fname",
    "Customer Lname",
    "Customer Segment",
    "Customer City",
    "Customer State"
FROM supply_chain;

/*====================================================
STEP 3 : Create Product Dimension
Stores product details
====================================================*/

CREATE TABLE dim_product AS
SELECT DISTINCT
    "Product Card Id",
    "Product Name",
    "Product Price",
    "Product Status"
FROM supply_chain;

/*====================================================
STEP 4 : Create Category Dimension
Stores category information
====================================================*/

CREATE TABLE dim_category AS
SELECT DISTINCT
    "Category Id",
    "Category Name"
FROM supply_chain;


/*====================================================
STEP 5 : Create Department Dimension
Stores department information
====================================================*/

CREATE TABLE dim_department AS
SELECT DISTINCT
    "Department Id",
    "Department Name"
FROM supply_chain;


/*====================================================
STEP 6 : Create Shipping Dimension
Stores shipping details
====================================================*/

CREATE TABLE dim_shipping AS
SELECT DISTINCT
    "Shipping Mode",
    "Delivery Status"
FROM supply_chain;


/*====================================================
STEP 7 : Create Location Dimension
Stores geographical information
====================================================*/

CREATE TABLE dim_location AS
SELECT DISTINCT
    "Order Country",
    "Order Region",
    "Order State",
    "Order City",
    "Order Zipcode",
    "Market",
    "Latitude",
    "Longitude"
FROM supply_chain;

/*====================================================
STEP 8 : Create Date Dimension
Stores calendar attributes
====================================================*/

CREATE TABLE dim_date AS
SELECT DISTINCT

    order_date,

    EXTRACT(DAY FROM order_date) AS day,

    EXTRACT(MONTH FROM order_date) AS month,

    TO_CHAR(order_date,'Month') AS month_name,

    EXTRACT(QUARTER FROM order_date) AS quarter,

    EXTRACT(YEAR FROM order_date) AS year,

    EXTRACT(WEEK FROM order_date) AS week_no,

    TO_CHAR(order_date,'Day') AS day_name

FROM supply_chain;


/*====================================================
STEP 9 : Add Primary Keys
====================================================*/

ALTER TABLE dim_customer
ADD PRIMARY KEY ("Customer Id");

ALTER TABLE dim_product
ADD PRIMARY KEY ("Product Card Id");

ALTER TABLE dim_category
ADD PRIMARY KEY ("Category Id");

ALTER TABLE dim_department
ADD PRIMARY KEY ("Department Id");

ALTER TABLE dim_date
ADD PRIMARY KEY (order_date);


/*====================================================
STEP 10 : Add Foreign Keys
====================================================*/

ALTER TABLE fact_sales
ADD CONSTRAINT fk_customer
FOREIGN KEY ("Customer Id")
REFERENCES dim_customer("Customer Id");

ALTER TABLE fact_sales
ADD CONSTRAINT fk_product
FOREIGN KEY ("Product Card Id")
REFERENCES dim_product("Product Card Id");

ALTER TABLE fact_sales
ADD CONSTRAINT fk_category
FOREIGN KEY ("Category Id")
REFERENCES dim_category("Category Id");

ALTER TABLE fact_sales
ADD CONSTRAINT fk_department
FOREIGN KEY ("Department Id")
REFERENCES dim_department("Department Id");

ALTER TABLE fact_sales
ADD CONSTRAINT fk_date
FOREIGN KEY (order_date)
REFERENCES dim_date(order_date);

/*====================================================
STEP 11 : Verify Row Counts
====================================================*/

SELECT COUNT(*) FROM fact_sales;

SELECT COUNT(*) FROM dim_customer;

SELECT COUNT(*) FROM dim_product;

SELECT COUNT(*) FROM dim_category;

SELECT COUNT(*) FROM dim_department;

SELECT COUNT(*) FROM dim_shipping;

SELECT COUNT(*) FROM dim_location;

SELECT COUNT(*) FROM dim_date;