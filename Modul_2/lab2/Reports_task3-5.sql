/*TASK_3*/

SELECT product_name, client_address, order_date,  sum(order_price) profit,

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
   
   FROM SA_ORDERS.t_sa_transactions
   WHERE date_id  >= TO_DATE( '01.01.20', 'MM/DD/YY' ) AND date_id  < TO_DATE( '01.03.20', 'MM/DD/YY' )
   GROUP BY CUBE(product_name, client_address, order_date);

---------------------------------------------------------------------------------------------------------   
   
SELECT product_name, order_date, receiving_date, round(AVG(order_price), 1) avg_profit,

   GROUPING(product_name) name_,
   GROUPING(receiving_date) rec_date,
   GROUPING(order_date) date_,
   
   GROUPING_ID(product_name, receiving_date) name_rec_date,
   GROUPING_ID(receiving_date, product_name) rec_date_name,
   GROUPING_ID(product_name, order_date) name_date,
   GROUPING_ID(receiving_date, order_date) rec_date_date,
   
   GROUPING_ID(receiving_date, product_name, order_date) rec_date_name_date,
   GROUPING_ID(receiving_date, order_date, product_name) rec_date_date_name,
   GROUPING_ID(order_date, product_name, receiving_date) date_name_rec_date
   
   FROM SA_ORDERS.t_sa_transactions
   WHERE date_id >= TO_DATE( '01.01.20', 'MM/DD/YY' ) AND date_id  < TO_DATE( '01.03.20', 'MM/DD/YY' )
   GROUP BY CUBE(product_name, receiving_date, order_date);
   
---------------------------------------------------------------------------------------------------------

/*TASK_4*/

SELECT 
    product_name, client_address, calendar_month_number,  sum(order_price) profit
FROM 
    SA_ORDERS.t_sa_transactions
WHERE 
    date_id  >= TO_DATE( '01.01.20', 'MM/DD/YY' ) AND date_id  < TO_DATE( '02.01.20', 'MM/DD/YY' )
GROUP BY ROLLUP
    (product_name, client_address, calendar_month_number);
    
---------------------------------------------------------------------------------------------------------

SELECT 
    product_name, order_status, calendar_month_number, round(AVG(order_price), 1) avg_profit
FROM 
    SA_ORDERS.t_sa_transactions
WHERE 
    date_id >= TO_DATE( '01.01.20', 'MM/DD/YY' ) AND date_id  < TO_DATE( '01.03.20', 'MM/DD/YY' )
GROUP BY ROLLUP
    (product_name, order_status, calendar_month_number);
    
---------------------------------------------------------------------------------------------------------

SELECT 
    product_name, client_address, calendar_month_number,  sum(order_price) profit
FROM 
    SA_ORDERS.t_sa_transactions
WHERE 
    date_id  >= TO_DATE( '01.01.20', 'MM/DD/YY' ) AND date_id  < TO_DATE( '02.01.20', 'MM/DD/YY' )
GROUP BY ROLLUP
    (product_name, client_address, calendar_month_number);
    
---------------------------------------------------------------------------------------------------------

SELECT 
    product_name, order_status, calendar_month_number, round(AVG(order_price), 1) avg_profit
FROM 
    SA_ORDERS.t_sa_transactions
WHERE 
    date_id >= TO_DATE( '01.01.20', 'MM/DD/YY' ) AND date_id  < TO_DATE( '01.03.20', 'MM/DD/YY' )
GROUP BY GROUPING SETS
    (product_name, order_status, calendar_month_number);

---------------------------------------------------------------------------------------------------------

/*TASK_5*/

SELECT 
    order_date, calendar_month_number, fin_quarter_number, fin_year,  sum(order_price) profit
FROM 
    SA_ORDERS.t_sa_transactions
WHERE 
    order_date  >= TO_DATE( '04.01.20', 'MM/DD/YY' ) AND order_date  < TO_DATE( '04.01.21', 'MM/DD/YY' )
GROUP BY GROUPING SETS
    (order_date, calendar_month_number, fin_quarter_number, fin_year);
    
---------------------------------------------------------------------------------------------------------

SELECT 
    order_date, calendar_month_number, fin_quarter_number, fin_year, round(AVG(order_price), 1) avg_profit
FROM 
    SA_ORDERS.t_sa_transactions
WHERE 
    date_id >= TO_DATE( '04.01.20', 'MM/DD/YY' ) AND date_id  < TO_DATE( '04.01.21', 'MM/DD/YY' )
GROUP BY GROUPING SETS
    (order_date, calendar_month_number, fin_quarter_number, fin_year);
    