alter session set current_schema=SA_ORDERS;
GRANT SELECT ON SA_ORDERS.t_sa_paybacks TO DW_CL; 

alter session set current_schema=DW_CL;
CREATE OR REPLACE PACKAGE body pkg_etl_cl_paybacks
AS  
  PROCEDURE LOAD_CLEAN_PAYBACKS
   AS   
      CURSOR curs_cl_paybacks
      IS
         SELECT DISTINCT 
                    customer_payment
                  , product_costs
                  , fuel_costs
                  , vehicle_depreciation 
                  , insurance_cost
                  , unexpected_expenses
           FROM SA_ORDERS.t_sa_paybacks
           WHERE customer_payment IS NOT NULL 
           AND product_costs IS NOT NULL
           AND fuel_costs IS NOT NULL
           AND vehicle_depreciation IS NOT NULL
           AND insurance_cost IS NOT NULL
           AND unexpected_expenses IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.t_cl_paybacks';
      FOR i IN curs_cl_paybacks LOOP
         INSERT INTO DW_CL.t_cl_paybacks( 
                          customer_payment
                        , product_costs
                        , fuel_costs
                        , vehicle_depreciation 
                        , insurance_cost
                        , unexpected_expenses)
              VALUES (i.customer_payment
                    , i.product_costs
                    , i.fuel_costs
                    , i.vehicle_depreciation 
                    , i.insurance_cost
                    , i.unexpected_expenses);

         EXIT WHEN curs_cl_paybacks%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_PAYBACKS;
END pkg_etl_cl_paybacks;


alter session set current_schema=DW_CL;
exec pkg_etl_cl_paybacks.LOAD_CLEAN_PAYBACKS;
select * from t_cl_paybacks;

commit;

