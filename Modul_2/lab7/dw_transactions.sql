alter session set current_schema=DW_DATA;
drop table t_dw_transactions;


commit;

SELECT *
FROM DW_DATA.t_dw_transactions;



alter session set current_schema=DW_DATA;
drop table t_dw_transactions;

alter session set current_schema=DW_DATA;
create table t_dw_transactions(
order_id                      INT              not null,
product_name                  VARCHAR2(15)     not null,
order_price                   FLOAT            not null,
order_status                  VARCHAR2(10)     not null,
order_date                    DATE             not null,
receiving_date                DATE             not null,
-----------------------------------------------------------
client_id                     INT              not null,
client_name                   VARCHAR2(15)     not null,
client_surname                VARCHAR2(15)     not null,
client_patronymic             VARCHAR2(15)     not null,
phone_number                  INT              not null,
client_address                VARCHAR2(25)     not null,
payment_method                VARCHAR2(6)      not null,
-----------------------------------------------------------
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
-----------------------------------------------------------
doer_id                       INT              not null,
vehicle_registration_plate    VARCHAR2(8)      not null,
driving_category              VARCHAR2(20)     not null,
-----------------------------------------------------------
customer_payment              FLOAT            not null,
product_costs                 FLOAT            not null,
fuel_costs                    FLOAT            not null,
vehicle_depreciation          FLOAT            not null,
insurance_cost                FLOAT            not null,
unexpected_expenses           FLOAT            not null,
-----------------------------------------------------------
region_id                     INT              not null,
region_name                   VARCHAR2(15)     not null,
country                       VARCHAR2(15)     not null,
city                          VARCHAR2(15)     not null,
use_language                  VARCHAR2(5)      not null,
VAT_rate                      FLOAT            not null,
timezone                      VARCHAR2(4)      not null,
-----------------------------------------------------------
currency_id                   INT              not null,
currency_code                 INT              not null,
currency_name                 VARCHAR2(7)      not null,
direct_exchange_rate          FLOAT            not null,
reverse_exchange_rate         FLOAT            not null,
-----------------------------------------------------------
date_id                       DATE,
beg_of_fin_year               DATE         ,      
end_of_fin_year               DATE         ,    
day_name                      VARCHAR2(44) ,
day_number_in_week            VARCHAR2(1)  ,
day_number_in_month           VARCHAR2(2)  ,
day_number_in_year            VARCHAR2(3)  ,
calendar_week_number          VARCHAR2(1)  ,
week_ending_date              DATE         ,
calendar_month_number         VARCHAR2(2)  ,
days_in_fin_month             VARCHAR2(2)  ,
end_of_fin_month              DATE         ,
end_of_fin_quarter            VARCHAR2(32) ,
fin_quarter_number            VARCHAR2(1)  , 
fin_year                      VARCHAR2(4)  ,  
days_in_cal_year              NUMBER
);


alter session set current_schema=DW_DATA;
INSERT INTO t_dw_transactions /*+ parallel(DW_CL.t_cl_transactions, 4)*/ 
(
 SELECT ord.order_id,
product_name,
order_price,
order_status,
order_date,
receiving_date,
-----------------------------------------------------------
cust.client_id,
client_name,
client_surname,
client_patronymic,
phone_number,
client_address,
payment_method,
-----------------------------------------------------------
 emp.employee_id, 
 employee_name,
 employee_surname,
 employee_patronymic,
 position_now, 
 manager_id,  
 position_old,
 position_change_date,
 hiredate,
 salary,
 bonus,
 type_of_liability,
 vacation_days_number,
-----------------------------------------------------------
doer.doer_id,
vehicle_registration_plate,
driving_category,
-----------------------------------------------------------
customer_payment,
product_costs,
fuel_costs,
vehicle_depreciation,
insurance_cost,
unexpected_expenses,
-----------------------------------------------------------
reg.region_id,
region_name,
country,
city,
use_language,
VAT_rate,
timezone,
-----------------------------------------------------------
cur.currency_id,
currency_code,
currency_name,
direct_exchange_rate,
reverse_exchange_rate,
-----------------------------------------------------------
fin_c.date_id,
beg_of_fin_year,      
end_of_fin_year,    
day_name,
day_number_in_week,
day_number_in_month ,
day_number_in_year,
calendar_week_number,
week_ending_date,
calendar_month_number,
days_in_fin_month,
end_of_fin_month,
end_of_fin_quarter,
fin_quarter_number, 
fin_year, 
days_in_cal_year
 FROM
    DW_DATA.t_dw_fct_orders ord--1046
 INNER JOIN DW_DATA.t_dw_customers cust ON cust.client_id = ord.client_id    
 INNER JOIN DW_DATA.t_dw_employees emp ON emp.employee_id = ord.employee_id   
 INNER JOIN DW_DATA.t_dw_doers doer ON doer.doer_id = ord.employee_id  
 INNER JOIN DW_DATA.t_dw_paybacks payb ON payb.order_id = ord.order_id  
 INNER JOIN DW_DATA.t_dw_regions reg ON reg.region_id = ord.region_id 
 INNER JOIN DW_DATA.t_dw_currencies cur ON cur.currency_id = ord.currency_id 
 INNER JOIN DW_DATA.t_dw_financial_calendar fin_c ON fin_c.date_id = ord.date_id
); 

SELECT *
FROM DW_DATA.t_dw_transactions;
SELECT count(*)
FROM DW_DATA.t_dw_transactions;

SELECT *
FROM DW_DATA.t_dw_fct_orders;
SELECT *--count(*)
FROM DW_DATA.t_dw_employees;
SELECT count(*)
FROM DW_DATA.t_dw_customers;
SELECT count(*)
FROM DW_DATA.t_dw_doers;
SELECT count(*)
FROM DW_DATA.t_dw_paybacks;
SELECT count(*)
FROM DW_DATA.t_dw_financial_calendar;
commit;

