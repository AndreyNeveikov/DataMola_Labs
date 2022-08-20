alter session set current_schema=SAL_CL;
drop view v_sal_orders;

alter session set current_schema=SAL_CL;
GRANT SELECT ON DW_DATA.t_dw_fct_orders TO SAL_CL;

alter session set current_schema=SAL_CL;

CREATE OR REPLACE VIEW v_sal_orders
AS SELECT product_name, order_status, order_date,  sum(order_price) profit,

   GROUPING(product_name) name_,
   GROUPING(order_status) status,
   GROUPING(order_date) date_,
   
   GROUPING_ID(product_name, order_status) name_status,
   GROUPING_ID(order_status, product_name) status_name,
   GROUPING_ID(product_name, order_date) name_date,
   GROUPING_ID(order_status, order_date) status_date,
   
   GROUPING_ID(order_status, product_name, order_date) status_name_date,
   GROUPING_ID(order_status, order_date, product_name) status_date_name,
   GROUPING_ID(order_date, product_name, order_status) date_name_status
   
   FROM DW_DATA.t_dw_fct_orders fct_ord
   WHERE (date_id  >= TO_DATE( '03.01.20', 'MM/DD/YY' ) AND date_id  < TO_DATE( '04.01.20', 'MM/DD/YY' )) AND order_status = 'Accepted'
   GROUP BY CUBE(product_name, order_status, order_date);
   
alter session set current_schema=SAL_CL;
SELECT * FROM v_sal_orders;