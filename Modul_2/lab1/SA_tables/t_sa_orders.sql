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

Create table t_sa_regions (
region_id                     INT              not null,
region_name                   VARCHAR2(15)     not null,
country                       VARCHAR2(20)     not null,
city                          VARCHAR2(20)     not null,
official_language             VARCHAR2(15)     not null,
VAT_rate                      FLOAT            not null,
timezone                      VARCHAR2(10)     not null
)

Create table t_sa_paybacks (
customer_payment              FLOAT            not null,
product_costs                 FLOAT            not null,
fuel_costs                    FLOAT            not null,
vehicle_depreciation          FLOAT            not null,
insurance_cost                FLOAT            not null,
unexpected_expenses           FLOAT            not null
)

Create table t_sa_doers (
vehicle_registration_plate    VARCHAR2(15)     not null,
driving_category              VARCHAR2(20)     not null
)