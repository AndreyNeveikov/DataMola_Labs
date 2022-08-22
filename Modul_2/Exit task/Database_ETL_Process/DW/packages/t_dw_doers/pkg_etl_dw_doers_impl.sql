alter session set current_schema=DW_CL;
GRANT SELECT ON DW_CL.t_cl_doers TO DW_DATA;

alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_doers
AS  
  PROCEDURE LOAD_DW_DOERS
   AS
     BEGIN
     MERGE INTO DW_DATA.t_dw_doers A
     USING ( SELECT doer_id, vehicle_registration_plate, driving_category
             FROM DW_CL.t_cl_doers) B
             ON (a.vehicle_registration_plate=b.vehicle_registration_plate)
             WHEN MATCHED THEN 
                UPDATE SET a.driving_category=b.driving_category
             WHEN NOT MATCHED THEN 
                INSERT (a.doer_id, a.vehicle_registration_plate, a.driving_category)
                VALUES (b.doer_id, b.vehicle_registration_plate, b.driving_category);
     COMMIT;
   END LOAD_DW_DOERS;
END pkg_etl_dw_doers;

alter session set current_schema=DW_DATA;
exec pkg_etl_dw_doers.LOAD_DW_DOERS;
select * from t_dw_doers;

commit;