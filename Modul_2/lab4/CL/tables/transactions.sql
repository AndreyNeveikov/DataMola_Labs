alter session set current_schema=DW_CL;
drop table t_cl_transactions;

SELECT order_date, Round(AVG(order_price), 1), SUM(order_price), MAX(receiving_date)
FROM DW_CL.t_cl_transactions
GROUP BY order_date;

commit;

SELECT *
FROM DW_CL.t_cl_transactions;



alter session set current_schema=DW_CL;
drop table t_cl_transactions;

alter session set current_schema=DW_CL;
create table t_cl_transactions(
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


alter session set current_schema=DW_CL;
INSERT INTO t_cl_transactions /*+ parallel(DW_CL.t_cl_transactions, 4)*/ 
(
 SELECT product_name,
order_price,
order_status,
order_date,
receiving_date,
-----------------------------------------------------------
client_id,
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
doer_id,
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
currency_code,
currency_name,
direct_exchange_rate,
reverse_exchange_rate,
-----------------------------------------------------------
date_id,
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
    t_cl_orders ord--1046
 CROSS JOIN (SELECT * FROM DW_CL.t_cl_customers 
    WHERE (phone_number IN(3463659, 3463659, 9231474, 2685576, 2635433))) --5    
 INNER JOIN DW_CL.t_cl_employees emp ON emp.employee_id = ord.employee_id--26    
 INNER JOIN DW_CL.t_cl_doers ON doer_id = emp.employee_id --2    
 INNER JOIN DW_CL.t_cl_paybacks ON customer_payment = order_price --250 
 INNER JOIN DW_CL.t_cl_regions reg ON reg.region_id = ord.region_id--11 
 INNER JOIN DW_CL.t_cl_currencies ON trunc(currency_code/100) = trunc(reg.region_id/100) --5 
 INNER JOIN DW_CL.t_cl_financial_calendar ON date_id = order_date --1000
WHERE order_date > TO_DATE( '01.01.20', 'MM/DD/YY' ) AND order_date < TO_DATE( '04.01.22', 'MM/DD/YY' )
); --1 035 320

SELECT *
FROM DW_CL.t_cl_transactions;
SELECT count(*)
FROM DW_CL.t_cl_transactions;

SELECT *
FROM DW_CL.t_cl_orders;
SELECT *--count(*)
FROM DW_CL.t_cl_employees;
SELECT count(*)
FROM DW_CL.t_cl_customers;
SELECT count(*)
FROM DW_CL.t_cl_doers;
SELECT count(*)
FROM DW_CL.t_cl_paybacks;
SELECT count(*)
FROM DW_CL.t_cl_financial_calendar;
commit;

