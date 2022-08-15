--==============================================================
-- DBMS name:      ORACLE
-- Created on:     25.07.2022 
--==============================================================

DROP USER SA_CUSTOMERS;
DROP USER SA_ORDERS;
DROP USER SA_CURRENCIES;
DROP USER DW_CL;
DROP USER DW_DATA;
DROP USER SAL_DW_CL;
DROP USER SAL_CL;
DROP USER DM_EMPLOYEES;
DROP USER DM_CUSTOMERS;
DROP USER DM_ORDERS;
DROP USER DM_CURRENCIES;
DROP USER DM_DOERS;
DROP USER DM_PAYBACKS;
DROP USER DM_ACCOUNTINGS;
DROP USER DM_REGIONS;


/*Storage level*/
--==============================================================
-- User: SA_CUSTOMERS
--==============================================================
CREATE USER SA_CUSTOMERS
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_customers_data_01;

GRANT UNLIMITED TABLESPACE TO SA_CUSTOMERS;

--==============================================================
-- User: SA_ORDERS
--==============================================================
CREATE USER SA_ORDERS
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_orders_data_01;

GRANT UNLIMITED TABLESPACE TO SA_ORDERS;

--==============================================================
-- User: SA_CURRENCIES
--==============================================================
CREATE USER SA_CURRENCIES
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_currencies_data_01;

GRANT UNLIMITED TABLESPACE TO SA_CURRENCIES;

/*Data warehouse Cleansing Level*/
--==============================================================
-- User: DW_CL
--==============================================================
CREATE USER DW_CL
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_cl_01;

GRANT UNLIMITED TABLESPACE TO DW_CL;


/*Data warehouse Start Cleansing Level*/
--==============================================================
-- User: DW_DATA
--==============================================================
CREATE USER DW_DATA
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_data_01;

GRANT CREATE MATERIALIZED VIEW, CREATE TABLE, CREATE VIEW, QUERY REWRITE TO DW_DATA;
GRANT UNLIMITED TABLESPACE TO DW_DATA;


/*Start Cleansing Level*/
--==============================================================
-- User: SAL_DW_CL
--==============================================================
CREATE USER SAL_DW_CL
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_star_cls_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO SAL_DW_CL;

--==============================================================
-- User: SAL_CL
--==============================================================
CREATE USER SAL_CL
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sal_cl_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO SAL_CL;


/*Data warehouse Start Level and Data Marts*/
--==============================================================
-- User: DM_EMPLOYEES
--==============================================================
CREATE USER DM_EMPLOYEES
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dm_employees_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO DM_EMPLOYEES;

--==============================================================
-- User: DM_CUSTOMERS
--==============================================================
CREATE USER DM_CUSTOMERS
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dm_customers_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO DM_CUSTOMERS;

--==============================================================
-- User: DM_ORDERS
--==============================================================
CREATE USER DM_ORDERS
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dm_orders_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO DM_ORDERS;

--==============================================================
-- User: DM_CURRENCIES
--==============================================================
CREATE USER DM_CURRENCIES
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dm_currencies_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO DM_CURRENCIES;

--==============================================================
-- User: DM_DOERS
--==============================================================
CREATE USER DM_DOERS
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dm_doers_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO DM_DOERS;

--==============================================================
-- User: DM_PAYBACKS
--==============================================================
CREATE USER DM_PAYBACKS
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dm_paybacks_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO DM_PAYBACKS;

--==============================================================
-- User: DM_ACCOUNTINGS
--==============================================================
CREATE USER DM_ACCOUNTINGS
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dm_accounting_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO DM_ACCOUNTINGS;

--==============================================================
-- User: DM_REGIONS
--==============================================================
CREATE USER DM_REGIONS
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dm_regions_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO DM_REGIONS;
