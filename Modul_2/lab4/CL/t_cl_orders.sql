--alter session set current_schema=DW_CL;
--drop table t_cl_orders;

alter session set current_schema=DW_CL;

Create table t_cl_orders (
product_name                  VARCHAR2(15)     not null,
order_price                   FLOAT            not null,
order_status                  VARCHAR2(15)     not null,
order_date                    DATE             not null,
receiving_date                VARCHAR2(15)     not null
);