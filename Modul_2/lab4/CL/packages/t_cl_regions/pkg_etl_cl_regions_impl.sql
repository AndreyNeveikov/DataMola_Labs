alter session set current_schema=SA_ORDERS;
GRANT SELECT ON SA_ORDERS.t_sa_regions TO DW_CL; 

alter session set current_schema=DW_CL;
CREATE OR REPLACE PACKAGE body pkg_etl_cl_regions
AS  
  PROCEDURE LOAD_CLEAN_REGIONS
   AS   
      CURSOR curs_cl_regions
      IS
         SELECT DISTINCT 
                    region_id
                  , region_name
                  , country
                  , city
                  , use_language
                  , VAT_rate 
                  , timezone
           FROM SA_ORDERS.t_sa_regions
           WHERE region_id IS NOT NULL 
           AND region_name IS NOT NULL
           AND country IS NOT NULL
           AND city IS NOT NULL
           AND use_language IS NOT NULL
           AND VAT_rate IS NOT NULL
           AND timezone IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.t_cl_regions';
      FOR i IN curs_cl_regions LOOP
         INSERT INTO DW_CL.t_cl_regions( 
                      region_id
                    , region_name
                    , country
                    , city
                    , use_language
                    , VAT_rate 
                    , timezone)
              VALUES ( i.region_id
                     , i.region_name
                     , i.country
                     , i.city
                     , i.use_language
                     , i.VAT_rate 
                     , i.timezone);

         EXIT WHEN curs_cl_regions%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_REGIONS;
END pkg_etl_cl_regions;


alter session set current_schema=DW_CL;
exec pkg_etl_cl_regions.LOAD_CLEAN_REGIONS;
select * from t_cl_regions;

commit;

