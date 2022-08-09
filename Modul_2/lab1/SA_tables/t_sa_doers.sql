--alter session set current_schema=SA_ORDERS;
--drop table t_sa_doers;

alter session set current_schema=SA_ORDERS;

Create table t_sa_doers (
vehicle_registration_plate    VARCHAR2(15)     not null,
driving_category              VARCHAR2(20)     not null
);