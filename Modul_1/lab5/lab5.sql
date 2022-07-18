/*Task_1*/
-- Step 1
set autotrace off 
set autotrace on 
set autotrace traceonly 
 
set autotrace on explain 
set autotrace on statistics 
set autotrace on explain statistics 
 
set autotrace traceonly explain 
set autotrace traceonly statistics 
set autotrace traceonly explain statistics 
 
set autotrace off explain 
set autotrace off statistics 
set autotrace off explain statistics 


/*Task_2*/
-- Nested Loops
explain plan for
SELECT  * 
    FROM scott.emp e, scott.dept d  
    WHERE e.deptno = d.deptno 
      AND d.deptno   = 10;
    select * from table(dbms_xplan.display );
      
/*Task_3*/
-- Sort-Merge
explain plan for
select /*+ USE_MERGE */ empno, ename, dname, loc 
       from scott.dept, scott.emp 
      where emp.deptno = dept.deptno;  
    select * from table(dbms_xplan.display );
      
/*Task_4*/
-- Hash Joins 
explain plan for
select /*+ USE_HASH (emp dept)*/ empno, ename, dname, loc 
       from scott.dept, scott.emp 
      where emp.deptno = dept.deptno; 
    select * from table(dbms_xplan.display );
      
/*Task_5*/
-- Cartesian Joins
explain plan for
select /*+ USE_HASH */ empno, ename, dname, loc 
       from scott.dept, scott.emp; 
    select * from table(dbms_xplan.display );
      
/*Task_6*/
-- Outer Joins
 
-- Left outer join
select empno, ename, dname, loc 
       from scott.dept
       left outer join  scott.emp 
 on (scott.emp.deptno = scott.dept.deptno); 
 
-- Right outer join
select empno, ename, dname, loc 
       from scott.dept
       right outer join  scott.emp 
 on (scott.dept.deptno = scott.emp.deptno); 
 
/*Task_7*/
-- Full outer join
select empno, ename, dname, loc 
       from scott.dept
       full outer join  scott.emp 
 on (scott.dept.deptno = scott.emp.deptno);

/*Task_8*/
-- Semi Joins
explain plan for
SELECT DName 
       FROM SCOTT.dept dept 
      WHERE deptno IN 
            ( SELECT deptno FROM scott.emp ); 
    select * from table(dbms_xplan.display );
      
/*Task_9*/
-- Anti Joins
explain plan for
SELECT DName 
       FROM SCOTT.dept dept 
      WHERE deptno NOT IN 
            ( SELECT deptno FROM scott.emp ); 
    select * from table(dbms_xplan.display );
      
/*Task_9*/
explain plan for
SELECT  * 
    FROM scott.emp e, scott.dept d  
    WHERE e.deptno = d.deptno 
      AND d.deptno   = 10;
    select * from table(dbms_xplan.display );