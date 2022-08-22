alter session set current_schema=DW_CL;
GRANT SELECT ON DW_CL.t_cl_regions TO DW_DATA;

alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_regions
AS  
  PROCEDURE LOAD_DW_REGIONS
   AS
     BEGIN
     MERGE INTO DW_DATA.t_dw_regions A
     USING ( SELECT region_id, region_name, country, city, use_language, VAT_rate, timezone
             FROM DW_CL.t_cl_regions) B
             ON (a.region_id = b.region_id)
             WHEN MATCHED THEN 
                UPDATE SET a.city = b.city
             WHEN NOT MATCHED THEN 
                INSERT (a.region_id, a.region_name, a.country, a.city, a.use_language, a.VAT_rate, a.timezone)
                VALUES (b.region_id, b.region_name, b.country, b.city, b.use_language, b.VAT_rate, b.timezone);
     COMMIT;
   END LOAD_DW_REGIONS;
END pkg_etl_dw_regions;

alter session set current_schema=DW_DATA;
exec pkg_etl_dw_regions.LOAD_DW_REGIONS;
select * from t_dw_regions;

commit;