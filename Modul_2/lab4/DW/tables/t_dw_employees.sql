alter session set current_schema=DW_DATA;
drop table t_dw_employees;

alter session set current_schema=DW_DATA;

Create table t_dw_employees (
 employee_id                   NUMBER(5)        not null, 
 employee_name                 VARCHAR2(10)     not null,
 employee_surname              VARCHAR2(10)     not null,
 employee_patronymic           VARCHAR2(15)     not null,
 position_now                  VARCHAR2(25)     not null, 
 manager_id                    NUMBER(2)        not null,  
 position_old                  VARCHAR2(25)     not null,
 position_change_date          DATE             not null,
 hiredate                      DATE             not null,
 salary                        FLOAT            not null,
 bonus                         FLOAT            not null,
 type_of_liability             VARCHAR2(10)     not null,
 vacation_days_number          INT              not null,
constraint PK_T_DW_EMPLOYEES primary key (employee_id)
)