--alter session set current_schema=SA_CUSTOMERS;
--drop table t_sa_employees;

alter session set current_schema=SA_CUSTOMERS;

Create table t_sa_employees (
employee_name                 VARCHAR2(15)     not null,
employee_surname              VARCHAR2(15)     not null,
employee_patronymic           VARCHAR2(15)     not null,
subdivision                   VARCHAR2(25)     not null,
position_now                  VARCHAR2(30)     not null,
position_old                  VARCHAR2(30)     not null,
position_change_date          DATE             not null,
salary                        FLOAT            not null,
bonus                         FLOAT            not null,
work_length                   INT              not null,
type_of_liability             VARCHAR2(15)     not null,
vacation_days_number          INT              not null
);