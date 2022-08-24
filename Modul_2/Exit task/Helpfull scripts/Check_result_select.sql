alter session set current_schema=DW_DATA;

SELECT count(*) t_dw_regions
FROM t_dw_regions;

SELECT count(*) t_dw_paybacks
FROM t_dw_paybacks;

SELECT count(*) t_dw_financial_calendar
from t_dw_financial_calendar;

SELECT count(*) t_dw_doers 
from t_dw_doers;

SELECT count(*) t_dw_customers
from t_dw_customers;

SELECT count(*) t_dw_employees
from t_dw_employees;

SELECT count(*) t_dw_currencies
from t_dw_currencies;

SELECT count(*) t_dw_fct_orders
from t_dw_fct_orders;

--------------------------------------------------------------------------------
SELECT *
from t_dw_fct_orders;

SELECT *
from t_dw_employees;

SELECT * 
from t_dw_employees;