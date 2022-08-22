alter session set current_schema=DW_DATA;
drop table t_dw_customers;

alter session set current_schema=DW_DATA;

DROP SEQUENCE SEQ_CUSTOMERS;
CREATE SEQUENCE SEQ_CUSTOMERS
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

Create table t_dw_customers (
client_id                     INT              not null,       
client_name                   VARCHAR2(15)     not null,
client_surname                VARCHAR2(15)     not null,
client_patronymic             VARCHAR2(15)     not null,
phone_number                  INT              not null,
client_address                VARCHAR2(25)     not null,
payment_method                VARCHAR2(6)      not null,
constraint PK_T_DW_CUSTOMERS primary key (client_id)
);