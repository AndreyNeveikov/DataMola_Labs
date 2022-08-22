alter session set current_schema=SAL_CL;
Create table t_sal_customers (
client_id                     INT              not null,       
client_name                   VARCHAR2(15)     not null,
client_surname                VARCHAR2(15)     not null,
client_patronymic             VARCHAR2(15)     not null,
phone_number                  INT              not null,
client_address                VARCHAR2(25)     not null,
payment_method                VARCHAR2(6)      not null
);