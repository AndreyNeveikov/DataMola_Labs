alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.t_dw_transactions TO SAL_CL;

alter session set current_schema=SAL_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_sal_cl_transactions
AS  
  PROCEDURE LOAD_SAL_CL_TRANSACTIONS
   AS
     BEGIN
     MERGE INTO SAL_CL.sal_cl_transactions A
     USING ( SELECT order_id,
product_name,
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
 employee_id, 
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
region_id,
region_name,
country,
city,
use_language,
VAT_rate,
timezone,
-----------------------------------------------------------
currency_id,
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
             FROM DW_DATA.t_dw_transactions) B
             ON (a.order_id = b.order_id)
             WHEN MATCHED THEN 
                UPDATE SET a.client_id = b.client_id
             WHEN NOT MATCHED THEN 
                INSERT (
a.order_id,
a.product_name,
a.order_price,
a.order_status,
a.order_date,
a.receiving_date,
-----------------------------------------------------------
a.client_id,
a.client_name,
a.client_surname,
a.client_patronymic,
a.phone_number,
a.client_address,
a.payment_method,
-----------------------------------------------------------
 a.employee_id, 
 a.employee_name,
 a.employee_surname,
 a.employee_patronymic,
 a.position_now, 
 a.manager_id,  
 a.position_old,
 a.position_change_date,
 a.hiredate,
 a.salary,
 a.bonus,
 a.type_of_liability,
 a.vacation_days_number,
-----------------------------------------------------------
a.doer_id,
a.vehicle_registration_plate,
a.driving_category,
-----------------------------------------------------------
a.customer_payment,
a.product_costs,
a.fuel_costs,
a.vehicle_depreciation,
a.insurance_cost,
a.unexpected_expenses,
-----------------------------------------------------------
a.region_id,
a.region_name,
a.country,
a.city,
a.use_language,
a.VAT_rate,
a.timezone,
-----------------------------------------------------------
a.currency_id,
a.currency_code,
a.currency_name,
a.direct_exchange_rate,
a.reverse_exchange_rate,
-----------------------------------------------------------
a.date_id,
a.beg_of_fin_year,      
a.end_of_fin_year,    
a.day_name,
a.day_number_in_week,
a.day_number_in_month ,
a.day_number_in_year,
a.calendar_week_number,
a.week_ending_date,
a.calendar_month_number,
a.days_in_fin_month,
a.end_of_fin_month,
a.end_of_fin_quarter,
a.fin_quarter_number, 
a.fin_year, 
a.days_in_cal_year)
                VALUES (
b.order_id,
b.product_name,
b.order_price,
b.order_status,
b.order_date,
b.receiving_date,
-----------------------------------------------------------
b.client_id,
b.client_name,
b.client_surname,
b.client_patronymic,
b.phone_number,
b.client_address,
b.payment_method,
-----------------------------------------------------------
 b.employee_id, 
 b.employee_name,
 b.employee_surname,
 b.employee_patronymic,
 b.position_now, 
 b.manager_id,  
 b.position_old,
 b.position_change_date,
 b.hiredate,
 b.salary,
 b.bonus,
 b.type_of_liability,
 b.vacation_days_number,
-----------------------------------------------------------
b.doer_id,
b.vehicle_registration_plate,
b.driving_category,
-----------------------------------------------------------
b.customer_payment,
b.product_costs,
b.fuel_costs,
b.vehicle_depreciation,
b.insurance_cost,
b.unexpected_expenses,
-----------------------------------------------------------
b.region_id,
b.region_name,
b.country,
b.city,
b.use_language,
b.VAT_rate,
b.timezone,
-----------------------------------------------------------
b.currency_id,
b.currency_code,
b.currency_name,
b.direct_exchange_rate,
b.reverse_exchange_rate,
-----------------------------------------------------------
b.date_id,
b.beg_of_fin_year,      
b.end_of_fin_year,    
b.day_name,
b.day_number_in_week,
b.day_number_in_month ,
b.day_number_in_year,
b.calendar_week_number,
b.week_ending_date,
b.calendar_month_number,
b.days_in_fin_month,
b.end_of_fin_month,
b.end_of_fin_quarter,
b.fin_quarter_number, 
b.fin_year, 
b.days_in_cal_year);
     COMMIT;
   END LOAD_SAL_CL_TRANSACTIONS;
END pkg_etl_sal_cl_transactions;

alter session set current_schema=SAL_CL;
exec pkg_etl_sal_cl_transactions.LOAD_SAL_CL_TRANSACTIONS;
select * from sal_cl_transactions;

commit;