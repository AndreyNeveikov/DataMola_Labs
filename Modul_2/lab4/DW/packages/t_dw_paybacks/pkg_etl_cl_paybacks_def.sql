alter session set current_schema=DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cl_paybacks
AS  
   PROCEDURE LOAD_CLEAN_PAYBACKS;
END pkg_etl_cl_paybacks;

--drop package pkg_etl_cl_paybacks;