alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.t_dw_customers TO SAL_CL;

alter session set current_schema=SAL_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_sal_customers
AS  
  PROCEDURE LOAD_SAL_CUSTOMERS
   AS
     BEGIN
     MERGE INTO SAL_CL.t_sal_customers A
     USING ( SELECT 
client_id,       
client_name,
client_surname,
client_patronymic,
phone_number,
client_address,
payment_method
             FROM DW_DATA.t_dw_customers) B
             ON (a.client_id = b.client_id)
             WHEN MATCHED THEN 
                UPDATE SET a.phone_number = b.phone_number
             WHEN NOT MATCHED THEN 
                INSERT (
a.client_id,       
a.client_name,
a.client_surname,
a.client_patronymic,
a.phone_number,
a.client_address,
a.payment_method
)
                VALUES (
b.client_id,       
b.client_name,
b.client_surname,
b.client_patronymic,
b.phone_number,
b.client_address,
b.payment_method
);
     COMMIT;
   END LOAD_SAL_CUSTOMERS;
END pkg_etl_sal_customers;

alter session set current_schema=SAL_CL;
exec pkg_etl_sal_customers.LOAD_SAL_CUSTOMERS;
select count(*) from t_sal_customers;

commit;