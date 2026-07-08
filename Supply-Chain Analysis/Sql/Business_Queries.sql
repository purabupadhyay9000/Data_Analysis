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

--1 Total Sales
SELECT SUM("Sales") AS total_sales FROM fact_sales;

--2 Total Profit
SELECT SUM("Order Profit Per Order") AS total_profit FROM fact_sales;

--3 Total Orders
SELECT COUNT(DISTINCT "Order Id") FROM fact_sales;

--4 Total Customers
SELECT COUNT(DISTINCT "Customer Id") FROM fact_sales;

--5 Total Quantity
SELECT SUM("Order Item Quantity") FROM fact_sales;

--6 Average Sales
SELECT ROUND(AVG("Sales"),2) FROM fact_sales;

--7 Average Profit
SELECT ROUND(AVG("Order Profit Per Order"),2) FROM fact_sales;

--8 Profit Margin
SELECT ROUND(SUM("Order Profit Per Order")*100/SUM("Sales"),2) FROM fact_sales;

--9 Monthly Sales
SELECT DATE_TRUNC('month',"order_date"),SUM("Sales")
FROM fact_sales
GROUP BY 1 ORDER BY 1;

--10 Monthly Profit
SELECT DATE_TRUNC('month',"order_date"),SUM("Order Profit Per Order")
FROM fact_sales
GROUP BY 1 ORDER BY 1;

--11 Yearly Sales
SELECT EXTRACT(YEAR FROM "order_date"),SUM("Sales")
FROM fact_sales
GROUP BY 1 ORDER BY 1;

--12 Top Customers
SELECT "Customer Id",SUM("Sales")
FROM fact_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

--13 Repeat Customers
SELECT "Customer Id",COUNT(*)
FROM fact_sales
GROUP BY 1
HAVING COUNT(*)>1;

--14 Customer Lifetime Value
SELECT "Customer Id",SUM("Sales") CLV
FROM fact_sales
GROUP BY 1
ORDER BY CLV DESC;

--15 Top Products
SELECT p."Product Name",SUM(f."Sales")
FROM fact_sales f
JOIN dim_product p
ON f."Product Card Id"=p."Product Card Id"
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

--16 Bottom Products
SELECT p."Product Name",SUM(f."Sales")
FROM fact_sales f
JOIN dim_product p
ON f."Product Card Id"=p."Product Card Id"
GROUP BY 1
ORDER BY 2
LIMIT 10;

--17 Category Sales
SELECT c."Category Name",SUM(f."Sales")
FROM fact_sales f
JOIN dim_category c
ON f."Category Id"=c."Category Id"
GROUP BY 1
ORDER BY 2 DESC;

--18 Category Profit
SELECT c."Category Name",SUM(f."Order Profit Per Order")
FROM fact_sales f
JOIN dim_category c
ON f."Category Id"=c."Category Id"
GROUP BY 1;

--19 Department Sales
SELECT d."Department Name",SUM(f."Sales")
FROM fact_sales f
JOIN dim_department d
ON f."Department Id"=d."Department Id"
GROUP BY 1;

--20 Shipping Mode Sales
SELECT "Shipping Mode",SUM("Sales")
FROM fact_sales
GROUP BY 1;

--21 Delivery Status Count
SELECT "Delivery Status",COUNT(*)
FROM fact_sales
GROUP BY 1;

--22 Average Shipping Days
SELECT AVG("shipping_date"-"order_date")
FROM fact_sales;

--23 Delayed Orders (>5 Days)
SELECT COUNT(*)
FROM fact_sales
WHERE "shipping_date"-"order_date">5;

--24 Running Sales
SELECT "order_date",
SUM("Sales") OVER(ORDER BY "order_date")
FROM fact_sales;

--25 Running Profit
SELECT "order_date",
SUM("Order Profit Per Order") OVER(ORDER BY "order_date")
FROM fact_sales;

--26 Rank Customers
SELECT "Customer Id",
SUM("Sales"),
RANK() OVER(ORDER BY SUM("Sales") DESC)
FROM fact_sales
GROUP BY 1;

--27 Dense Rank Products
SELECT p."Product Name",
SUM(f."Sales"),
DENSE_RANK() OVER(ORDER BY SUM(f."Sales") DESC)
FROM fact_sales f
JOIN dim_product p
ON f."Product Card Id"=p."Product Card Id"
GROUP BY 1;

--28 Row Number Orders
SELECT "Order Id",
ROW_NUMBER() OVER(ORDER BY "Sales" DESC)
FROM fact_sales;

--29 NTILE Customer Segments
SELECT "Customer Id",
SUM("Sales"),
NTILE(4) OVER(ORDER BY SUM("Sales") DESC)
FROM fact_sales
GROUP BY 1;

--30 LAG Sales
SELECT "order_date","Sales",
LAG("Sales") OVER(ORDER BY "order_date")
FROM fact_sales;

--31 LEAD Sales
SELECT "order_date","Sales",
LEAD("Sales") OVER(ORDER BY "order_date")
FROM fact_sales;

--32 Monthly Growth
WITH m AS(
SELECT DATE_TRUNC('month',"order_date") dt,
SUM("Sales") sales
FROM fact_sales
GROUP BY 1)
SELECT dt,sales,
sales-LAG(sales) OVER(ORDER BY dt)
FROM m;

--33 Highest Sales Order
SELECT *
FROM fact_sales
ORDER BY "Sales" DESC
LIMIT 1;

--34 Lowest Sales Order
SELECT *
FROM fact_sales
ORDER BY "Sales"
LIMIT 1;

--35 Negative Profit Orders
SELECT *
FROM fact_sales
WHERE "Order Profit Per Order"<0;

--36 High Value Orders
SELECT *
FROM fact_sales
WHERE "Sales">
(SELECT AVG("Sales") FROM fact_sales);

--37 Sales Contribution by Category
SELECT c."Category Name",
ROUND(SUM(f."Sales")*100/
(SELECT SUM("Sales") FROM fact_sales),2)
FROM fact_sales f
JOIN dim_category c
ON f."Category Id"=c."Category Id"
GROUP BY 1;

--38 Average Product Price
SELECT AVG("Product Price")
FROM dim_product;

--39 Most Expensive Products
SELECT "Product Name","Product Price"
FROM dim_product
ORDER BY "Product Price" DESC
LIMIT 10;

--40 Cheapest Products
SELECT "Product Name","Product Price"
FROM dim_product
ORDER BY "Product Price"
LIMIT 10;

--41 Product Count by Category
SELECT "Product Category Id",COUNT(*)
FROM dim_product
GROUP BY 1;

--42 Customer Segment Count
SELECT "Customer Segment",COUNT(*)
FROM dim_customer
GROUP BY 1;

--43 Department Count
SELECT "Department Name",COUNT(*)
FROM dim_department
GROUP BY 1;

--44 Best Shipping Mode
SELECT "Shipping Mode",
AVG("Order Profit Per Order")
FROM fact_sales
GROUP BY 1
ORDER BY 2 DESC;

--45 Top Product in Each Category
SELECT *
FROM(
SELECT c."Category Name",
p."Product Name",
SUM(f."Sales") sales,
RANK() OVER(
PARTITION BY c."Category Name"
ORDER BY SUM(f."Sales") DESC) rnk
FROM fact_sales f
JOIN dim_product p
ON f."Product Card Id"=p."Product Card Id"
JOIN dim_category c
ON f."Category Id"=c."Category Id"
GROUP BY c."Category Name",p."Product Name") x
WHERE rnk=1;