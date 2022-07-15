/*Task_3*/
-- Step 1
CREATE UNIQUE INDEX udx_t1 ON t1( t_pad ); 

-- Step 2
SELECT t1.*  FROM t1 where t1.t_pad = '1'; 