alter session set current_schema=DW_DATA;
drop table t_dw_doers;

alter session set current_schema=DW_DATA;
DROP SEQUENCE SEQ_DOERS;
CREATE SEQUENCE SEQ_DOERS
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;


Create table t_dw_doers (
doer_id                       INT              not null,
vehicle_registration_plate    VARCHAR2(8)      not null,
driving_category              VARCHAR2(20)     not null,
constraint PK_T_DW_DOERS primary key (doer_id)
);

