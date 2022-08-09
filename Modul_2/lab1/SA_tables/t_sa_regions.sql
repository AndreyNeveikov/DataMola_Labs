--alter session set current_schema=SA_ORDERS;
--drop table t_sa_regions;

alter session set current_schema=SA_ORDERS;

Create table t_sa_regions (
region_id                     INT              not null,
region_name                   VARCHAR2(15)     not null,
country                       VARCHAR2(20)     not null,
city                          VARCHAR2(20)     not null,
official_language             VARCHAR2(15)     not null,
VAT_rate                      FLOAT            not null,
timezone                      VARCHAR2(10)     not null
);