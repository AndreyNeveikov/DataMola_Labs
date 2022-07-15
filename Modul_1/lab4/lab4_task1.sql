/*Task_1*/
-- Step 1
CREATE TABLE t2 AS 
SELECT TRUNC( rownum / 100 ) id, rpad( rownum,100 ) t_pad 
   FROM dual 
CONNECT BY rownum < 100000; 

-- Step 2
CREATE INDEX t2_idx1 ON t2 
( id );

-- Step 3
-- Block count: 
select blocks from user_segments where segment_name = 'T2';

-- Used Block Count:  
select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from t2 ;

-- Explain Plan: 
SET autotrace ON;

SELECT COUNT( * ) 
   FROM t2 ;
   
-- Step 4
DELETE FROM t2;

-- Step 5
-- Block count: 
select blocks from user_segments where segment_name = 'T2';

-- Used Block Count:  
select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from t2 ;

-- Explain Plan: 
SET autotrace ON;

SELECT COUNT( * ) 
   FROM t2 ;
   
-- Step 6
INSERT INTO t2 
  ( ID, T_PAD ) 
  VALUES 
  (  1,'1' ); 
 
COMMIT;

-- Step 7
-- Block count: 
select blocks from user_segments where segment_name = 'T2';

-- Used Block Count:  
select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from t2 ;

-- Explain Plan: 
SET autotrace ON;

SELECT COUNT( * ) 
   FROM t2 ;
   
-- Step 8
TRUNCATE TABLE t2;

-- Step 9
-- Block count: 
select blocks from user_segments where segment_name = 'T2';

-- Used Block Count:  
select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from t2 ;

-- Explain Plan: 
SET autotrace ON;

SELECT COUNT( * ) 
   FROM t2 ;