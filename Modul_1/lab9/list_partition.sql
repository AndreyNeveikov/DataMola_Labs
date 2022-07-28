/*List partition*/
create table list_example
    ( state_cd varchar2(2),
data varchar2(20)
    )
partition by list(state_cd)
    ( partition part_1 values ( 'ME', 'NH', 'VT', 'MA' ),
partition part_2 values ( 'CT', 'RI', 'NY' )
    )
/

insert into list_example values ( 'CT', 'data' );
insert into list_example values ( 'MA', 'data' );
insert into list_example values ( 'ME', 'data' );
insert into list_example values ( 'NH', 'data' );
insert into list_example values ( 'NY', 'data' );
insert into list_example values ( 'RI', 'data' );
insert into list_example values ( 'VT', 'data' );

select a.partition_name, a.tablespace_name, a.high_value,
    decode( a.interval, 'YES', b.interval ) interval
 from user_tab_partitions a, user_part_tables b
 where a.table_name = 'LIST_EXAMPLE'
 and a.table_name = b.table_name
 order by a.partition_position;
 ----------------------------------------------------------
 -- ADD
 alter table list_example
 add partition part_3 values ( DEFAULT );
 
 insert into list_example values ( 'VA', 'data' );
 ----------------------------------------------------------
 -- DROP
 ALTER TABLE list_example
      DROP PARTITION part_3;
      
   alter table list_example
 add partition part_3 values ( 'LA', 'TX' );
 
  alter table list_example
 add partition part_4 values ( 'AB', 'BC', 'CD' );
 
 -----------------------------------------------------------
 -- MERGE 
ALTER TABLE list_example
      MERGE PARTITIONS part_3, part_4 INTO PARTITION part_3;
      
select a.partition_name, a.tablespace_name, a.high_value,
    decode( a.interval, 'YES', b.interval ) interval
 from user_tab_partitions a, user_part_tables b
 where a.table_name = 'LIST_EXAMPLE'
 and a.table_name = b.table_name
 order by a.partition_position;
 ----------------------------------------------------------
 -- MOVE
 ALTER TABLE list_example MOVE PARTITION part_3 TABLESPACE ts_some_stuff;

SELECT partition_name, tablespace_name FROM ALL_TAB_PARTITIONS;
-----------------------------------------------------------
-- SPLIT
 ALTER TABLE list_example SPLIT PARTITION part_3 INTO 
  (PARTITION part_3 values ( 'LA', 'TX' ),
   PARTITION part_4);
   
select a.partition_name, a.tablespace_name, a.high_value,
    decode( a.interval, 'YES', b.interval ) interval
 from user_tab_partitions a, user_part_tables b
 where a.table_name = 'LIST_EXAMPLE'
 and a.table_name = b.table_name
 order by a.partition_position;
 -------------------------------------------------------------
 -- TRUNCATE 
 insert into list_example values ( 'AB', 'data' );
 ALTER TABLE list_example TRUNCATE PARTITION part_4;
 
 select * from list_example;