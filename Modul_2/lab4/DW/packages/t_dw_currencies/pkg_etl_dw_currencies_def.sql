alter session set current_schema=DW_DATA;
CREATE OR REPLACE PACKAGE pkg_etl_dw_currencies
AS  
   PROCEDURE LOAD_DW_CURRENCY;
END pkg_etl_dw_currencies;
