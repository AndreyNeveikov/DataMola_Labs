alter session set current_schema=SAL_CL;
drop view dim_sal_payback;

alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.t_dw_fct_orders TO SAL_CL;
GRANT SELECT ON DW_DATA.t_dw_paybacks TO SAL_CL;


alter session set current_schema=SAL_CL;

CREATE OR REPLACE VIEW dim_sal_payback
AS SELECT product_name, order_date, 
    customer_payment, product_costs, fuel_costs,
    vehicle_depreciation, insurance_cost, unexpected_expenses, 
    trunc(1 - (product_costs + fuel_costs + vehicle_depreciation + insurance_cost + unexpected_expenses)/customer_payment, 2) payback
FROM DW_DATA.t_dw_fct_orders ord
INNER JOIN DW_DATA.t_dw_paybacks payb ON payb.order_id = ord.order_id;
   
alter session set current_schema=SAL_CL;
SELECT count(*) FROM dim_sal_payback;