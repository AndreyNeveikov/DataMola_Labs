alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_regions
AS  
   PROCEDURE LOAD_DW_REGIONS;
END pkg_etl_dw_regions;

alter session set current_schema=DW_DATA;
drop package pkg_etl_dw_regions;