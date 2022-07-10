/*Prerequisites*/
create tablespace tbs_lab datafile 'db_lab_001.dat' 
size 5M autoextend ON next 5M MAXSIZE 100M;

create user ANeveykov identified by 123456 default tablespace tbs_lab; 

grant connect to ANeveykov; 
grant resource to ANeveykov; 
grant select on scott.dept to ANeveykov; 
grant select on scott.emp to ANeveykov; 

/*Task_1*/
-- Step 1
create table t 
  ( a int, 
    b varchar2(4000) default rpad('*',4000,'*'), 
    c varchar2(3000) default rpad('*',3000,'*') 
   ) 
   
/*
RPAD вставка с дозаполнение справа. 
Общий формат этой функции:
RPAD(string, length_to_make_string, what_to_add_to_right_of_string)

SQL> SELECT RPAD( 'Буквы' , 20, '.' ) ОТ двойного;
RPAD( 'БУКВЫ' ,20,'.')
--------------------
Буквы.............
*/


-- Step 2
insert into t (a) values ( 1); 
insert into t (a) values ( 2); 
insert into t (a) values ( 3); 
commit; 

delete from t where a = 2 ; 
commit; 

insert into t (a) values ( 4); 
commit; 

-- Step 3
select a from t;

/*Clean up (drop table)*/  
drop table t; 


/*Task_2*/
-- Step 1
Create table t ( x int primary key, y clob, z blob )  

-- Step 2
select segment_name, segment_type from user_segments; 

-- Step 3
Create table t 
    ( x int primary key, 
      y clob, 
      z blob ) 
SEGMENT CREATION IMMEDIATE /*Спросить на паре*/

-- Step 4
select segment_name, segment_type from user_segments; 
/*  segment_name Название, если есть, сегмента
    segment_type Тип сегмента: INDEX PARTITION, TABLE PARTITION,
TABLE, CLUSTER, INDEX, ROLLBACK, DEFERRED ROLLBACK,
TEMPORARY, CACHE, LOBSEGMENTиLOBINDEX*/

-- Step 5
SELECT DBMS_METADATA.GET_DDL('TABLE','T') FROM dual 
/*
Предоставляет возможность извлекать метаданные
из словаря базы данных в виде XML или создания
DDL и отправлять XML для повторного создания 
объекта.DBMS_METADATA*/


/*Task_3*/
-- Step 1
CREATE TABLE emp AS 
SELECT 
  object_id empno 
, object_name ename 
, created hiredate 
, owner job 
FROM 
  all_objects

alter table emp add constraint emp_pk primary key(empno)

begin 
  dbms_stats.gather_table_stats( user, 'EMP', cascade=>true ); 
end; 

-- Step 2
CREATE TABLE heap_addresses 
  ( 
    empno REFERENCES emp(empno) ON DELETE CASCADE 
  , addr_type VARCHAR2(10) 
  , street    VARCHAR2(20) 
  , city      VARCHAR2(20) 
  , state     VARCHAR2(2) 
  , zip       NUMBER 
  , PRIMARY KEY (empno,addr_type) 
  ) 
  
-- Step 3
CREATE TABLE iot_addresses 
  ( 
    empno REFERENCES emp(empno) ON DELETE CASCADE 
  , addr_type VARCHAR2(10) 
  , street    VARCHAR2(20) 
  , city      VARCHAR2(20) 
  , state     VARCHAR2(2) 
  , zip       NUMBER 
  , PRIMARY KEY (empno,addr_type) 
  ) 
  ORGANIZATION INDEX

-- Step 4
INSERT INTO heap_addresses 
SELECT empno, 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 
   
INSERT INTO iot_addresses 
SELECT empno , 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 
-- 
INSERT INTO heap_addresses 
SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 
   
INSERT INTO iot_addresses 
SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 
-- 
INSERT INTO heap_addresses 
SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 
   
INSERT INTO iot_addresses 
SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 
-- 
INSERT INTO heap_addresses 
SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 
   
INSERT INTO iot_addresses 
SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 
 
Commit;

-- Step 5
exec dbms_stats.gather_table_stats(ANeveykov, 'HEAP_ADDRESSES' ); 
exec dbms_stats.gather_table_stats(ANeveykov, 'IOT_ADDRESSES' ); 

-- Step 6
SELECT * 
   FROM emp , 
        heap_addresses 
  WHERE emp.empno = heap_addresses.empno 
  AND emp.empno   = 42;


SELECT * 
   FROM emp , 
        iot_addresses 
  WHERE emp.empno = iot_addresses.empno 
  AND emp.empno   = 42;
  
-- Step 7
drop table iot_addresses; 
drop table heap_addresses; 
drop table emp; 


/*Task_4*/
-- Step 1
CREATE cluster emp_dept_cluster( deptno NUMBER( 2 ) ) 
    SIZE 1024  
    STORAGE( INITIAL 100K NEXT 50K ); 
    
-- Step 2
CREATE INDEX idxcl_emp_dept on cluster emp_dept_cluster;

-- Step 3
CREATE TABLE dept 
  ( 
    deptno NUMBER( 2 ) PRIMARY KEY 
  , dname  VARCHAR2( 14 ) 
  , loc    VARCHAR2( 13 ) 
  ) 
  cluster emp_dept_cluster ( deptno ) ; 
  
 CREATE TABLE emp 
  ( 
    empno NUMBER PRIMARY KEY 
  , ename VARCHAR2( 10 ) 
  , job   VARCHAR2( 9 ) 
  , mgr   NUMBER 
  , hiredate DATE 
  , sal    NUMBER 
  , comm   NUMBER 
  , deptno NUMBER( 2 ) REFERENCES dept( deptno ) 
  ) 
  cluster emp_dept_cluster ( deptno ) ;

-- Step 4
INSERT INTO dept( deptno , dname , loc) 
SELECT deptno , dname , loc 
   FROM scott.dept; 
    
commit; 
 
 INSERT INTO emp ( empno, ename, job, mgr, hiredate, sal, comm, deptno ) 
 SELECT rownum, ename, job, mgr, hiredate, sal, comm, deptno 
   FROM scott.emp 
       
commit; 

-- Step 5
SELECT * 
   FROM 
  ( 
     SELECT dept_blk, emp_blk, CASE WHEN dept_blk <> emp_blk THEN '*' END flag, deptno 
       FROM 
      ( 
         SELECT dbms_rowid.rowid_block_number( dept.rowid ) dept_blk, dbms_rowid.rowid_block_number( emp.rowid ) emp_blk, dept.deptno 
           FROM emp , dept 
          WHERE emp.deptno = dept.deptno 
      ) 
  ) 
ORDER BY deptno

-- Step 6
drop table emp;
drop table dept;
drop cluster emp_dept_cluster; 