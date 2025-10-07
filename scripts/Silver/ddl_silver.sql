
--This code creates the tables in the silver layout


--create tables for silver layer

if object_id ('silver.crm_cust_info','U') is not null
	drop table silver.crm_cust_info;

create table silver.crm_cust_info(
cst_id int,
cast_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_material_status NVARCHAR(50),
cst_gndr NVARCHAR(50),
cst_create_date date
)
if object_id ('silver.crm_prd_info','U') is not null
	drop table silver.crm_prd_info;

CREATE TABLE silver.crm_prd_info (
    prd_id       INT,
	cat_id       NVARCHAR(50),
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt   DATE
);

if object_id ('silver.crm_sales_details','U') is not null
	drop table silver.crm_sales_details;

CREATE TABLE silver.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt date,
    sls_ship_dt  date,
    sls_due_dt   date,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);

--create erp tables

if object_id ('silver.erp_loc_a101','U') is not null
	drop table silver.erp_loc_a101;

CREATE TABLE silver.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);
if object_id ('silver.erp_cust_az12','U') is not null
	drop table silver.erp_cust_az12;

CREATE TABLE silver.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);
if object_id ('silver.erp_px_cat_g1v2','U') is not null
	drop table silver.erp_px_cat_g1v2;

CREATE TABLE silver.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);

