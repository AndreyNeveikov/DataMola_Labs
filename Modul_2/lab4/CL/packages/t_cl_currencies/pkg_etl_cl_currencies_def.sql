alter session set current_schema=DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cl_currencies
AS  
   PROCEDURE LOAD_CLEAN_CURRENCY;
END pkg_etl_cl_currencies;

--drop package pkg_etl_cl_currencies;