/*reference partition*/
--DROP TABLE orders;
--DROP TABLE order_line_items;

create table orders
(
order# number primary key,
order_date date,
data varchar2(30)
)
enable row movement
PARTITION BY RANGE (order_date)
    (
PARTITION part_2014 VALUES LESS THAN (to_date('01-01-2015','dd-mm-yyyy')) ,
PARTITION part_2015 VALUES LESS THAN (to_date('01-01-2016','dd-mm-yyyy'))
    )
/

insert into orders
    values ( 1, to_date( '01-06-2014', 'dd-mm-yyyy' ), 'xxx' );
insert into orders
    values ( 2, to_date( '01-06-2015', 'dd-mm-yyyy' ), 'xxx' );
    
    
 create table order_line_items
(
 order# number,
 line# number,
 order_date date, -- manually copied from ORDERS!
 data varchar2(30),
constraint c1_pk primary key(order#,line#),
constraint c1_fk_p foreign key(order#) references orders
)
 enable row movement
 PARTITION BY RANGE (order_date)
(
PARTITION part_2014 VALUES LESS THAN (to_date('01-01-2015','dd-mm-yyyy')) ,
PARTITION part_2015 VALUES LESS THAN (to_date('01-01-2016','dd-mm-yyyy'))
)
/

insert into order_line_items values
    ( 1, 1, to_date( '01-06-2014', 'dd-mm-yyyy' ), 'yyy' );
insert into order_line_items values
    ( 2, 1, to_date('01-06-2015', 'dd-mm-yyyy' ), 'yyy' );
    
alter table order_line_items drop partition part_2014;
drop table order_line_items cascade constraints;
truncate table orders;

insert into orders values
( 1, to_date( '01-06-2014', 'dd-mm-yyyy' ), 'xxx' );
 insert into orders values
( 2, to_date( '01-06-2015', 'dd-mm-yyyy' ), 'xxx' );


create table order_line_items
(
order# number,
line# number,
data varchar2(30),
constraint c1_pk primary key(order#,line#),
constraint c1_fk_p foreign key(order#) references orders
)
enable row movement
partition by reference(c1_fk_p)
/

insert into order_line_items values ( 1, 1, 'zzz' );
insert into order_line_items values ( 2, 1, 'zzz' );

select table_name, partition_name
from user_tab_partitions
where table_name in ( 'ORDERS', 'ORDER_LINE_ITEMS' )
order by table_name, partition_name


-------------------------------------------------------
-- DROP
 alter table orders drop partition part_2014 update global indexes;
-------------------------------------------------------
-- ADD 
 alter table orders add partition
 part_2016 values less than
(to_date( '01-01-2017', 'dd-mm-yyyy' ));
-------------------------------------------------------
-- MOVE
alter table orders MOVE PARTITION part_2016 TABLESPACE ts_some_stuff;

SELECT partition_name, tablespace_name FROM ALL_TAB_PARTITIONS;

 -- TRUNCATE 
 ALTER TABLE orders TRUNCATE PARTITION part_2016;
 
SELECT partition_name, tablespace_name FROM ALL_TAB_PARTITIONS;