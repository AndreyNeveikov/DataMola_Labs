alter session set current_schema=SAL_CL;

CREATE OR REPLACE PACKAGE pkg_etl_sal_fct_orders
AS  
   PROCEDURE LOAD_SAL_FCT_ORDERS;
END pkg_etl_sal_fct_orders;

alter session set current_schema=SAL_CL;
drop package pkg_etl_sal_fct_orders;