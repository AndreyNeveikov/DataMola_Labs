alter session set current_schema=SA_CURRENCIES;
GRANT SELECT ON SA_CURRENCIES.t_sa_currencies TO DW_CL; 

alter session set current_schema=DW_CL;
CREATE OR REPLACE PACKAGE body pkg_etl_cl_currencies
AS  
  PROCEDURE LOAD_CLEAN_CURRENCY
   AS   
      CURSOR curs_cl_currencies
      IS
         SELECT DISTINCT currency_id
                       , currency_name
                       , direct_exchange_rate
                       , reverse_exchange_rate
           FROM SA_CURRENCIES.t_sa_currencies
           WHERE currency_id IS NOT NULL 
           AND currency_name IS NOT NULL
           AND direct_exchange_rate IS NOT NULL
           AND reverse_exchange_rate IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.t_cl_currencies';
      FOR i IN curs_cl_currencies LOOP
         INSERT INTO DW_CL.t_cl_currencies( 
                         currency_code
                       , currency_name
                       , direct_exchange_rate
                       , reverse_exchange_rate)
              VALUES ( i.currency_id
                     , i.currency_name
                     , i.direct_exchange_rate
                     , i.reverse_exchange_rate);

         EXIT WHEN curs_cl_currencies%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_CURRENCY;
END pkg_etl_cl_currencies;


alter session set current_schema=DW_CL;
exec pkg_etl_cl_currencies.LOAD_CLEAN_CURRENCY;
select * from t_cl_currencies;

commit;

