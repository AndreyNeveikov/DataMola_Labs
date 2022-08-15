alter session set current_schema=DW_DATA;
drop MATERIALIZED VIEW mv_daily_profit;

alter session set current_schema=DW_DATA;
CREATE MATERIALIZED VIEW mv_daily_profit
BUILD DEFERRED
REFRESH COMPLETE ON DEMAND
AS SELECT /*+ gather_plan_statistics*/ order_date,
    DECODE (GROUPING(product_name), 1, 'All products', product_name) products,
    DECODE (GROUPING(order_status), 1, 'All statusies', order_status) statusies,
    SUM(order_price) AS profit
FROM dw_data.t_dw_fct_orders
WHERE order_date < TO_DATE( '05.01.20', 'MM/DD/YY' )
GROUP BY order_date, CUBE(product_name, order_status)
ORDER BY 1;

EXECUTE DBMS_MVIEW.REFRESH('mv_daily_profit');

SELECT * FROM  mv_daily_profit;

