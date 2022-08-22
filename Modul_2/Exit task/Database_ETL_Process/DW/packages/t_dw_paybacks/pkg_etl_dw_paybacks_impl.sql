alter session set current_schema=DW_CL;
GRANT SELECT ON DW_CL.t_cl_paybacks TO DW_DATA;

alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_paybacks
AS  
  PROCEDURE LOAD_DW_PAYBACKS
   AS
     BEGIN
     MERGE INTO DW_DATA.t_dw_paybacks A
     USING ( SELECT customer_payment, product_costs, fuel_costs, vehicle_depreciation, insurance_cost, unexpected_expenses
             FROM DW_CL.t_cl_paybacks) B
             ON (a.customer_payment = b.customer_payment AND a.product_costs = b.product_costs AND a.fuel_costs = b.fuel_costs AND 
                    a.vehicle_depreciation = b.vehicle_depreciation AND a.insurance_cost = b.insurance_cost)
             WHEN MATCHED THEN 
                UPDATE SET a.unexpected_expenses = b.unexpected_expenses
             WHEN NOT MATCHED THEN 
                INSERT (a.order_id, a.customer_payment, a.product_costs, a.fuel_costs, a.vehicle_depreciation, a.insurance_cost, a.unexpected_expenses)
                VALUES (SEQ_PAYBACKS.NEXTVAL, b.customer_payment, b.product_costs, b.fuel_costs, b.vehicle_depreciation, b.insurance_cost, b.unexpected_expenses);
     COMMIT;
   END LOAD_DW_PAYBACKS;
END pkg_etl_dw_paybacks;

alter session set current_schema=DW_DATA;
exec pkg_etl_dw_paybacks.LOAD_DW_PAYBACKS;
select * from t_dw_paybacks;

commit;