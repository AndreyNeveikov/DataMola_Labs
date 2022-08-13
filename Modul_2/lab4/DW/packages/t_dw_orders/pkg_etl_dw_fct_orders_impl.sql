alter session set current_schema=DW_CL;
GRANT SELECT ON DW_CL.t_cl_transactions TO DW_DATA;

alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_fct_orders
AS  
  PROCEDURE LOAD_DW_FCT_ORDERS
   AS
     BEGIN
      DECLARE
      
       TYPE CURSOR_INT IS TABLE OF int;
	   TYPE CURSOR_VARCHAR IS TABLE OF varchar2(15);
       TYPE CURSOR_DATE IS TABLE OF date;
       TYPE CURSOR_FLOAT IS TABLE OF float;
	   TYPE BIG_CURSOR IS REF CURSOR ;
	
	   ALL_INF BIG_CURSOR;
	   
	   order_id CURSOR_INT;
       client_id CURSOR_INT;
       doer_id CURSOR_INT;
       region_id CURSOR_INT;
       currency_id CURSOR_INT;
       date_id CURSOR_DATE;
       employee_id CURSOR_INT;
       product_name CURSOR_VARCHAR;
       order_price CURSOR_FLOAT;
       order_status CURSOR_VARCHAR;
       order_date CURSOR_DATE;
       receiving_date CURSOR_DATE; 

	BEGIN
	   OPEN ALL_INF FOR
	       SELECT
                dw_ord.order_id
              , cl.client_id
              , dr.doer_id
              , reg.region_id
              , cur.currency_id
              , calen.date_id
              , emp.employee_id
              , source_cl.product_name
              , source_cl.order_price
              , source_cl.order_status
              , source_cl.order_date
              , source_cl.receiving_date
	          FROM (SELECT DISTINCT *
                           FROM DW_CL.t_cl_transactions) source_cl
                     INNER JOIN 
                        DW_DATA.t_dw_customers cl
                     ON (source_cl.client_id=cl.client_id)
                     INNER JOIN 
                        DW_DATA.t_dw_doers dr
                     ON (source_cl.doer_id=dr.doer_id)
                     INNER JOIN
                        DW_DATA.t_dw_currencies cur
                     ON (source_cl.currency_code=cur.currency_code)
                     INNER JOIN 
                        DW_DATA.t_dw_financial_calendar calen
                     ON (source_cl.date_id=calen.date_id)
                     INNER JOIN 
                        DW_DATA.t_dw_regions reg
                     ON (source_cl.region_id=reg.region_id)
                     INNER JOIN 
                        DW_DATA.t_dw_employees emp
                     ON (source_cl.employee_id=emp.employee_id)
                     LEFT JOIN 
                        DW_DATA.t_dw_fct_orders dw_ord
                     ON (cl.client_id=dw_ord.client_id AND calen.date_id=dw_ord.date_id AND
                         cur.currency_id=dw_ord.currency_id AND dr.doer_id=dw_ord.doer_id);

	
	   FETCH ALL_INF
	   BULK COLLECT INTO
                order_id
              , client_id
              , doer_id
              , region_id
              , currency_id
              , date_id
              , employee_id
              , product_name
              , order_price
              , order_status
              , order_date
              , receiving_date;  
                
	   CLOSE ALL_INF;
	
	   FOR i IN ORDER_ID.FIRST .. ORDER_ID.LAST LOOP 
       
	      IF ( ORDER_ID ( i ) IS NULL ) THEN
	         INSERT INTO dw_data.t_dw_fct_orders (ORDER_ID
                                                , client_id
                                                , doer_id
                                                , region_id
                                                , currency_id
                                                , date_id
                                                , employee_id
                                                , product_name
                                                , order_price
                                                , order_status
                                                , order_date
                                                , receiving_date)
	              VALUES ( SEQ_FCT_ORDERS.NEXTVAL
	                     , client_id (i)
                         , doer_id (i)
                         , region_id (i)
                         , currency_id (i)
                         , date_id (i)
                         , employee_id (i)
                         , product_name (i)
                         , order_price (i)
                         , order_status (i)
                         , order_date (i)
                         , receiving_date (i));       
	         COMMIT;
	      END IF;
	   END LOOP;
	END;
   END LOAD_DW_FCT_ORDERS;
END pkg_etl_dw_fct_orders;

alter session set current_schema=DW_DATA;
exec pkg_etl_dw_fct_orders.LOAD_DW_FCT_ORDERS;
select * from t_dw_fct_orders;

commit;