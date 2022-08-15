alter session set current_schema = DW_CL;
GRANT SELECT ON t_cl_currencies  TO DW_DATA;
alter session set current_schema = DW_DATA;
select * from DW_CL.t_cl_currencies;

alter session set current_schema = DW_DATA;
select * from DW_DATA.t_dw_currencies;

alter session set current_schema = DW_DATA;
truncate table DW_DATA.t_dw_currencies;

alter session set current_schema = DW_DATA;
truncate table DW_DATA.t_dw_doers;

alter session set current_schema = DW_DATA;
CREATE OR REPLACE PACKAGE body pkg_independent_etl_dw_currencies
AS  
  PROCEDURE LOAD_DW_CURRENCY
   AS
     BEGIN
     MERGE INTO DW_DATA.t_dw_currencies A
     USING ( SELECT currency_code, currency_name, direct_exchange_rate, reverse_exchange_rate
             FROM DW_CL.t_cl_currencies) B
             ON (a.currency_code=b.currency_code)
             WHEN MATCHED THEN 
                UPDATE SET a.direct_exchange_rate=b.direct_exchange_rate
             WHEN NOT MATCHED THEN 
                INSERT (a.currency_id, a.currency_code, a.currency_name, a.direct_exchange_rate, a.reverse_exchange_rate)
                VALUES (SEQ_CURRENCIES.NEXTVAL, b.currency_code, b.currency_name, b.direct_exchange_rate, b.reverse_exchange_rate);
     COMMIT;
   END LOAD_DW_CURRENCY;
   
   PROCEDURE LOAD_DW_DOERS_with_to_refcursor_func
   AS
     BEGIN 
     DECLARE 
       cursor_id NUMBER (25);
       cur_count NUMBER (38);
       quary_cur VARCHAR2(2000);
       TYPE ref_crsr IS REF CURSOR;
       ref_cursor ref_crsr;
       TYPE type_rec IS RECORD
	   (  doer_id  INT
	    , vehicle_registration_plate VARCHAR2(8)
        , driving_category  VARCHAR2(20)
	   );
       one_record type_rec;
       
     BEGIN 
     quary_cur:= 'SELECT doer_id, vehicle_registration_plate, driving_category FROM
                        (SELECT stage.doer_id AS doer_id, 
                         source.vehicle_registration_plate AS vehicle_registration_plate,
                         source.driving_category AS driving_category
                  FROM dw_cl.t_cl_doers source
                  LEFT JOIN dw_data.t_dw_doers stage
                  ON (source.doer_id=stage.doer_id))';
                  
      cursor_id:=DBMS_SQL.open_cursor;
      
      DBMS_SQL.PARSE(cursor_id, quary_cur, DBMS_SQL.NATIVE);
      
      cur_count:= DBMS_SQL.EXECUTE(cursor_id);
      
      ref_cursor:= DBMS_SQL.TO_REFCURSOR(cursor_id);
      
      LOOP
      FETCH ref_cursor INTO one_record;
      EXIT WHEN ref_cursor%NOTFOUND;
      IF (one_record.doer_id IS NULL) THEN
                INSERT INTO dw_data.t_dw_doers(doer_id, 
                                               vehicle_registration_plate, 
                                               driving_category)
                VALUES (SEQ_DOERS.NEXTVAL,
                        one_record.vehicle_registration_plate, 
                        one_record.driving_category
                        ); 
      END IF;
      END LOOP;
    COMMIT;
    END;
   END LOAD_DW_DOERS_with_to_refcursor_func;
   
    PROCEDURE LOAD_DW_DOERS_with_to_cursor_number_func
   AS
  BEGIN 
DECLARE
  l_rc_var1 SYS_REFCURSOR;
  l_n_cursor_id    NUMBER;
  l_n_rowcount     NUMBER;
  l_n_column_count NUMBER;
  l_vc_doer_id                       VARCHAR2(3); 
  l_vc_vehicle_registration_plate    VARCHAR2(8);
  l_vc_driving_category              VARCHAR2(20);

  l_ntt_desc_tab dbms_sql.desc_tab;
  
BEGIN
  OPEN l_rc_var1 FOR
  'SELECT doer_id, vehicle_registration_plate, driving_category 
   FROM DW_CL.t_cl_doers';
  l_n_cursor_id:= DBMS_SQL.to_cursor_number(l_rc_var1);
  dbms_sql.describe_columns(l_n_cursor_id,l_n_column_count,l_ntt_desc_tab);
  FOR loop_col IN 1..l_n_column_count
  LOOP
    dbms_sql.define_column(l_n_cursor_id,loop_col,
    CASE l_ntt_desc_tab(loop_col).col_name
    WHEN 'DOER_ID' THEN
      l_vc_doer_id
    WHEN 'VEHICLE_REGISTRATION_PLATE' THEN
      l_vc_vehicle_registration_plate
    WHEN 'DRIVING_CATEGORY' THEN
      l_vc_driving_category
    END, 50);
  END LOOP loop_col;
  LOOP
    l_n_rowcount:=dbms_sql.fetch_rows(l_n_cursor_id);
    EXIT
  WHEN l_n_rowcount=0;
    FOR loop_col IN 1..l_n_column_count
    LOOP
      CASE l_ntt_desc_tab(loop_col).col_name
      WHEN 'DOER_ID' THEN
        dbms_sql.column_value(l_n_cursor_id,loop_col,l_vc_doer_id);
      WHEN 'VEHICLE_REGISTRATION_PLATE' THEN
        dbms_sql.column_value(l_n_cursor_id,loop_col,l_vc_vehicle_registration_plate);
      WHEN 'DRIVING_CATEGORY' THEN
        dbms_sql.column_value(l_n_cursor_id,loop_col,l_vc_driving_category);
      END CASE;
    END LOOP loop_col;
    IF(l_vc_doer_id IS NOT NULL) THEN
    INSERT INTO dw_data.t_dw_doers(doer_id, 
                                    vehicle_registration_plate, 
                                    driving_category)
                VALUES (l_vc_doer_id, 
                        l_vc_vehicle_registration_plate, 
                        l_vc_driving_category); 
        END IF;
      END LOOP;
    COMMIT;
    END;

   END LOAD_DW_DOERS_with_to_cursor_number_func;
   
END pkg_independent_etl_dw_currencies;


exec pkg_independent_etl_dw_currencies.LOAD_DW_CURRENCY; 
exec pkg_independent_etl_dw_currencies.LOAD_DW_DOERS_with_to_refcursor_func;
exec pkg_independent_etl_dw_currencies.LOAD_DW_DOERS_with_to_cursor_number_func;
select * from t_dw_currencies;
select * from t_dw_doers;


 
