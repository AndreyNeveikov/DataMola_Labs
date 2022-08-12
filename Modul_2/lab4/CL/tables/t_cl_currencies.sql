alter session set current_schema=DW_CL;
drop table t_cl_currencies;

alter session set current_schema=DW_CL;

Create table t_cl_currencies ( 
currency_id                   INT              not null,
currency_name                 VARCHAR2(7)      not null,
direct_exchange_rate          FLOAT            not null,
reverse_exchange_rate         FLOAT            not null   
);