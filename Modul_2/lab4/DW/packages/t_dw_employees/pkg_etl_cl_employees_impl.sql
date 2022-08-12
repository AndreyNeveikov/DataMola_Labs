alter session set current_schema=SA_CUSTOMERS;
GRANT SELECT ON SA_CUSTOMERS.t_sa_employees TO DW_CL; 

alter session set current_schema=DW_CL;
CREATE OR REPLACE PACKAGE body pkg_etl_cl_employees 
AS  
  PROCEDURE LOAD_CLEAN_EMPLOYEES
   AS   
      CURSOR curs_cl_employees
      IS
         SELECT DISTINCT 
                    employee_id
                  , employee_name
                  , employee_surname
                  , employee_patronymic
                  , position_now
                  , manager_id 
                  , position_old
                  , position_change_date
                  , hiredate 
                  , salary  
                  , bonus  
                  , type_of_liability
                  , vacation_days_number
           FROM SA_CUSTOMERS.t_sa_employees
           WHERE employee_id IS NOT NULL 
           AND employee_name IS NOT NULL
           AND employee_surname IS NOT NULL
           AND employee_patronymic IS NOT NULL
           AND position_now IS NOT NULL
           AND manager_id IS NOT NULL
           AND position_old IS NOT NULL
           AND position_change_date IS NOT NULL
           AND hiredate IS NOT NULL
           AND salary IS NOT NULL
           AND bonus IS NOT NULL
           AND type_of_liability IS NOT NULL
           AND vacation_days_number IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.t_cl_employees';
      FOR i IN curs_cl_employees LOOP
         INSERT INTO DW_CL.t_cl_employees( 
                    employee_id
                  , employee_name
                  , employee_surname
                  , employee_patronymic
                  , position_now
                  , manager_id 
                  , position_old
                  , position_change_date
                  , hiredate 
                  , salary  
                  , bonus  
                  , type_of_liability
                  , vacation_days_number)
              VALUES ( i.employee_id
                  , i.employee_name
                  , i.employee_surname
                  , i.employee_patronymic
                  , i.position_now
                  , i.manager_id 
                  , i.position_old
                  , i.position_change_date
                  , i.hiredate 
                  , i.salary  
                  , i.bonus  
                  , i.type_of_liability
                  , i.vacation_days_number);

         EXIT WHEN curs_cl_employees%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_EMPLOYEES;
END pkg_etl_cl_employees;


alter session set current_schema=DW_CL;
exec pkg_etl_cl_employees.LOAD_CLEAN_EMPLOYEES;
select * from t_cl_employees;

commit;

