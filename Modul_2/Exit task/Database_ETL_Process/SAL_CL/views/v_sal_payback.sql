alter session set current_schema=SAL_CL;
drop view v_sal_payback;

alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.t_dw_transactions TO SAL_CL;


alter session set current_schema=SAL_CL;

CREATE OR REPLACE VIEW v_sal_payback
AS SELECT product_name, order_date, 
    customer_payment, product_costs, fuel_costs,
    vehicle_depreciation, insurance_cost, unexpected_expenses, 
    trunc(1 - (product_costs + fuel_costs + vehicle_depreciation + insurance_cost + unexpected_expenses)/customer_payment, 2) payback
FROM DW_DATA.t_dw_transactions;
   
alter session set current_schema=SAL_CL;
SELECT * FROM v_sal_payback;