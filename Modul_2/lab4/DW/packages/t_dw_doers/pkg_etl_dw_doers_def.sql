alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_doers
AS  
   PROCEDURE LOAD_DW_DOERS;
END pkg_etl_dw_doers;

alter session set current_schema=DW_DATA;
drop package pkg_etl_dw_doers;