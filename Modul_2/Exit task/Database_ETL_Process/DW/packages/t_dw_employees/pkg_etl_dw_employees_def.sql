alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_employees
AS  
   PROCEDURE LOAD_DW_EMPLOYEES;
END pkg_etl_dw_employees;

alter session set current_schema=DW_DATA;
drop package pkg_etl_dw_employees;