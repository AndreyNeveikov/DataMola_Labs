--alter session set current_schema=SA_CUSTOMERS;
--drop table t_sa_customers;

alter session set current_schema=SA_CUSTOMERS;

Create table t_sa_customers (       
client_name                   VARCHAR2(15)     not null,
client_surname                VARCHAR2(15)     not null,
client_patronymic             VARCHAR2(15)     not null,
phone_number                  NUMBER           not null,
client_address                VARCHAR2(50)     not null,
payment_method                VARCHAR2(15)     not null
)