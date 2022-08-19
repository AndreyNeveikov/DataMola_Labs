alter session set current_schema=SAL_CL;

CREATE OR REPLACE PACKAGE pkg_etl_sal_cl_transactions
AS  
   PROCEDURE LOAD_SAL_CL_TRANSACTIONS;
END pkg_etl_sal_cl_transactions;

alter session set current_schema=SAL_CL;
drop package pkg_etl_sal_cl_transactions;