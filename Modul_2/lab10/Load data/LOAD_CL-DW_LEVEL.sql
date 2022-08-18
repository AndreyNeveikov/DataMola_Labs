alter session set current_schema=DW_DATA;

BEGIN
    pkg_etl_dw_currencies.LOAD_DW_CURRENCY;
    pkg_etl_dw_customers.LOAD_DW_CUSTOMERS;
    pkg_etl_dw_doers.LOAD_DW_DOERS;
    pkg_etl_dw_employees.LOAD_DW_EMPLOYEES;
    pkg_etl_dw_financial_calendar.LOAD_DW_FINANCIAL_CALENDAR;
    pkg_etl_dw_fct_orders.LOAD_DW_FCT_ORDERS;
    pkg_etl_dw_paybacks.LOAD_DW_PAYBACKS;
    pkg_etl_dw_regions.LOAD_DW_REGIONS;
END;