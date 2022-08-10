alter session set current_schema=SA_ORDERS;
GRANT SELECT ON SA_ORDERS.t_sa_orders TO DW_CL; 

alter session set current_schema=DW_CL;
CREATE OR REPLACE PACKAGE body pkg_etl_cl_orders
AS  
  PROCEDURE LOAD_CLEAN_ORDERS
   AS   
      CURSOR curs_cl_orders
      IS
         SELECT DISTINCT 
                  product_name
                , order_price
                , order_status
                , order_date
                , receiving_date
           FROM SA_ORDERS.t_sa_orders
           WHERE product_name IS NOT NULL 
           AND order_price IS NOT NULL
           AND order_status IS NOT NULL
           AND order_date IS NOT NULL
           AND receiving_date IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.t_cl_orders';
      FOR i IN curs_cl_orders LOOP
         INSERT INTO DW_CL.t_cl_orders( 
                         product_name
                       , order_price
                       , order_status
                       , order_date
                       , receiving_date)
              VALUES ( i.product_name
                     , i.order_price 
                     , i.order_status
                     , i.order_date
                     , i.receiving_date);

         EXIT WHEN curs_cl_orders%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_ORDERS;
END pkg_etl_cl_orders;


alter session set current_schema=DW_CL;
exec pkg_etl_cl_orders.LOAD_CLEAN_ORDERS;
select * from t_cl_orders;

commit;

