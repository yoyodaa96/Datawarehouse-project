/*
=================================================================
DDL Script: create bronze tables
=================================================================



if object_id ('bronze.crm_cust_info','U') is not null
	drop table bronze.crm_cust_info;

create table bronze.crm_cust_info(
cst_id int,
cast_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_material_status NVARCHAR(50),
cst_gndr NVARCHAR(50),
cst_create_date date
)
if object_id ('bronze.crm_prd_info','U') is not null
	drop table bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);

if object_id ('bronze.crm_sales_details','U') is not null
	drop table bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);

--create erp tables

if object_id ('bronze.erp_loc_a101','U') is not null
	drop table bronze.erp_loc_a101;

CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);
if object_id ('bronze.erp_cust_az12','U') is not null
	drop table bronze.erp_cust_az12;

CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);
if object_id ('bronze.erp_px_cat_g1v2','U') is not null
	drop table bronze.erp_px_cat_g1v2;

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);

--insert data in tables
create or alter procedure bronze.load_bronze as 
begin
begin try
print '=============================='
print 'Loading bronze layer' 
print '=============================='


print '------------------------------'
print 'Loading CRM layer' 
print '------------------------------'

truncate table bronze.crm_cust_info;

bulk insert bronze.crm_cust_info
from 'C:\Users\daalo\Desktop\projet DWH\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with (
	firstrow=2,
	fieldterminator= ',',
	tablock
);


truncate table bronze.crm_prd_info;

bulk insert bronze.crm_prd_info
from 'C:\Users\daalo\Desktop\projet DWH\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with (
	firstrow=2,
	fieldterminator= ',',
	tablock
);


truncate table bronze.crm_sales_details;

bulk insert bronze.crm_sales_details
from 'C:\Users\daalo\Desktop\projet DWH\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with (
	firstrow=2,
	fieldterminator= ',',
	tablock
);



print '------------------------------'
print 'Loading ERP layer' 
print '------------------------------'


truncate table bronze.erp_loc_a101;

bulk insert bronze.erp_loc_a101
from 'C:\Users\daalo\Desktop\projet DWH\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
with (
	firstrow=2,
	fieldterminator= ',',
	tablock
);

truncate table bronze.erp_cust_az12;


bulk insert bronze.erp_cust_az12
from 'C:\Users\daalo\Desktop\projet DWH\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
with (
	firstrow=2,
	fieldterminator= ',',
	tablock
);

truncate table bronze.erp_px_cat_g1v2;


bulk insert bronze.erp_px_cat_g1v2
from 'C:\Users\daalo\Desktop\projet DWH\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
with (
	firstrow=2,
	fieldterminator= ',',
	tablock
)
end try
begin catch
	print '==================='
	print 'ERROR OCCURED DURING BRONZE LAYER LOAD'
	print '==================='
end catch
end;
