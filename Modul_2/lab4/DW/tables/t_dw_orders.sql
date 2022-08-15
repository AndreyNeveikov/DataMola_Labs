alter session set current_schema=DW_DATA;


ALTER TABLE DW_DATA.t_dw_fct_orders
   DROP CONSTRAINT fk_t_dw_customers_t_dw_orders;
 ------------------------------------------------------------------------  
ALTER TABLE DW_DATA.t_dw_fct_orders
   DROP CONSTRAINT fk_t_dw_doers_t_dw_fct_orders;
  
ALTER TABLE DW_DATA.t_dw_fct_orders
   ADD CONSTRAINT fk_t_dw_doers_t_dw_fct_orders FOREIGN KEY (doer_id)
      REFERENCES DW_DATA.t_dw_doers (doer_id); /*We need to drop it to lab5 task1*/
-------------------------------------------------------------------------   
ALTER TABLE DW_DATA.t_dw_fct_orders
   DROP CONSTRAINT fk_t_dw_regions_t_dw_fct_orders;
 -------------------------------------------------------------------------  
ALTER TABLE DW_DATA.t_dw_fct_orders
   DROP CONSTRAINT fk_t_dw_currencies_t_dw_fct_orders;
   
ALTER TABLE DW_DATA.t_dw_fct_orders
   ADD CONSTRAINT fk_t_dw_currencies_t_dw_fct_orders FOREIGN KEY (currency_id)
      REFERENCES DW_DATA.t_dw_currencies (currency_id); /*We need to drop it to lab5 task1*/
--------------------------------------------------------------------------
ALTER TABLE DW_DATA.t_dw_fct_orders
   DROP CONSTRAINT fk_t_dw_financial_calendar_t_dw_fct_orders CASCADE;
ALTER TABLE DW_DATA.t_dw_fct_orders
   DROP CONSTRAINT fk_t_dw_employees_t_dw_fct_orders;

alter session set current_schema=DW_DATA;
drop table t_dw_fct_orders;
-------------------------------------------
alter session set current_schema=DW_DATA;

DROP SEQUENCE SEQ_FCT_ORDERS;
CREATE SEQUENCE SEQ_FCT_ORDERS
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

Create table t_dw_fct_orders (
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
receiving_date                DATE             not null,
CONSTRAINT PK_T_DW_ORDERS primary key (order_id),
CONSTRAINT fk_t_dw_customers_t_dw_fct_orders FOREIGN KEY (client_id)
      REFERENCES DW_DATA.t_dw_customers (client_id),
CONSTRAINT fk_t_dw_doers_t_dw_fct_orders FOREIGN KEY (doer_id)
      REFERENCES DW_DATA.t_dw_doers (doer_id),
CONSTRAINT fk_t_dw_regions_t_dw_fct_orders FOREIGN KEY (region_id)
      REFERENCES DW_DATA.t_dw_regions (region_id),
CONSTRAINT fk_t_dw_currencies_t_dw_fct_orders FOREIGN KEY (currency_id)
      REFERENCES DW_DATA.t_dw_currencies (currency_id),
CONSTRAINT fk_t_dw_financial_calendar_t_dw_fct_orders FOREIGN KEY (date_id)
      REFERENCES DW_DATA.t_dw_financial_calendar (date_id),
CONSTRAINT fk_t_dw_employees_t_dw_fct_orders FOREIGN KEY (employee_id)
      REFERENCES DW_DATA.t_dw_employees (employee_id)
      )      
PARTITION BY RANGE (date_id)
    subpartition by hash(client_id) subpartitions 4
(
    PARTITION FST_ADVERTISING_PERIOD VALUES LESS THAN(TO_DATE('19-02-2022','dd-mm-yy'))
    (
      subpartition FST_ADVERTISING_PERIOD_sub_1,
      subpartition FST_ADVERTISING_PERIOD_sub_2,
      subpartition FST_ADVERTISING_PERIOD_sub_3,
      subpartition FST_ADVERTISING_PERIOD_sub_4
    ),
    PARTITION SND_ADVERTISING_PERIOD VALUES LESS THAN(TO_DATE('10-04-2022','dd-mm-yy'))
    (
      subpartition SND_ADVERTISING_PERIOD_sub_1,
      subpartition SND_ADVERTISING_PERIOD_sub_2,
      subpartition SND_ADVERTISING_PERIOD_sub_3,
      subpartition SND_ADVERTISING_PERIOD_sub_4
     ),
     PARTITION TRD_ADVERTISING_PERIOD VALUES LESS THAN(TO_DATE('30-05-2022','dd-mm-yy'))
    (
      subpartition TRD_ADVERTISING_PERIOD_sub_1,
      subpartition TRD_ADVERTISING_PERIOD_sub_2,
      subpartition TRD_ADVERTISING_PERIOD_sub_3,
      subpartition TRD_ADVERTISING_PERIOD_sub_4
    ),
     PARTITION FTH_ADVERTISING_PERIOD VALUES LESS THAN(MAXVALUE)
    (
      subpartition FTH_ADVERTISING_PERIOD_sub_1,
      subpartition FTH_ADVERTISING_PERIOD_sub_2,
      subpartition FTH_ADVERTISING_PERIOD_sub_3,
      subpartition FTH_ADVERTISING_PERIOD_sub_4
    )
);
