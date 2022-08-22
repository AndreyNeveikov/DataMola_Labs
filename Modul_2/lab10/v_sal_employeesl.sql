alter session set current_schema=SAL_CL;
drop view dim_sal_employees_costs;

alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.t_dw_employees TO DW_DATA;

alter session set current_schema=SAL_CL;

CREATE OR REPLACE VIEW dim_sal_employees_costs
AS SELECT  
 employee_name,
 employee_surname,
 employee_patronymic,
 position_now,   
 position_old,
 position_change_date,
 hiredate,
 salary + bonus AS payments
FROM DW_DATA.t_dw_employees;

alter session set current_schema=SAL_CL;
SELECT count(*) FROM dim_sal_employees_costs;