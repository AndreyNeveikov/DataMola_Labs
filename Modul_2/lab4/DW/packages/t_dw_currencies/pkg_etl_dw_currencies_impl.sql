alter session set current_schema=DW_CL;
GRANT SELECT ON DW_CL.t_cl_currencies TO DW_DATA;

alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_currencies
AS  
  PROCEDURE LOAD_DW_CURRENCY
   AS
     BEGIN
      DECLARE
       TYPE CURSOR_INT IS TABLE OF INT;
       TYPE CURSOR_VARCHAR IS TABLE OF varchar2(7);
       TYPE CURSOR_FLOAT IS TABLE OF FLOAT; 
    TYPE BIG_CURSOR IS REF CURSOR ;
 
    ALL_INF BIG_CURSOR;
       
       currency_code CURSOR_INT;
       currency_name CURSOR_VARCHAR;
       direct_exchange_rate CURSOR_FLOAT; 
       reverse_exchange_rate CURSOR_FLOAT;
        
       currency_code_STAGE CURSOR_INT;
       currency_id CURSOR_INT;
       
 BEGIN
    OPEN ALL_INF FOR
        SELECT 
                source_CL.currency_code AS currency_code_source_CL,
                source_CL.currency_name AS currency_name_source_CL,
                source_CL.direct_exchange_rate AS direct_exchange_rate_source_CL,
                source_CL.reverse_exchange_rate AS reverse_exchange_rate_source_CL,
                stage.currency_code AS currency_code_stage,
                stage.currency_id AS currency_id
           FROM (SELECT DISTINCT * FROM DW_CL.t_cl_currencies) source_CL
                     LEFT JOIN DW_DATA.t_dw_currencies stage
                     ON (source_CL.currency_code = stage.currency_code);
    FETCH ALL_INF
    BULK COLLECT INTO
                    currency_code,
                    currency_name,
                    direct_exchange_rate, 
                    reverse_exchange_rate,
        
                    currency_code_STAGE,
                    currency_id;
    CLOSE ALL_INF;
 FOR i IN currency_id.FIRST .. currency_id.LAST LOOP
       IF ( currency_id ( i ) IS NULL ) THEN
          INSERT INTO DW_DATA.t_dw_currencies ( 
                                            currency_id,
                                            currency_code,
                                            currency_name,
                                            direct_exchange_rate, 
                                            reverse_exchange_rate)
               VALUES ( SEQ_CURRENCIES.NEXTVAL,
                        currency_code(i),
                        currency_name(i),
                        direct_exchange_rate(i), 
                        reverse_exchange_rate(i));
          COMMIT;
          
          ELSE UPDATE DW_DATA.t_dw_currencies
         SET 
            currency_code = currency_code(i),
            currency_name = currency_name(i),
            direct_exchange_rate = direct_exchange_rate(i), 
            reverse_exchange_rate = reverse_exchange_rate(i)
         WHERE currency_id = currency_id(i);
          COMMIT; 
       END IF;
    END LOOP;
   
 END;
   END LOAD_DW_CURRENCY;
END pkg_etl_dw_currencies;



alter session set current_schema=DW_DATA;
exec pkg_etl_dw_currencies.LOAD_DW_CURRENCY;
select * from t_dw_currencies;

commit;
