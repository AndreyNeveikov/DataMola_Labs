alter session set current_schema=SAL_CL;

CREATE OR REPLACE PACKAGE pkg_sal_cl_employees
AS  
   PROCEDURE LOAD_SAL_CL_EMPLOYEES;
END pkg_sal_cl_employees;

alter session set current_schema=SAL_CL;
drop package pkg_sal_cl_employees;