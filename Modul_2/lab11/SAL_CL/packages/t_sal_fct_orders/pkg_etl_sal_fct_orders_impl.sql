alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.t_dw_fct_orders TO SAL_CL;

alter session set current_schema=SAL_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_sal_fct_orders
AS  
  PROCEDURE LOAD_SAL_FCT_ORDERS
   AS
     BEGIN
     MERGE INTO SAL_CL.t_sal_fct_orders A
     USING ( SELECT 
order_id,
client_id,
doer_id,
region_id,
currency_id,
date_id,
employee_id,
product_name,
order_price,
order_status,
order_date,
receiving_date
             FROM DW_DATA.t_dw_fct_orders) B
             ON (a.order_id = b.order_id)
             WHEN MATCHED THEN 
                UPDATE SET a.order_price = b.order_price
             WHEN NOT MATCHED THEN 
                INSERT (
a.order_id,
a.client_id,
a.doer_id,
a.region_id,
a.currency_id,
a.date_id,
a.employee_id,
a.product_name,
a.order_price,
a.order_status,
a.order_date,
a.receiving_date
)
                VALUES (
b.order_id,
b.client_id,
b.doer_id,
b.region_id,
b.currency_id,
b.date_id,
b.employee_id,
b.product_name,
b.order_price,
b.order_status,
b.order_date,
b.receiving_date
);
     COMMIT;
   END LOAD_SAL_FCT_ORDERS;
END pkg_etl_sal_fct_orders;

alter session set current_schema=SAL_CL;
exec pkg_etl_sal_fct_orders.LOAD_SAL_FCT_ORDERS;
select * from t_sal_fct_orders;

commit;