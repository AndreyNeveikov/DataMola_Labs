/* Task_1 */

alter session set current_schema=DW_DATA;

-- hiest bonus payments to position of senior employees
SELECT DISTINCT position_now, FIRST_VALUE(bonus) 
        OVER (PARTITION BY position_now ORDER BY bonus DESC
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
        AS hiest_bonus_payment
FROM t_dw_employees
WHERE position_now LIKE 'Senior%'
ORDER BY position_now;

-- lowest vat rate in European Union and C.I.S.
SELECT DISTINCT region_name, LAST_VALUE(vat_rate) 
        OVER (PARTITION BY region_name ORDER BY vat_rate ASC
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
        AS country_with_the_lowes_vat_rate
FROM t_dw_regions
WHERE region_name IN('European Union', 'C.I.S.')
ORDER BY region_name;

/* Task_2 */

alter session set current_schema=DW_DATA;

SELECT order_id, product_name, order_price, rank() OVER(ORDER BY order_price ASC) AS ord_price_rank
FROM t_dw_fct_orders;

SELECT order_id, product_name, order_price, DENSE_RANK() OVER(ORDER BY order_price ASC) AS ord_price_rank
FROM t_dw_fct_orders;

SELECT order_id, product_name, order_price, 
    ROW_NUMBER() OVER(ORDER BY order_price ASC) AS ord_price_num
FROM t_dw_fct_orders;

/* Task_3 */

SELECT SUM(salary) AS total_payroll_costs_per_month
FROM t_dw_employees;

SELECT trunc(AVG(salary)) AS average_salary_in_company
FROM t_dw_employees;

SELECT trunc(MIN(salary)) AS min_salary_in_company
FROM t_dw_employees;

SELECT trunc(MAX(salary)) AS min_salary_in_company
FROM t_dw_employees;