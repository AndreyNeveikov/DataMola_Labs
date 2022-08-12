alter session set current_schema=DW_CL;
drop table t_cl_doers;

alter session set current_schema=DW_CL;

Create table t_cl_doers (
vehicle_registration_plate    VARCHAR2(8)      not null,
driving_category              VARCHAR2(20)     not null
);