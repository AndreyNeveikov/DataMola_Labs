alter session set current_schema=SA_CURRENCIES;
GRANT SELECT ON SA_CURRENCIES.t_sa_financial_calendar TO DW_CL; 

alter session set current_schema=DW_CL;
CREATE OR REPLACE PACKAGE body pkg_etl_cl_financial_calendar
AS  
  PROCEDURE LOAD_CLEAN_FINANCIAL_CALENDAR
   AS   
      CURSOR curs_cl_financial_calendar
      IS
         SELECT DISTINCT  date_id
                        , beg_of_fin_year
                        , end_of_fin_year
                        , day_name 
                        , day_number_in_week
                        , day_number_in_month
                        , day_number_in_year 
                        , calendar_week_number 
                        , week_ending_date 
                        , calendar_month_number
                        , days_in_fin_month 
                        , end_of_fin_month
                        , end_of_fin_quarter
                        , fin_quarter_number
                        , fin_year
                        , days_in_cal_year      
           FROM SA_CURRENCIES.t_sa_financial_calendar
           WHERE beg_of_fin_year IS NOT NULL 
           AND end_of_fin_year IS NOT NULL
           AND day_name IS NOT NULL
           AND day_number_in_week IS NOT NULL
           AND day_number_in_month IS NOT NULL
           AND day_number_in_year IS NOT NULL
           AND calendar_week_number IS NOT NULL
           AND week_ending_date IS NOT NULL
           AND calendar_month_number IS NOT NULL
           AND days_in_fin_month IS NOT NULL
           AND end_of_fin_month IS NOT NULL
           AND end_of_fin_quarter IS NOT NULL
           AND fin_quarter_number IS NOT NULL
           AND fin_year IS NOT NULL 
           AND days_in_cal_year IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.t_cl_financial_calendar';
      FOR i IN curs_cl_financial_calendar LOOP
         INSERT INTO DW_CL.t_cl_financial_calendar( 
                         date_id
                        , beg_of_fin_year
                        , end_of_fin_year
                        , day_name 
                        , day_number_in_week
                        , day_number_in_month
                        , day_number_in_year 
                        , calendar_week_number 
                        , week_ending_date 
                        , calendar_month_number
                        , days_in_fin_month 
                        , end_of_fin_month
                        , end_of_fin_quarter
                        , fin_quarter_number
                        , fin_year
                        , days_in_cal_year)
              VALUES ( i.date_id
                    , i.beg_of_fin_year
                    , i.end_of_fin_year
                    , i.day_name 
                    , i.day_number_in_week
                    , i.day_number_in_month
                    , i.day_number_in_year 
                    , i.calendar_week_number 
                    , i.week_ending_date 
                    , i.calendar_month_number
                    , i.days_in_fin_month 
                    , i.end_of_fin_month
                    , i.end_of_fin_quarter
                    , i.fin_quarter_number
                    , i.fin_year
                    , i.days_in_cal_year);

         EXIT WHEN curs_cl_financial_calendar%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_FINANCIAL_CALENDAR;
END pkg_etl_cl_financial_calendar;


alter session set current_schema=DW_CL;
exec pkg_etl_cl_financial_calendar.LOAD_CLEAN_FINANCIAL_CALENDAR;
select * from t_cl_financial_calendar;

commit;

