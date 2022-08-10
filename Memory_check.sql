SELECT * FROM RECYCLEBIN;
PURGE RECYCLEBIN;

SELECT * FROM DBA_TABLESPACES;


SELECT * FROM V$RECOVERY_FILE_DEST;
SELECT * FROM V$RECOVERY_AREA_USAGE;


select * From DBA_TABLESPACE_USAGE_METRICS order by used_percent desc;

select tablespace_name,
       used_space used_blocks,
       (used_space*32768)/(1024*1024) used_mb,
       tablespace_size tablespace_blocks,
       (tablespace_size*32768)/(1024*1024) tablespace_mb,
       used_percent
from dba_tablespace_usage_metrics
order by used_percent desc;


SELECT df.tablespace_name "Tablespace",
  totalusedspace "Used MB",
  (df.totalspace - tu.totalusedspace) "Free MB",
  df.totalspace "Total MB",
  ROUND(100 * ( (df.totalspace - tu.totalusedspace)/ df.totalspace)) "% Free"
FROM
  (SELECT tablespace_name,
    ROUND(SUM(bytes) / 1048576) TotalSpace
  FROM dba_data_files
  GROUP BY tablespace_name
  ) df,
  (SELECT ROUND(SUM(bytes)/(1024*1024)) totalusedspace,
    tablespace_name
  FROM dba_segments
  GROUP BY tablespace_name
  ) tu
WHERE df.tablespace_name = tu.tablespace_name;