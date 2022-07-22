alter session set current_schema=u_dw_ext_references;

CREATE TABLE cls_weeks (
CALENDAR_WEEK_NUMBER          VARCHAR2(1)  ,
WEEK_ENDING_DATE              DATE        
) 
TABLESPACE TS_REFERENCES_EXT_DATA_01;