--creating table with id PK
alter session set current_schema = u_dw_references;
--drop table t_days;
--alter user u_dw_references quota unlimited on TS_REFERENCES_DATA_01;

CREATE TABLE t_days(
DAY_ID                    NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
DAY_NAME                      VARCHAR2(44) ,
DAY_NUMBER_IN_WEEK            VARCHAR2(1)  ,
DAY_NUMBER_IN_MONTH           VARCHAR2(2)  ,
DAY_NUMBER_IN_YEAR            VARCHAR2(3),
CONSTRAINT "PK_DW.T_DAYS" PRIMARY KEY(day_id) USING INDEX TABLESPACE ts_references_idx_01
);

--select * from t_days;