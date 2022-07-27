--alter session set current_schema=DW_DATA;
--drop table t_dw_regions;

alter session set current_schema=DW_DATA;

Create table t_dw_regions (
region_id                     INT              not null,
region_name                   VARCHAR2(15)     not null,
country                       VARCHAR2(20)     not null,
city                          VARCHAR2(20)     not null,
official_language             VARCHAR2(15)     not null,
VAT_rate                      FLOAT            not null,
timezone                      VARCHAR2(10)     not null,
constraint PK_T_DW_REGIONS primary key (region_id)
)