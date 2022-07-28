/*Range partition*/
--DROP TABLE range_example;

 CREATE TABLE range_example
    ( range_key_column date NOT NULL,
 data varchar2(20)
    )
 PARTITION BY RANGE (range_key_column)
    ( PARTITION part_1 VALUES LESS THAN
    (to_date('01/01/2014','dd/mm/yyyy')),
 PARTITION part_2 VALUES LESS THAN
    (to_date('01/01/2015','dd/mm/yyyy'))
 );
 /
 
 insert into range_example
    ( range_key_column, data )
 values
    ( to_date( '15-дек-2013 00:00:00',
    'dd-mon-yyyy hh24:mi:ss' ),
    'application data...' );
    
 insert into range_example
    ( range_key_column, data )
 values
    ( to_date( '31-дек-2013 23:59:59',
    'dd-mon-yyyy hh24:mi:ss' ),
    'application data...' );
    
 insert into range_example
    ( range_key_column, data )
 values
    ( to_date( '1-янв-2014 00:00:00',
    'dd-mon-yyyy hh24:mi:ss' ),
    'application data...' );
    
 insert into range_example
    ( range_key_column, data )
 values
    ( to_date( '31-дек-2014 23:59:59',
    'dd-mon-yyyy hh24:mi:ss' ),
    'application data...' );
 
 select to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss')
 from range_example partition (part_1);
 
 select to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss')
 from range_example partition (part_2);
 
 ALTER TABLE range_example
      ADD PARTITION part_3 VALUES LESS THAN
    (to_date('01/01/2016','dd/mm/yyyy'));
    
 ALTER TABLE range_example
      ADD PARTITION part_4 VALUES LESS THAN
    (to_date('01/01/2017','dd/mm/yyyy'));
      
 insert into range_example
    ( range_key_column, data )
 values
    ( to_date( '31-дек-2015 23:59:59',
    'dd-mon-yyyy hh24:mi:ss' ),
    'application data...' );
    
select to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss')
 from range_example partition (part_4);
      
-------------------------------------------------------      
--ADD

 ALTER TABLE range_example
      ADD PARTITION part_5 VALUES LESS THAN
    (to_date('01/01/2020','dd/mm/yyyy'));
       
 insert into range_example
    ( range_key_column, data )
 values
    ( to_date( '31-дек-2019 23:59:59',
    'dd-mon-yyyy hh24:mi:ss' ),
    'application data...' );
    
select to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss')
 from range_example partition (part_3);
 
 -------------------------------------------------------
 -- DROP
 
  ALTER TABLE range_example
      DROP PARTITION part_5;
      
select to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss')
 from range_example partition;
 
 -------------------------------------------------------
 -- MERGE
 
  ALTER TABLE range_example
      MERGE PARTITIONS part_4, part_5 INTO PARTITION part_5;
--------------------------------------------------------

CREATE TABLESPACE ts_some_stuff
DATAFILE '/oracle/u02/oradata/ANeveykovdb/db_some_stuff_01.dat'
SIZE 10M reuse
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
 
 -- MOVE
 ALTER TABLE range_example MOVE PARTITION part_5 TABLESPACE ts_some_stuff;
 
 SELECT partition_name, tablespace_name FROM ALL_TAB_PARTITIONS;
 
 ---------------------------------------------------------
 -- SPLIT
 ALTER TABLE range_example SPLIT PARTITION part_3 INTO 
  (PARTITION part_3 VALUES LESS THAN
    (to_date('01/06/2015','dd/mm/yyyy')),
   PARTITION part_4);
   
 SELECT partition_name, tablespace_name FROM ALL_TAB_PARTITIONS;
   
---------------------------------------------------------------
 -- TRUNCATE
select to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss')
 from range_example partition (part_4);
 
ALTER TABLE range_example TRUNCATE PARTITION part_4;