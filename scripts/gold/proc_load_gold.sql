

IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;


create view gold.dim_customers as 
select 
row_number() over (order by cst_id) as customer_key,
ci.cst_id as customer_id,
ci.cast_key as customer_number,
ci.cst_lastname as first_name,
ci.cst_firstname as last_name,
la.cntry as country,
ci.cst_material_status as marital_status,
case when ci.cst_gndr != 'n/a' then ci.cst_gndr
else coalesce (ca.gen, 'n/a')end  as gender,
ca.bdate as birthdate,
ci.cst_create_date as create_date
from silver.crm_cust_info ci
left join silver.erp_cust_az12 ca on ci.cast_key=ca.cid
left join silver.erp_loc_a101 la on ci.cast_key=la.cid;



IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;


create view gold.dim_products as 
select 
row_number() over (order by pn.prd_start_dt, pn.prd_key) as product_key,
pn.prd_id as product_id,
pn.prd_key as product_number,
pn.prd_nm as product_name,
pn.cat_id as category_id,
pc.cat as category,
pc.subcat as subcategory,
pc.maintenance,
pn.prd_cost as cost,
pn.prd_line as product_line,
pn.prd_start_dt as start_date

from silver.crm_prd_info pn 

left join silver.erp_px_cat_g1v2 pc on pn.cat_id=pc.id
where prd_end_dt is null;      



IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;


CREATE VIEW gold.fact_sales AS
SELECT
    sd.sls_ord_num  AS order_number,
    pr.product_key  AS product_key,
    cu.customer_key AS customer_key,
    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt  AS shipping_date,
    sd.sls_due_dt   AS due_date,
    sd.sls_sales    AS sales_amount,
    sd.sls_quantity AS quantity,
    sd.sls_price    AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
    ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
    ON sd.sls_cust_id = cu.customer_id;


