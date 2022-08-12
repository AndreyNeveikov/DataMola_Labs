alter session set current_schema=DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cl_orders
AS  
   PROCEDURE LOAD_CLEAN_ORDERS;
END pkg_etl_cl_orders;

--drop package pkg_etl_cl_orders;