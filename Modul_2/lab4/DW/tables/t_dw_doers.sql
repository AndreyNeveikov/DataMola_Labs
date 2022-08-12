alter session set current_schema=DW_DATA;
drop table t_dw_doers;

alter session set current_schema=DW_DATA;

Create table t_dw_doers (
doer_id                       INT              not null,
vehicle_registration_plate    VARCHAR2(8)      not null,
driving_category              VARCHAR2(20)     not null,
constraint PK_T_DW_DOERS primary key (doer_id)
)