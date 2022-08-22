alter session set current_schema=DW_DATA;
truncate table t_dw_fct_orders;
truncate table t_dw_customers;
truncate table t_dw_employees;
truncate table t_dw_doers;
truncate table t_dw_paybacks;
truncate table t_dw_regions;
truncate table t_dw_currencies;
truncate table t_dw_financial_calendar;

alter session set current_schema=DW_DATA;

DROP SEQUENCE SEQ_CURRENCIES;
CREATE SEQUENCE SEQ_CURRENCIES
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
DROP SEQUENCE SEQ_DOERS;
CREATE SEQUENCE SEQ_DOERS
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
DROP SEQUENCE SEQ_PAYBACKS;
CREATE SEQUENCE SEQ_PAYBACKS
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
DROP SEQUENCE SEQ_FCT_ORDERS;
CREATE SEQUENCE SEQ_FCT_ORDERS
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
DROP SEQUENCE SEQ_CUSTOMERS;
CREATE SEQUENCE SEQ_CUSTOMERS
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;