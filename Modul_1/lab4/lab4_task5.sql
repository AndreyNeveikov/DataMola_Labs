/*Task_5*/
-- Step 1
CREATE TABLE employees AS 
    SELECT * 
      FROM scott.emp;
      
-- Step 2
CREATE INDEX idx_emp01 ON employees 
      ( empno, ename, job );
      
-- Step 3
SET autotrace ON;
SELECT /*+INDEX_SS(emp idx_emp01)*/ emp.* FROM employees emp where ename = 'SCOTT';

SET autotrace ON;
SELECT /*+FULL*/ emp.* FROM employees emp WHERE ename = 'SCOTT';

---------------------------------------
select blocks, segment_name from user_segments;
---------------------------------------
select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from employees ;
---------------------------------------
SET autotrace ON;
SELECT COUNT( * ) 
   FROM employees ;