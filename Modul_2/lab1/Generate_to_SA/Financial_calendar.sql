alter session set current_schema=SA_CURRENCIES;
--drop table t_sa_financial_calendar;
select 
    * 
from
    t_sa_financial_calendar;
    
commit;

alter session set current_schema=SA_CURRENCIES;
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
days_in_cal_month             VARCHAR2(2)  ,
end_of_cal_month              DATE         ,
calendar_month_name           VARCHAR2(32) ,
calendar_quarter_number       VARCHAR2(1)  , 
calendar_year                 VARCHAR2(4)  ,  
days_in_cal_year              NUMBER            
);


INSERT INTO t_sa_financial_calendar ( 
        date_id                   ,
        beg_of_fin_year           ,      
        end_of_fin_year           ,    
        day_name                  ,
        day_number_in_week        ,
        day_number_in_month       ,
        day_number_in_year        ,
        calendar_week_number      ,
        week_ending_date          ,
        calendar_month_number     ,
        days_in_cal_month         ,
        end_of_cal_month          ,
        calendar_month_name       ,
        calendar_quarter_number   , 
        calendar_year             ,  
        days_in_cal_year                     
)
SELECT 
  TRUNC( sd + rn ) time_id,                 
  TRUNC( sd ) beg_of_fin_year,           
  TO_CHAR( sd + 364 ) end_of_fin_year,          
  TO_CHAR( sd + rn, 'fmDay' ) day_name,                
  TO_CHAR( sd + rn, 'D' ) day_number_in_week,                  
  TO_CHAR( sd + rn, 'DD' ) day_number_in_month,              
  TO_CHAR( sd + rn, 'DDD' ) day_number_in_year,                   
  TO_CHAR( sd + rn, 'W' ) calendar_week_number,                    
  ( CASE
      WHEN TO_CHAR( sd + rn, 'D' ) IN ( 1, 2, 3, 4, 5, 6 ) THEN
        NEXT_DAY( sd + rn, 'Воскресенье' )
      ELSE
        ( sd + rn )
    END ) week_ending_date,                   
  TO_CHAR( sd + rn, 'MM' ) calendar_month_number,                    
  TO_CHAR( LAST_DAY( sd + rn ), 'DD' ) days_in_cal_month,                    
  LAST_DAY( sd + rn ) end_of_cal_month,                   
  ( CASE
      WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
        TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
        TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
        TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
        TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
    END ) end_of_cal_quarter,                   
  TO_CHAR( sd + rn, 'Q' ) calendar_quarter_number,                   
  TO_CHAR( sd + rn, 'YYYY' ) calendar_year,                    
  ( TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
    - TRUNC( sd + rn, 'YEAR' ) ) days_in_cal_year                    
FROM
  ( 
    SELECT 
      TO_DATE( '03/01/2002', 'MM/DD/YYYY' ) sd,
      rownum rn
    FROM dual
      CONNECT BY level <= 30000
  );
