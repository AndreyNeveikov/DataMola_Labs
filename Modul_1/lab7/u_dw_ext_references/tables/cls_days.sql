alter session set current_schema=u_dw_ext_references;

create table cls_days(       
DAY_NAME                      VARCHAR2(44) ,
DAY_NUMBER_IN_WEEK            VARCHAR2(1)  ,
DAY_NUMBER_IN_MONTH           VARCHAR2(2)  ,
DAY_NUMBER_IN_YEAR            VARCHAR2(3)  
)
tablespace TS_REFERENCES_EXT_DATA_01;