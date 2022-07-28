grant SELECT on DW_DATA.t_dw_paybacks to DM_ORDERS;

create or replace view DM_ORDERS.w_order_costs as
SELECT /*+ PARALLEL(4) */     
            product_costs,
            fuel_costs,
            vehicle_depreciation,
            insurance_cost,
            unexpected_expenses            
  FROM DW_DATA.t_dw_paybacks;

--select * from DM_ORDERS.w_order_costs;