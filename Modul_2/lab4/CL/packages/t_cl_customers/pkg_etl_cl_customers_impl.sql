alter session set current_schema=SA_CUSTOMERS;
GRANT SELECT ON SA_CUSTOMERS.t_sa_customers TO DW_CL; 

alter session set current_schema=DW_CL;
CREATE OR REPLACE PACKAGE body pkg_etl_cl_customers
AS  
  PROCEDURE LOAD_CLEAN_CUSTOMERS
   AS   
      CURSOR curs_cl_customers
      IS
         SELECT DISTINCT 
                  client_name
                , client_surname 
                , client_patronymic
                , phone_number
                , client_address
                , payment_method
           FROM SA_CUSTOMERS.t_sa_customers
           WHERE client_name IS NOT NULL 
           AND client_surname IS NOT NULL
           AND client_patronymic IS NOT NULL
           AND phone_number IS NOT NULL
           AND client_address IS NOT NULL
           AND payment_method IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.t_cl_customers';
      FOR i IN curs_cl_customers LOOP
         INSERT INTO DW_CL.t_cl_customers( 
                         client_name
                       , client_surname 
                       , client_patronymic
                       , phone_number
                       , client_address
                       , payment_method)
              VALUES ( i.client_name
                     , i.client_surname 
                     , i.client_patronymic
                     , i.phone_number
                     , i.client_address
                     , i.payment_method);

         EXIT WHEN curs_cl_customers%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_CUSTOMERS;
END pkg_etl_cl_customers;


alter session set current_schema=DW_CL;
exec pkg_etl_cl_customers.LOAD_CLEAN_CUSTOMERS;
select * from t_cl_customers;

commit;

