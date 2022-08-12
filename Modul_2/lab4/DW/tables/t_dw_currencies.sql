alter session set current_schema=DW_DATA;
drop table t_dw_currencies;

alter session set current_schema=DW_DATA;

Create table t_dw_currencies ( 
currency_id                   INT              not null,
currency_name                 VARCHAR2(7)      not null,
direct_exchange_rate          FLOAT            not null,
reverse_exchange_rate         FLOAT            not null,
constraint PK_T_DW_CURRENCIES primary key (currenci_id)           
)