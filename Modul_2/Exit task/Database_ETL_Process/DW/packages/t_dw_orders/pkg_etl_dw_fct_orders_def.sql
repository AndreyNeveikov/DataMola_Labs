alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_fct_orders
AS  
   PROCEDURE LOAD_DW_FCT_ORDERS;
END pkg_etl_dw_fct_orders;

alter session set current_schema=DW_DATA;
drop package pkg_etl_dw_fct_orders;