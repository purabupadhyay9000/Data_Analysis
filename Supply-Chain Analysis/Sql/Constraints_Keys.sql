/*====================================================
 Add Primary Key
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
 Add Foreign Keys
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
