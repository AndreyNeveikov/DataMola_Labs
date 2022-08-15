-- Example
with tmp_table
as 
(
select t.*, 1 countt
from
DW_CL.t_cl_financial_calendar t
WHERE date_id >= TO_DATE( '01.03.20', 'MM/DD/YY' ) AND date_id  < TO_DATE( '01.10.20', 'MM/DD/YY' )
)

SELECT date_id, day_name, day_number_in_week

FROM 
tmp_table
model-- return updated rows

partition by (day_name)
dimension by (date_id)
measures(day_number_in_week)
rules automatic order(
            day_number_in_week[null] = count(day_number_in_week)[any]
                    );
                    
                    
--------------------------------------------------------------------------------
/*Task_2*/
with tmp_table
as 
(
select t.product_name, t.order_date, t.order_price, emp.employee_id, 1 countt
from
DW_CL.t_cl_orders t
INNER JOIN DW_CL.t_cl_employees emp ON emp.employee_id = t.employee_id
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

