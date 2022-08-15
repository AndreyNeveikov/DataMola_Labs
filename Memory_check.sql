SELECT * FROM RECYCLEBIN;
PURGE RECYCLEBIN;

SELECT * FROM DBA_TABLESPACES;

--------------------------------------------------------------------------------
SELECT * FROM V$RECOVERY_FILE_DEST;
SELECT * FROM V$RECOVERY_AREA_USAGE;

--------------------------------------------------------------------------------
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


select sum(round(df.bytes/1024/1024)) totalSizeMB
from dba_data_files df
    left join (
        select file_id, sum(bytes) usedBytes
        from dba_extents
        group by file_id
    ) ext on df.file_id = ext.file_id
    left join (
        select file_id, sum(bytes) freeBytes
        from dba_free_space
        group by file_id
    ) free on df.file_id = free.file_id
order by df.tablespace_name, df.file_name;

--------------------------------------------------------------------------------
SELECT SUM (bytes) / 1024 / 1024 / 1024 AS GB FROM dba_data_files;
SELECT SUM (bytes)/1024/1024/1024 AS GB FROM dba_segments;

--------------------------------------------------------------------------------
select df.tablespace_name, df.file_name, round(df.bytes/1024/1024) totalSizeMB, nvl(round(usedBytes/1024/1024), 0) usedMB, 
nvl(round(freeBytes/1024/1024), 0) freeMB, nvl(round(freeBytes/df.bytes * 100), 0) freePerc, df.autoextensible
from dba_data_files df
    left join (
        select file_id, sum(bytes) usedBytes
        from dba_extents
        group by file_id
    ) ext on df.file_id = ext.file_id
    left join (
        select file_id, sum(bytes) freeBytes
        from dba_free_space
        group by file_id
    ) free on df.file_id = free.file_id
order by df.tablespace_name, df.file_name;
--------------------------------------------------------------------------------

select 
    'alter database '--||a.name
    ||' datafile '''||b.file_name||'''' ||
    ' resize '||greatest(trunc(bytes_full/.7)
    ,(bytes_total-bytes_free))||chr(10)||
    '--tablespace was '||trunc(bytes_full*100/bytes_total)||
    '% full now '||
    trunc(bytes_full*100/greatest(trunc(bytes_full/.7)
    ,(bytes_total-bytes_free)))||'%'
    from v$database a
    ,dba_data_files b
    ,(Select tablespace_name,sum(bytes) bytes_full
        From dba_extents
        Group by tablespace_name) c
    ,(Select tablespace_name,sum(bytes) bytes_total
        From dba_data_files
        Group by tablespace_name) d
    ,(SELECT a.TABLESPACE_NAME,a.FILE_ID, b.bytes bytes_free
        From (SELECT TABLESPACE_NAME
                    , FILE_ID
                    , max(BLOCK_ID) max_data_block_id
                FROM dba_extents
                GROUP BY TABLESPACE_NAME, FILE_ID
                ) a
        ,dba_free_space b
        where a.tablespace_name = b.tablespace_name
        and a.file_id = b.file_id
        and b.block_id > a.max_data_block_id) e
    Where b.tablespace_name = c.tablespace_name
    And b.tablespace_name = d.tablespace_name
    And bytes_full/bytes_total < .7
    And b.tablespace_name = e.tablespace_name
    And b.file_id = e.file_id;
--------------------------------------------------------------------------------
