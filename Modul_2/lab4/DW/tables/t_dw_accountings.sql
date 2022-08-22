--------------------------------------------------------------------------------
--                                                                            --
--                     NOW IT IS CALCULATED DATA MART                         --
--                                                                            --
--------------------------------------------------------------------------------

alter session set current_schema=DW_DATA;
drop table t_dw_accounting;

alter session set current_schema=DW_DATA;
Create table t_dw_accounting (
date_id                       DATE         ,
taxes                         DATE         ,      
mandatory_payments            DATE         ,    
depreciation_rate             VARCHAR2(44) ,
investments_for_development   VARCHAR2(1)  ,
payment_to_owner              VARCHAR2(2)  ,
circulating_capital           VARCHAR2(3)  ,
free_cash                     VARCHAR2(1)  ,
constraint PK_T_DW_ACCOUNTINGS primary key (date_id)     
);

ALTER TABLE DW_DATA.t_dw_accounting
   ADD CONSTRAINT fk_t_dw_finacial_calendar_t_dw_accounting FOREIGN KEY (date_id)
      REFERENCES DW_DATA.t_dw_financial_calendar (date_id);
      

ALTER TABLE DW_DATA.t_dw_accounting
   DROP CONSTRAINT fk_t_dw_finacial_calendar_t_dw_accounting;
   