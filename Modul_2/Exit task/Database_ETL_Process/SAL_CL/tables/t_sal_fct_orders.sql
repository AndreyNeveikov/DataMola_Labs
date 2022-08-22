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

select *
 from t_sal_fct_orders;

alter session set current_schema=SAL_CL;
ALTER TABLE t_sal_fct_orders MERGE PARTITIONS orders_1_half_2020, orders_2_half_2020
INTO PARTITION orders_2020 TABLESPACE ts_dw_star_cls_01
COMPRESS UPDATE GLOBAL INDEXES PARALLEL 4;

select * from orders_1_half_2021;

alter session set current_schema=SAL_CL;
CREATE TABLE orders_1_half_2021 TABLESPACE ts_sal_cl_01
NOLOGGING COMPRESS PARALLEL 4 AS SELECT * FROM DW_DATA.t_dw_fct_orders
WHERE order_date >= to_date('01/01/2021','dd/mm/yyyy')
    AND order_date < to_date('01/06/2021','dd/mm/yyyy');
   
drop table orders_1_half_2021;

alter session set current_schema=SAL_CL;
ALTER TABLE t_sal_fct_orders EXCHANGE PARTITION orders_1_half_2021
WITH TABLE orders_1_half_2021 INCLUDING INDEXES WITHOUT VALIDATION
UPDATE GLOBAL INDEXES;

select *
 from t_sal_fct_orders partition (orders_1_half_2021);

alter session set current_schema=SAL_CL;
drop table t_sal_fct_orders;

commit;