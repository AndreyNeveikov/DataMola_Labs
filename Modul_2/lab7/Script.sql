alter session set current_schema=DW_DATA;
drop MATERIALIZED VIEW mv_daily_profit;

alter session set current_schema=DW_DATA;
CREATE MATERIALIZED VIEW mv_daily_profit
BUILD DEFERRED
REFRESH COMPLETE ON DEMAND
AS SELECT product_name, client_address, order_date,  sum(order_price) profit,

   GROUPING(product_name) name_,
   GROUPING(client_address) address,
   GROUPING(order_date) date_,
   
   GROUPING_ID(product_name, client_address) name_address,
   GROUPING_ID(client_address, product_name) address_name,
   GROUPING_ID(product_name, order_date) name_date,
   GROUPING_ID(client_address, order_date) address_date,
   
   GROUPING_ID(client_address, product_name, order_date) address_name_date,
   GROUPING_ID(client_address, order_date, product_name) address_date_name,
   GROUPING_ID(order_date, product_name, client_address) date_name_address
   
   FROM DW_DATA.t_dw_fct_orders fct_ord
   LEFT JOIN t_dw_customers  cust ON cust.client_id = fct_ord.client_id
   WHERE date_id  >= TO_DATE( '03.01.20', 'MM/DD/YY' ) AND date_id  < TO_DATE( '04.01.20', 'MM/DD/YY' )
   GROUP BY CUBE(product_name, client_address, order_date);


EXECUTE DBMS_MVIEW.REFRESH('mv_daily_profit');

SELECT * FROM  mv_daily_profit;

commit;

