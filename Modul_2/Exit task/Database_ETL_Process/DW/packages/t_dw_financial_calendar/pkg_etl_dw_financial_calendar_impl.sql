alter session set current_schema=DW_CL;
GRANT SELECT ON DW_CL.t_cl_financial_calendar TO DW_DATA;

alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_financial_calendar
AS  
  PROCEDURE LOAD_DW_FINANCIAL_CALENDAR
   AS
     BEGIN
     MERGE INTO DW_DATA.t_dw_financial_calendar A
     USING ( SELECT date_id, beg_of_fin_year, end_of_fin_year, day_name, day_number_in_week,
                    day_number_in_month, day_number_in_year, calendar_week_number, week_ending_date,
                    calendar_month_number, days_in_fin_month, end_of_fin_month, end_of_fin_quarter, 
                    fin_quarter_number, fin_year, days_in_cal_year
             FROM DW_CL.t_cl_financial_calendar) B
             ON (a.date_id = b.date_id) 
             WHEN MATCHED THEN 
                UPDATE SET a.beg_of_fin_year = b.beg_of_fin_year
             WHEN NOT MATCHED THEN 
                INSERT (a.date_id, a.beg_of_fin_year, a.end_of_fin_year, a.day_name, a.day_number_in_week,
                    a.day_number_in_month, a.day_number_in_year, a.calendar_week_number, a.week_ending_date,
                    a.calendar_month_number, a.days_in_fin_month, a.end_of_fin_month, a.end_of_fin_quarter, 
                    a.fin_quarter_number, a.fin_year, a.days_in_cal_year)
                VALUES (b.date_id, b.beg_of_fin_year, b.end_of_fin_year, b.day_name, b.day_number_in_week,
                    b.day_number_in_month, b.day_number_in_year, b.calendar_week_number, b.week_ending_date,
                    b.calendar_month_number, b.days_in_fin_month, b.end_of_fin_month, b.end_of_fin_quarter, 
                    b.fin_quarter_number, b.fin_year, b.days_in_cal_year);
     COMMIT;
   END LOAD_DW_FINANCIAL_CALENDAR;
END pkg_etl_dw_financial_calendar;

alter session set current_schema=DW_DATA;
exec pkg_etl_dw_financial_calendar.LOAD_DW_FINANCIAL_CALENDAR;
select * from t_dw_financial_calendar;

commit;