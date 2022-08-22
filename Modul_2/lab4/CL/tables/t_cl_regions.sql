alter session set current_schema=DW_CL;
drop table t_cl_regions;

alter session set current_schema=DW_CL;

Create table t_cl_regions (
region_id                     INT              not null,
region_name                   VARCHAR2(15)     not null,
country                       VARCHAR2(15)     not null,
city                          VARCHAR2(15)     not null,
use_language                  VARCHAR2(5)      not null,
VAT_rate                      FLOAT            not null,
timezone                      VARCHAR2(4)      not null
);