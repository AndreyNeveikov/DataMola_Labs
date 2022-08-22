alter session set current_schema=DW_DATA;
drop table t_dw_regions;

alter session set current_schema=DW_DATA;

Create table t_dw_regions (
region_id                     INT              not null,
region_name                   VARCHAR2(15)     not null,
country                       VARCHAR2(15)     not null,
city                          VARCHAR2(15)     not null,
use_language                  VARCHAR2(5)      not null,
VAT_rate                      FLOAT            not null,
timezone                      VARCHAR2(4)      not null,
constraint PK_T_DW_REGIONS primary key (region_id)
)