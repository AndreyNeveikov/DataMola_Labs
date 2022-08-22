alter session set current_schema=DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cl_financial_calendar
AS  
   PROCEDURE LOAD_CLEAN_FINANCIAL_CALENDAR;
END pkg_etl_cl_financial_calendar;

--drop package pkg_etl_cl_financial_calendar;