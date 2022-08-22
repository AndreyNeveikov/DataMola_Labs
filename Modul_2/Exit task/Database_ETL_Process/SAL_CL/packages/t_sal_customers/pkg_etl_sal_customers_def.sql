alter session set current_schema=SAL_CL;

CREATE OR REPLACE PACKAGE pkg_etl_sal_customers
AS  
   PROCEDURE LOAD_SAL_CUSTOMERS;
END pkg_etl_sal_customers;

alter session set current_schema=SAL_CL;
drop package pkg_etl_sal_customers;