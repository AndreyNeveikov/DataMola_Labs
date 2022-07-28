CREATE TABLE hash_example
    ( hash_key_column date,
    data varchar2(20)
    )
PARTITION BY HASH (hash_key_column)
    ( partition part_1 tablespace ts_references_data_01,
    partition part_2 tablespace ts_some_stuff
    )
/

insert into hash_example
(hash_key_column, data)
values
(to_date('25-06-2014'),
'application data ...');

insert into hash_example
(hash_key_column, data)
values
(to_date('27-02-2015'),
'application data ...');

select a.partition_name, a.tablespace_name, a.high_value,
    decode( a.interval, 'YES', b.interval ) interval
 from user_tab_partitions a, user_part_tables b
 where a.table_name = 'HASH_EXAMPLE'
 and a.table_name = b.table_name
 order by a.partition_position;
 --------------------------------------------------------
 -- ADD
 ALTER TABLE hash_example
      ADD PARTITION part_3 tablespace ts_references_ext_data_01;
---------------------------------------------------------
-- COALESCE
ALTER TABLE hash_example
     COALESCE PARTITION;
---------------------------------------------------------
-- MOVE
ALTER TABLE hash_example MOVE PARTITION part_1 TABLESPACE ts_some_stuff;
---------------------------------------------------------
-- TRUNCATE
ALTER TABLE hash_example TRUNCATE PARTITION part_2;