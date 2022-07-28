--drop table interval_example

create table interval_example
    ( interval_key_column date NOT NULL,
data varchar2(30)
    )
partition by range(interval_key_column)
interval (numtoyminterval(1,'month'))
    (partition p0 values less than
(to_date('01-01-1900','dd-mm-yyyy'))
)
/

 insert into interval_example
    ( interval_key_column, data )
 values
    ( to_date( '31-12-1800',
    'dd-mm-yyyy' ),
    'application data...' );
    
 insert into interval_example
    ( interval_key_column, data )
 values
    ( to_date( '01-01-2000',
    'dd-mm-yyyy' ),
    'application data...' );
    
 insert into interval_example
    ( interval_key_column, data )
 values
    ( to_date( '05-01-2000',
    'dd-mm-yyyy' ),
    'application data...' );
    
    
 insert into interval_example
    ( interval_key_column, data )
 values
    ( to_date( '10-02-2000',
    'dd-mm-yyyy' ),
    'application data...' );
 
 select a.partition_name, a.tablespace_name, a.high_value,
    decode( a.interval, 'YES', b.interval ) interval
 from user_tab_partitions a, user_part_tables b
 where a.table_name = 'INTERVAL_EXAMPLE'
 and a.table_name = b.table_name
 order by a.partition_position;
 
 select to_char(interval_key_column,'dd-mm-yyyy')
 from interval_example partition (SYS_P899);
 --------------------------------------------------------
 -- ADD
 ALTER TABLE range_example
      ADD PARTITION p1 VALUES LESS THAN
(MAXVALUE);
 --------------------------------------------------------
 -- DROP
 ALTER TABLE interval_example
      DROP PARTITION sys_p885;
      
---------------------------------------------------------
insert into interval_example
    ( interval_key_column, data )
 values
    ( to_date( '10-06-2000',
    'dd-mm-yyyy' ),
    'application data...' );
    
-- MERGE 
ALTER TABLE interval_example
      MERGE PARTITIONS SYS_P900, SYS_P901 INTO PARTITION SYS_P901;
--------------------------------------------------------
-- MOVE
ALTER TABLE interval_example MOVE PARTITION SYS_P899 TABLESPACE ts_some_stuff;

SELECT partition_name, tablespace_name FROM ALL_TAB_PARTITIONS;
--------------------------------------------------------
-- SPLIT
 ALTER TABLE interval_example SPLIT PARTITION p0 INTO 
  (PARTITION p0 VALUES LESS THAN
    (to_date('01/01/1700','dd/mm/yyyy')),
   PARTITION ptest);

select a.partition_name, a.tablespace_name, a.high_value,
    decode( a.interval, 'YES', b.interval ) interval
 from user_tab_partitions a, user_part_tables b
 where a.table_name = 'INTERVAL_EXAMPLE'
 and a.table_name = b.table_name
 order by a.partition_position;
 --------------------------------------------------------
 -- TRUNCATE
 
ALTER TABLE interval_example TRUNCATE PARTITION ptest;