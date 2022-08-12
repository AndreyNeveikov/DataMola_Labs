alter session set current_schema=DW_CL;
drop table t_cl_paybacks;

alter session set current_schema=DW_CL;

Create table t_cl_paybacks (
customer_payment              FLOAT            not null,
product_costs                 FLOAT            not null,
fuel_costs                    FLOAT            not null,
vehicle_depreciation          FLOAT            not null,
insurance_cost                FLOAT            not null,
unexpected_expenses           FLOAT            not null
);