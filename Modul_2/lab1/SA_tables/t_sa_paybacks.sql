--alter session set current_schema=SA_ORDERS;
--drop table t_sa_paybacks;

alter session set current_schema=SA_ORDERS;

Create table t_sa_paybacks (
customer_payment              FLOAT            not null,
product_costs                 FLOAT            not null,
fuel_costs                    FLOAT            not null,
vehicle_depreciation          FLOAT            not null,
insurance_cost                FLOAT            not null,
unexpected_expenses           FLOAT            not null
);