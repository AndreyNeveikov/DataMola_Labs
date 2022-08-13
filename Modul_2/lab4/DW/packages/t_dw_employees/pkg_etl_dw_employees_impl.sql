alter session set current_schema=DW_CL;
GRANT SELECT ON DW_CL.t_cl_employees TO DW_DATA;

alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_employees
AS  
  PROCEDURE LOAD_DW_EMPLOYEES
   AS
     BEGIN
     MERGE INTO DW_DATA.t_dw_employees A
     USING ( SELECT employee_id, employee_name, employee_surname, employee_patronymic, position_now, 
                    manager_id, position_old, position_change_date, hiredate, salary, bonus,
                    type_of_liability, vacation_days_number
             FROM DW_CL.t_cl_employees) B
             ON (a.employee_id = b.employee_id)
             WHEN MATCHED THEN 
                UPDATE SET a.salary = b.salary
             WHEN NOT MATCHED THEN 
                INSERT (a.employee_id, a.employee_name, a.employee_surname, a.employee_patronymic, a.position_now, 
                    a.manager_id, a.position_old, a.position_change_date, a.hiredate, a.salary, a.bonus,
                    a.type_of_liability, a.vacation_days_number)
                VALUES (b.employee_id, b.employee_name, b.employee_surname, b.employee_patronymic, b.position_now, 
                    b.manager_id, b.position_old, b.position_change_date, b.hiredate, b.salary, b.bonus,
                    b.type_of_liability, b.vacation_days_number);
     COMMIT;
   END LOAD_DW_EMPLOYEES;
END pkg_etl_dw_employees;

alter session set current_schema=DW_DATA;
exec pkg_etl_dw_employees.LOAD_DW_EMPLOYEES;
select * from t_dw_employees;

commit;