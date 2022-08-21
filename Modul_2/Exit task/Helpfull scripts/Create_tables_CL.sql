alter session set current_schema=DW_CL;
drop table t_cl_orders;
drop table t_cl_customers;
drop table t_cl_employees;
drop table t_cl_doers;
drop table t_cl_paybacks;
drop table t_cl_regions;
drop table t_cl_currencies;
drop table t_cl_financial_calendar;

alter session set current_schema=DW_CL;
Create table t_cl_orders (
region_id                     INT              not null,
employee_id                   INT              not null,
client_id                     INT              not null,
product_name                  VARCHAR2(15)     not null,
order_price                   FLOAT            not null,
order_status                  VARCHAR2(10)     not null,
order_date                    DATE             not null,
receiving_date                DATE             not null
);

alter session set current_schema=DW_CL;
Create table t_cl_customers (       
client_name                   VARCHAR2(15)     not null,
client_surname                VARCHAR2(15)     not null,
client_patronymic             VARCHAR2(15)     not null,
phone_number                  INT              not null,
client_address                VARCHAR2(25)     not null,
payment_method                VARCHAR2(6)      not null
);

Create table t_cl_employees (
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
 vacation_days_number          INT              not null
);

Create table t_cl_doers (
doer_id                       INT              not null,
vehicle_registration_plate    VARCHAR2(8)      not null,
driving_category              VARCHAR2(20)     not null
);

Create table t_cl_paybacks (
customer_payment              FLOAT            not null,
product_costs                 FLOAT            not null,
fuel_costs                    FLOAT            not null,
vehicle_depreciation          FLOAT            not null,
insurance_cost                FLOAT            not null,
unexpected_expenses           FLOAT            not null
);

Create table t_cl_regions (
region_id                     INT              not null,
region_name                   VARCHAR2(15)     not null,
country                       VARCHAR2(15)     not null,
city                          VARCHAR2(15)     not null,
use_language                  VARCHAR2(5)      not null,
VAT_rate                      FLOAT            not null,
timezone                      VARCHAR2(4)      not null
);

Create table t_cl_currencies ( 
currency_code                 INT              not null,
currency_name                 VARCHAR2(7)      not null,
direct_exchange_rate          FLOAT            not null,
reverse_exchange_rate         FLOAT            not null   
);

Create table t_cl_financial_calendar (
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
