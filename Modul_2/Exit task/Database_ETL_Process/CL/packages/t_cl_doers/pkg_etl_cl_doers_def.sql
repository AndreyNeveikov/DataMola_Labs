alter session set current_schema=DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cl_doers
AS  
   PROCEDURE LOAD_CLEAN_DOERS;
END pkg_etl_cl_doers;

--drop package pkg_etl_cl_doers;