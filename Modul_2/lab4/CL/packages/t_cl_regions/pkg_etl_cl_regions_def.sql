alter session set current_schema=DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cl_regions
AS  
   PROCEDURE LOAD_CLEAN_REGIONS;
END pkg_etl_cl_regions;

--drop package pkg_etl_cl_regions;