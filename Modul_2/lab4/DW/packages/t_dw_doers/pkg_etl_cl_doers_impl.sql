alter session set current_schema=SA_ORDERS;
GRANT SELECT ON SA_ORDERS.t_sa_doers TO DW_CL; 

alter session set current_schema=DW_CL;
CREATE OR REPLACE PACKAGE body pkg_etl_cl_doers
AS  
  PROCEDURE LOAD_CLEAN_DOERS
   AS   
      CURSOR curs_cl_doers
      IS
         SELECT DISTINCT 
                  vehicle_registration_plate
                , driving_category
           FROM SA_ORDERS.t_sa_doers
           WHERE vehicle_registration_plate IS NOT NULL 
           AND driving_category IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.t_cl_doers';
      FOR i IN curs_cl_doers LOOP
         INSERT INTO DW_CL.t_cl_doers( 
                         vehicle_registration_plate
                       , driving_category)
              VALUES ( i.vehicle_registration_plate
                     , i.driving_category);

         EXIT WHEN curs_cl_doers%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_DOERS;
END pkg_etl_cl_doers;


alter session set current_schema=DW_CL;
exec pkg_etl_cl_doers.LOAD_CLEAN_DOERS;
select * from t_cl_doers;

commit;

