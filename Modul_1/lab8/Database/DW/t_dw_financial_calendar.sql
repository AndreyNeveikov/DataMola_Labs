--alter session set current_schema=DW_DATA;
--drop table t_dw_financial_calendar;

alter session set current_schema=DW_DATA;
Create table t_dw_financial_calendar (
date_id                       DATE,
beg_of_cal_year               DATE         ,      
end_of_cal_year               DATE         ,    
day_name                      VARCHAR2(44) ,
day_number_in_week            VARCHAR2(1)  ,
day_number_in_month           VARCHAR2(2)  ,
day_number_in_year            VARCHAR2(3)  ,
calendar_week_number          VARCHAR2(1)  ,
week_ending_date              DATE         ,
calendar_month_number         VARCHAR2(2)  ,
days_in_cal_month             VARCHAR2(2)  ,
end_of_cal_month              DATE         ,
calendar_month_name           VARCHAR2(32) ,
beg_of_fst_quarter            DATE         ,
beg_of_snd_quarter            DATE         ,
beg_of_trd_quarter            DATE         ,
beg_of_fth_quarter            DATE         ,
calendar_quarter_number       VARCHAR2(1)  , 
calendar_year                 VARCHAR2(4)  ,  
days_in_cal_year              NUMBER       ,
constraint PK_T_DW_FINANCIAL_CALENDAR primary key (date_id)     
)
