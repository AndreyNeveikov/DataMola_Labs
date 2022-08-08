CREATE USER SB_MBackUp
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_orders_data_01;

GRANT UNLIMITED TABLESPACE TO SB_MBackUp;


--------------------------------------------------------------------------------

alter session set current_schema=u_dw_references;
select 
    *
from
    t_geo_object_links;
 
--------------------------------------------------------------------------------

alter session set current_schema=u_dw_references;
create table geo_data_structure AS 
SELECT 
    tgo.geo_id, tgo.geo_type_id, tgo.geo_code_id,
    tgt.geo_type_code, tgt.geo_type_desc,
    --lcgs.grp_system_id, lcgs.grp_system_code, lcgs.grp_system_desc, lcgs.localization_id,
    --lcg.group_id, lcg.group_code, lcg.group_desc,
    --lcsg.sub_group_id, lcsg.sub_group_code, lcsg.sub_group_desc,
    --lc.country_id, lc.country_code_a2, lc.country_code_a3, lc.country_desc,
    --lgr.region_id, lgr.region_code, lgr.region_desc,
    --lgp.part_id, lgp.part_code, lgp.part_desc,
    --lgs.geo_system_id, lgs.geo_system_code, lgs.geo_system_desc,
    tgol.parent_geo_id, tgol.child_geo_id, tgol.link_type_id                  
from 
    t_geo_objects tgo
    
    LEFT OUTER JOIN t_geo_types tgt ON tgo.geo_type_id = tgt.geo_type_id
    LEFT OUTER JOIN t_geo_object_links tgol ON tgo.geo_id = tgol.parent_geo_id
    LEFT OUTER JOIN lc_cntr_group_systems lcgs ON tgo.geo_id = lcgs.geo_id
    LEFT OUTER JOIN lc_cntr_groups lcg ON tgo.geo_id = lcg.geo_id
    LEFT OUTER JOIN lc_cntr_sub_groups lcsg ON tgo.geo_id = lcsg.geo_id 
    LEFT OUTER JOIN lc_countries lc ON tgo.geo_id = lc.geo_id
    LEFT OUTER JOIN lc_geo_regions lgr ON tgo.geo_id = lgr.geo_id
    LEFT OUTER JOIN lc_geo_parts lgp ON tgo.geo_id = lgp.geo_id
    LEFT OUTER JOIN lc_geo_systems lgs ON tgo.geo_id = lgs.geo_id;    
    
commit;

alter session set current_schema=u_dw_references;
SELECT
    geo_id, geo_type_id, geo_code_id,
    geo_type_code, geo_type_desc,
    --grp_system_id, grp_system_code, grp_system_desc, localization_id,
    --group_id, group_code, group_desc,
    --sub_group_id, sub_group_code, sub_group_desc,
    --country_id, country_code_a2, country_code_a3, country_desc,
    --region_id, region_code, region_desc,
    --part_id, part_code, part_desc,
    --geo_system_id, geo_system_code, geo_system_desc,
    parent_geo_id, child_geo_id, link_type_id
FROM
    geo_data_structure;
--------------------------------------------------------------------------------

alter session set current_schema=u_dw_references;
drop table geo_denormalized_data;

--------------------------------------------------------------------------------
alter session set current_schema=u_dw_references;
create table geo_denormalized_data AS 
SELECT
    LPAD(' ', 2 * lvl, ' ') || geo_obj_with_geo_links.geo_id AS geo_id,
    parent_geo_id,
    DECODE(( SELECT COUNT(*)
             FROM t_geo_object_links tgol
             WHERE tgol.parent_geo_id = geo_obj_with_geo_links.geo_id),
                0,
                NULL,
                    
                (SELECT COUNT(*)
                FROM t_geo_object_links tgol
                WHERE tgol.parent_geo_id = geo_obj_with_geo_links.geo_id
                )) AS child_amount,
    lvl,
    id_type,
    PATH                 
FROM (
    SELECT geo_id,
           parent_geo_id,
           LEVEL AS lvl,
           DECODE(LEVEL, 1, 'ROOT', 2, 'BRANCH(1)', 3, 'BRANCH(2)', 4, 'LEAF') AS id_type,
           SYS_CONNECT_BY_PATH(geo_id, '/') AS path,
           REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(geo_id, '/'), '/', 1, 1, NULL, 1) AS connect_geo_sys_id,
           REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(geo_id, '/'), '/', 1, 2, NULL, 1) AS connect_geo_part_id,
           REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(geo_id, '/'), '/', 1, 3, NULL, 1) AS connect_geo_reg_id,
           REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(geo_id, '/'), '/', 1, 4, NULL, 1) AS connect_geo_country_id
    FROM (
          SELECT *
          FROM t_geo_objects
          LEFT OUTER JOIN t_geo_object_links ON child_geo_id = geo_id
         )
    START WITH parent_geo_id IS NULL
    CONNECT BY PRIOR geo_id = parent_geo_id
    ORDER SIBLINGS BY geo_id
     )  geo_obj_with_geo_links
     
LEFT OUTER JOIN lc_geo_systems lgs ON lgs.geo_id = connect_geo_sys_id
LEFT OUTER JOIN lc_geo_parts   lgp ON lgp.geo_id = connect_geo_part_id
LEFT OUTER JOIN lc_geo_regions lgr ON lgr.geo_id = connect_geo_reg_id
LEFT OUTER JOIN lc_countries    lc ON lc.geo_id = connect_geo_country_id;
        
    
commit;
    
--------------------------------------------------------------------------------
alter session set current_schema=u_dw_references;
SELECT 
    *
FROM
    geo_denormalized_data;
