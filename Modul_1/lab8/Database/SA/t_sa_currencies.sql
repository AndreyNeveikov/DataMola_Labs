--alter session set current_schema=SA_CURRENCIES;
--drop table t_sa_currencies;

alter session set current_schema=SA_CURRENCIES;

Create table t_sa_currencies ( 
currenci_id                   INT              not null,
currenci_name                 VARCHAR2(25)     not null,
direct_exchange_rate          FLOAT            not null,
reverse_exchange_rate         FLOAT            not null     
)