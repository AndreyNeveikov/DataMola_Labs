/*Task_1*/
--------------------------------------------------------------------------------
alter session set current_schema=DW_DATA;
drop MATERIALIZED VIEW mv_daily_profit;

alter session set current_schema=DW_DATA;
CREATE MATERIALIZED VIEW mv_daily_profit
BUILD DEFERRED
REFRESH COMPLETE ON DEMAND
AS SELECT product_name, client_address, order_date,  sum(order_price) profit,

   GROUPING(product_name) name_,
   GROUPING(client_address) address,
   GROUPING(order_date) date_,
   
   GROUPING_ID(product_name, client_address) name_address,
   GROUPING_ID(client_address, product_name) address_name,
   GROUPING_ID(product_name, order_date) name_date,
   GROUPING_ID(client_address, order_date) address_date,
   
   GROUPING_ID(client_address, product_name, order_date) address_name_date,
   GROUPING_ID(client_address, order_date, product_name) address_date_name,
   GROUPING_ID(order_date, product_name, client_address) date_name_address
   
   FROM DW_DATA.t_dw_fct_orders fct_ord
   LEFT JOIN t_dw_customers  cust ON cust.client_id = fct_ord.client_id
   WHERE date_id  >= TO_DATE( '03.01.20', 'MM/DD/YY' ) AND date_id  < TO_DATE( '04.01.20', 'MM/DD/YY' )
   GROUP BY CUBE(product_name, client_address, order_date);


EXECUTE DBMS_MVIEW.REFRESH('mv_daily_profit');

SELECT * FROM  mv_daily_profit;

commit;

/*Task_2*/
--------------------------------------------------------------------------------
alter session set current_schema=DW_DATA;
CREATE MATERIALIZED VIEW LOG ON DW_DATA.t_dw_transactions
WITH rowid, SEQUENCE(
order_id,
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
)
INCLUDING NEW VALUES;

DROP MATERIALIZED VIEW DW_DATA.mv_profit_daily;

CREATE MATERIALIZED VIEW DW_DATA.mv_profit_daily
PARALLEL
BUILD IMMEDIATE
REFRESH COMPLETE ON COMMIT
ENABLE QUERY REWRITE
AS
SELECT product_name, client_address, order_date,  sum(order_price) profit
   FROM DW_DATA.t_dw_fct_orders ord--1046
   INNER JOIN DW_DATA.t_dw_customers cust ON cust.client_id = ord.client_id  
   GROUP BY product_name, client_address, order_date;

SELECT * FROM mv_profit_daily
ORDER BY 3,1;

UPDATE DW_DATA.t_dw_fct_orders
SET order_price = order_price*2
WHERE PRODUCT_NAME = 'Computer';

commit;


/*Task_3*/
--------------------------------------------------------------------------------
alter session set current_schema=DW_DATA;
drop MATERIALIZED VIEW mv_orders_daily;

alter session set current_schema=DW_DATA;

CREATE MATERIALIZED VIEW DW_DATA.mv_orders_daily
BUILD IMMEDIATE
REFRESH COMPLETE START WITH (sysdate) NEXT  (sysdate+1/1440)
AS
with tmp_table
as 
(
select t.product_name, t.order_date, t.order_price, emp.employee_id, 1 countt
from
DW_DATA.t_dw_fct_orders t
INNER JOIN DW_DATA.t_dw_employees emp ON emp.employee_id = t.employee_id
WHERE order_date >= TO_DATE( '01.03.20', 'MM/DD/YY' ) AND order_date  < TO_DATE( '03.10.20', 'MM/DD/YY' )
)

SELECT DISTINCT product_name, order_date, extract(month FROM order_date) AS Month, order_price, employee_id

FROM 
tmp_table
model-- return updated rows

partition by (product_name)
dimension by (employee_id, order_date)
measures(order_price)
rules automatic order(
            order_price[null, for order_date in (select distinct order_date from tmp_table)] = count(order_price)[any, CV(order_date)] -1
                    )
ORDER BY product_name, order_date;

SELECT * FROM DW_DATA.mv_orders_daily;

UPDATE DW_DATA.t_dw_fct_orders
SET order_price = order_price/10
WHERE PRODUCT_NAME = 'Air-conditioner';
