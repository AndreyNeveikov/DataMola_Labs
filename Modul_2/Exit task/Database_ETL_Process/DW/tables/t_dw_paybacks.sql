alter session set current_schema=DW_DATA;
drop table t_dw_paybacks;

alter session set current_schema=DW_DATA;

DROP SEQUENCE SEQ_PAYBACKS;
CREATE SEQUENCE SEQ_PAYBACKS
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

Create table t_dw_paybacks (
order_id                      INT              not null,
customer_payment              FLOAT            not null,
product_costs                 FLOAT            not null,
fuel_costs                    FLOAT            not null,
vehicle_depreciation          FLOAT            not null,
insurance_cost                FLOAT            not null,
unexpected_expenses           FLOAT            not null,
constraint PK_T_DW_PAYBACKS primary key (order_id)
);

