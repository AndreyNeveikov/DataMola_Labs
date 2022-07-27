--alter session set current_schema=SA_ORDERS;
--drop table t_sa_orders;

alter session set current_schema=SA_ORDERS;

Create table t_sa_orders (
product_name                  VARCHAR2(15)     not null,
order_price                   FLOAT            not null,
order_status                  VARCHAR2(15)     not null,
order_date                    DATE             not null,
receiving_date                VARCHAR2(15)     not null
)