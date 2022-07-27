--alter session set current_schema=DW_DATA;
--drop table t_dw_currencies;

alter session set current_schema=DW_DATA;

Create table t_dw_currencies ( 
currenci_id                   INT            not null,
currenci_name                 VARCHAR2(25)   not null,
direct_exchange_rate          FLOAT          not null,
reverse_exchange_rate         FLOAT          not null,
constraint PK_T_DW_CURRENCIES primary key (currenci_id)           
)