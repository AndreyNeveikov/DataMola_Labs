alter session set current_schema=DW_CL;
GRANT SELECT ON DW_CL.t_cl_customers TO DW_DATA;

alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_customers
AS  
  PROCEDURE LOAD_DW_CUSTOMERS
   AS
     BEGIN
     MERGE INTO DW_DATA.t_dw_customers A
     USING ( SELECT client_name, client_surname, client_patronymic, phone_number, client_address, payment_method
             FROM DW_CL.t_cl_customers) B
             ON (a.phone_number = b.phone_number)
             WHEN MATCHED THEN 
                UPDATE SET a.client_address = b.client_address
             WHEN NOT MATCHED THEN 
                INSERT (a.client_id, a.client_name, a.client_surname, a.client_patronymic, a.phone_number, a.client_address, a.payment_method)
                VALUES (SEQ_CUSTOMERS.NEXTVAL, b.client_name, b.client_surname, b.client_patronymic, b.phone_number, b.client_address, b.payment_method);
     COMMIT;
   END LOAD_DW_CUSTOMERS;
END pkg_etl_dw_customers;

alter session set current_schema=DW_DATA;
exec pkg_etl_dw_customers.LOAD_DW_CUSTOMERS;
select * from t_dw_customers;

commit;