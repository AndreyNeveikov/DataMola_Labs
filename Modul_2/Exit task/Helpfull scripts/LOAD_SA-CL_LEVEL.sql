alter session set current_schema=DW_CL;

BEGIN
    pkg_etl_cl_currencies.LOAD_CLEAN_CURRENCY;
    pkg_etl_cl_customers.LOAD_CLEAN_CUSTOMERS;
    pkg_etl_cl_doers.LOAD_CLEAN_DOERS;
    pkg_etl_cl_employees.LOAD_CLEAN_EMPLOYEES;
    pkg_etl_cl_financial_calendar.LOAD_CLEAN_FINANCIAL_CALENDAR;
    pkg_etl_cl_orders.LOAD_CLEAN_ORDERS;
    pkg_etl_cl_paybacks.LOAD_CLEAN_PAYBACKS;
    pkg_etl_cl_regions.LOAD_CLEAN_REGIONS;
END;

exec pkg_etl_cl_currencies.LOAD_CLEAN_CURRENCY;
exec pkg_etl_cl_customers.LOAD_CLEAN_CUSTOMERS;
exec pkg_etl_cl_doers.LOAD_CLEAN_DOERS;
exec pkg_etl_cl_employees.LOAD_CLEAN_EMPLOYEES;
exec pkg_etl_cl_financial_calendar.LOAD_CLEAN_FINANCIAL_CALENDAR;
exec pkg_etl_cl_orders.LOAD_CLEAN_ORDERS;
exec pkg_etl_cl_paybacks.LOAD_CLEAN_PAYBACKS;
exec pkg_etl_cl_regions.LOAD_CLEAN_REGIONS;
