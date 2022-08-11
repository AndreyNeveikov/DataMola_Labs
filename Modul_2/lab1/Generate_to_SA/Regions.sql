alter session set current_schema=SA_ORDERS;
SELECT
    region_id
FROM
    t_sa_regions;
    
commit;
    
    
alter session set current_schema=SA_ORDERS;
drop table t_sa_regions;

alter session set current_schema=SA_ORDERS;
Create table t_sa_regions (
region_id                     INT              not null,
region_name                   VARCHAR2(15)     not null,
country                       VARCHAR2(20)     not null,
city                          VARCHAR2(20)     not null,
use_language                  VARCHAR2(15)     not null,
VAT_rate                      FLOAT            not null,
timezone                      VARCHAR2(10)     not null
);

--
alter session set current_schema=SA_ORDERS;
INSERT INTO t_sa_regions
    WITH create_region AS (
        SELECT
            1      AS id
          , 'European Union'  AS a
          , 'EN'  AS b
        FROM
            dual
        UNION ALL
        SELECT
            2      AS id
          , 'C.I.S.'  AS a
          , 'RU'  AS b
        FROM
            dual
        UNION ALL
        SELECT
            3      AS id
          , 'Far East'  AS a
          , 'CHI'
        FROM
            dual
        UNION ALL
        SELECT
            4      AS id
          , 'America'  AS a
          , 'EN'
        FROM
            dual
        UNION ALL
        SELECT
            5      AS id
          , 'Near East'  AS a
          , 'ARA'  AS b
        FROM
            dual
    ), create_country AS (
        SELECT
            1         AS id
          , 'Austria'  AS a
          , 20.0  AS b
          , '+1' AS c
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'Czech Republic'  AS a
          , 21.0  AS b
          , '+1' AS c
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 'Poland'  AS a
          , 23.0  AS b
          , '+1' AS c
        FROM
            dual
        UNION ALL
        SELECT
            4        AS id
          , 'Russia'  AS a
          , 20.0  AS b
          , '+3' AS c
        FROM
            dual
        UNION ALL
        SELECT
            5        AS id
          , 'Kazakhstan'  AS a
          , 12.0  AS b
          , '+5' AS c
        FROM
            dual
        UNION ALL
        SELECT
            6        AS id
          , 'China'  AS a
          , 17.0  AS b
          , '+8' AS c
        FROM
            dual
        UNION ALL
        SELECT
            7        AS id
          , 'USA'  AS a
          , 0.0  AS b
          , '-5' AS c
        FROM
            dual
        UNION ALL
        SELECT
            8        AS id
          , 'Turkey'  AS a
          , 18.0  AS b
          , '+3' AS c
        FROM
            dual
    ), create_city AS (
        SELECT
            1         AS id
          , 'Vienna'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2        AS id
          , 'Linz'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3          AS id
          , 'Prague'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4        AS id
          , 'Brno'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5        AS id
          , 'Ostava'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6        AS id
          , 'Krakow'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7        AS id
          , 'Bialystok'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8        AS id
          , 'Moscow'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9        AS id
          , 'Nur-Sultan'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10        AS id
          , 'Beijing'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            11        AS id
          , 'New York'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            12        AS id
          , 'Istanbul'  AS a
        FROM
            dual
    ), cte_gen AS (
        SELECT
            a.*
          , trunc(dbms_random.value(1, 5))           AS id_region
          , ( CASE
                WHEN id_region = 1 THEN trunc(dbms_random.value(1, 3))
                WHEN id_region = 2 THEN trunc(dbms_random.value(4, 5))
                WHEN id_region = 3 THEN 6
                WHEN id_region = 4 THEN 7
                WHEN id_region = 5 THEN 8
        END ) id_country
          , ( CASE
                WHEN id_country = 1 THEN trunc(dbms_random.value(1, 2))
                WHEN id_country = 2 THEN trunc(dbms_random.value(3, 5))
                WHEN id_country = 3 THEN trunc(dbms_random.value(6, 7))
                WHEN id_country = 4 THEN 8
                WHEN id_country = 5 THEN 9
                WHEN id_country = 6 THEN 10
                WHEN id_country = 7 THEN 11
                WHEN id_country = 8 THEN 12
        END ) id_city
        FROM
            (
                SELECT
                    ROWNUM rn
                FROM
                    dual
                CONNECT BY
                    level <= 100
            ) a
    )
    SELECT
        concat(concat(id_region, id_country), id_city) id_region
      , rg.a
      , cn.a
      , ct.a
      , rg.b
      , cn.b
      , cn.c
    FROM
        cte_gen  g
        LEFT OUTER JOIN create_region    rg ON g.id_region = rg.id
        LEFT OUTER JOIN create_country   cn ON g.id_country = cn.id
        LEFT OUTER JOIN create_city      ct ON g.id_city = ct.id;
   