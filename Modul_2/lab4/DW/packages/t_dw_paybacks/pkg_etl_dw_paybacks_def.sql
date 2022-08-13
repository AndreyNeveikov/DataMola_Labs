alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_paybacks
AS  
   PROCEDURE LOAD_DW_PAYBACKS;
END pkg_etl_dw_paybacks;

alter session set current_schema=DW_DATA;
drop package pkg_etl_dw_paybacks;