CREATE USER SB_MBackUp
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_orders_data_01;

GRANT UNLIMITED TABLESPACE TO SB_MBackUp;
--------------------------------------------------------------------------------


alter session set current_schema=u_dw_references;
select 
    * 
from 
    t_geo_objects tgo
    
    LEFT OUTER JOIN t_geo_types tgt ON tgo.geo_type_id = tgt.geo_type_id
    LEFT OUTER JOIN lc_cntr_group_systems lcgs ON tgo.geo_id = lcgs.geo_id
    LEFT OUTER JOIN lc_cntr_groups lcg ON tgo.geo_id = lcg.geo_id
    LEFT OUTER JOIN lc_cntr_sub_groups lcsg ON tgo.geo_id = lcsg.geo_id 
    LEFT OUTER JOIN lc_countries lc ON tgo.geo_id = lc.geo_id
    LEFT OUTER JOIN lc_geo_regions lgr ON tgo.geo_id = lgr.geo_id
    LEFT OUTER JOIN lc_geo_parts lgp ON tgo.geo_id = lgp.geo_id
    LEFT OUTER JOIN lc_geo_systems lgs ON tgo.geo_id = lgs.geo_id;
            

