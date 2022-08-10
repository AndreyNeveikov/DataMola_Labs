alter session set current_schema=SA_CUSTOMERS;
drop table t_sa_employees;

alter session set current_schema=SA_CUSTOMERS;
create table t_sa_employees
(
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

--------------------------------------------------------------------------------

alter session set current_schema=SA_CUSTOMERS;
INSERT INTO t_sa_employees
    WITH create_employee_name AS (
        SELECT
            1      AS id
          , 'Andrew'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2      AS id
          , 'Joe'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3      AS id
          , 'Mark'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4      AS id
          , 'Linda'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5      AS id
          , 'Jake'  AS a
        FROM
            dual
    ), create_employee_surname AS (
        SELECT
            1         AS id
          , 'Neveykov'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'Trump'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 'Miligun'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4         AS id
          , 'Martines'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5         AS id
          , 'Daniels'  AS a
        FROM
            dual
    ), create_employee_patronymic AS (
        SELECT
            1         AS id
          , 'Sergeevich'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'Andreevich'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 'Petrovich'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4         AS id
          , 'Vladimirovich'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5         AS id
          , 'Victorovna'  AS a
        FROM
            dual
    ), create_employee_position AS (
        SELECT
            1         AS id
          , 'Security guard'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'Analyst'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 'Driver'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4         AS id
          , 'Salesman'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5         AS id
          , 'Lawyer'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6         AS id
          , 'Financier'  AS a
        FROM
            dual
    ), create_employee AS (
        SELECT
            a.*
          , trunc(dbms_random.value(1, 5))                  AS id_employee_name
          , trunc(dbms_random.value(1, 5))                  AS id_employee_surname
          , trunc(dbms_random.value(1, 5))                  AS id_employee_patronymic
          , trunc(dbms_random.value(1, 6))                  AS id_employee_position_now
          , trunc(dbms_random.value(1, 6))                  AS id_employee_position_old
          
          , to_date(TRUNC(DBMS_RANDOM.value(
                to_char(to_date('01-01-2020','dd-mm-yyyy'),'J'),
                    to_char(to_date('01-01-2022','dd-mm-yyyy'),'J'))),'J') hiredate
             
          , 60000                                           AS salary_base
          , trunc(dbms_random.value(150, 1250) + 60000)     AS bonus_base
          , trunc(dbms_random.value(15, 25))                AS vacation_days_number
        FROM
            (
                SELECT
                    ROWNUM rn
                FROM
                    dual
                CONNECT BY
                    level <= 150
            ) a
    )
    SELECT
        rn emp_id
      , e_name.a
      , e_surname.a
      , e_patronymic.a
      , ( CASE
      WHEN rn = 1 THEN 'Director'
      WHEN rn > 1 AND rn < 8 THEN concat('Head of ', e_position_now.a)
      WHEN rn > 7 AND rn < 26 THEN concat('Senior ', e_position_now.a)
      WHEN rn > 25 THEN e_position_now.a
        END ) position_now
      , ( CASE
      WHEN rn = 1 THEN 0
      WHEN rn > 1 AND rn < 8 THEN 1
      WHEN rn > 7 AND rn < 26 THEN trunc(dbms_random.value(2, 8))
      WHEN rn > 25 THEN trunc(dbms_random.value(8, 26))
        END ) chif_id
      , e_position_old.a
      , to_date(TRUNC(DBMS_RANDOM.value(
                to_char(hiredate,'J'),
                    to_char(to_date('01-01-2022','dd-mm-yyyy'),'J'))),'J') position_change_date
      , hiredate hiredate
      , trunc(salary_base / rn, 2) 
      , trunc(bonus_base / rn, 2)
      , ( CASE
      WHEN rn < 26 THEN 'FULL'
      WHEN rn > 25 THEN 'PARTIAL'
        END ) responsibility
      , vacation_days_number
    FROM
        create_employee  cr_employee
        LEFT OUTER JOIN create_employee_name              e_name              ON cr_employee.id_employee_name = e_name.id
        LEFT OUTER JOIN create_employee_surname           e_surname           ON cr_employee.id_employee_surname = e_surname.id
        LEFT OUTER JOIN create_employee_patronymic        e_patronymic        ON cr_employee.id_employee_patronymic = e_patronymic.id
        LEFT OUTER JOIN create_employee_position          e_position_now      ON cr_employee.id_employee_position_now = e_position_now.id
        LEFT OUTER JOIN create_employee_position          e_position_old      ON cr_employee.id_employee_position_old = e_position_old.id;
--

alter session set current_schema=SA_CUSTOMERS;
select * from t_sa_employees;
commit;

--------------------------------------------------------------------------------

alter session set current_schema=SA_CUSTOMERS;
select 
    *
from
    t_sa_employees
CONNECT BY PRIOR 
    employee_id = manager_id
START WITH 
    manager_id = 0; 
--------------------------------------------------------------------------------

commit;