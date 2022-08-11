--alter session set current_schema=DW_CL;
--drop table t_cl_accountings;

alter session set current_schema=DW_CL;

Create table t_cl_accountings (
taxes                         DATE         ,      
mandatory_payments            DATE         ,    
depreciation_rate             VARCHAR2(44) ,
investments_for_development   VARCHAR2(1)  ,
payment_to_owner              VARCHAR2(2)  ,
circulating_capital           VARCHAR2(3)  ,
free_cash                     VARCHAR2(1)  
);

--------------------------------------------------------------------------------
--                                                                            --
--                     NOW IT IS CALCULATED DATA MART                         --
--                                                                            --
--------------------------------------------------------------------------------