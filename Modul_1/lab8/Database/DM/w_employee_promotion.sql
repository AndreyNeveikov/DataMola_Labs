grant SELECT on DW_DATA.t_dw_employees to DM_ORDERS;

create or replace view DM_ORDERS.w_employee_promotion as
SELECT /*+ PARALLEL(4) */     
    employee_name                 ,
    employee_surname              ,
    employee_patronymic           ,
    position_now                  ,
    position_old                  ,
    position_change_date          ,
    salary                        ,
    bonus                         ,
    work_length                   
    FROM DW_DATA.t_dw_employees;

--select * from DM_ORDERS.w_employee_promotion;