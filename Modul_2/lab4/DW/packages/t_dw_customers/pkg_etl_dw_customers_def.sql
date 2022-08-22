alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_customers
AS  
   PROCEDURE LOAD_DW_CUSTOMERS;
END pkg_etl_dw_customers;

alter session set current_schema=DW_DATA;
drop package pkg_etl_dw_customers;