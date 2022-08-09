--alter session set current_schema=SA_CURRENCIES;
--drop table t_sa_currencies;

alter session set current_schema=SA_CURRENCIES;

Create table t_sa_currencies ( 
currenci_id                   INT              not null,
currenci_name                 VARCHAR2(25)     not null,
direct_exchange_rate          FLOAT            not null,
reverse_exchange_rate         FLOAT            not null  
);

Create table t_sa_accountings (
taxes                         DATE         ,      
mandatory_payments            DATE         ,    
depreciation_rate             VARCHAR2(44) ,
investments_for_development   VARCHAR2(1)  ,
payment_to_owner              VARCHAR2(2)  ,
circulating_capital           VARCHAR2(3)  ,
free_cash                     VARCHAR2(1)  
);

Create table t_sa_financial_calendar (
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