alter session set current_schema=SAL_CL;

Create table t_sal_fct_orders (
order_id                      INT              not null,
client_id                     INT              not null,
doer_id                       INT              not null,
region_id                     INT              not null,
currency_id                   INT              not null,
date_id                       DATE             not null,
employee_id                   INT              not null,
product_name                  VARCHAR2(15)     not null,
order_price                   FLOAT            not null,
order_status                  VARCHAR2(10)     not null,
order_date                    DATE             not null,
receiving_date                DATE             not null
)   
 PARTITION BY RANGE (order_date)
    (PARTITION orders_1_half_2020 VALUES LESS THAN
        (to_date('01/06/2020','dd/mm/yyyy')),
     PARTITION orders_2_half_2020 VALUES LESS THAN
        (to_date('01/01/2021','dd/mm/yyyy')),
     PARTITION orders_1_half_2021 VALUES LESS THAN
        (to_date('01/06/2021','dd/mm/yyyy')),
     PARTITION orders_2_half_2021 VALUES LESS THAN
        (to_date('01/01/2022','dd/mm/yyyy')),
     PARTITION orders_later_than_2021 VALUES LESS THAN(MAXVALUE)
);


alter session set current_schema=SAL_CL;
drop table t_sal_fct_orders;