--alter session set current_schema=DW_CL;
--drop table t_cl_employees;

alter session set current_schema=DW_CL;

Create table t_cl_employees (
 employee_id                   NUMBER(5)        not null, 
 employee_name                 VARCHAR2(15)     not null,
 employee_surname              VARCHAR2(15)     not null,
 employee_patronymic           VARCHAR2(15)     not null,
 position_now                  VARCHAR2(30)     not null, 
 manager_id                    NUMBER(4)        not null,  
 position_old                  VARCHAR2(30)     not null,
 position_change_date          DATE             not null,
 hiredate                      DATE             not null,
 salary                        FLOAT            not null,
 bonus                         FLOAT            not null,
 type_of_liability             VARCHAR2(15)     not null,
 vacation_days_number          INT              not null
);