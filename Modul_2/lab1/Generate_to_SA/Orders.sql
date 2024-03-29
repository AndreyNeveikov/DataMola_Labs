alter session set current_schema=SA_ORDERS;
SELECT
    *
FROM
    t_sa_orders;
    
commit;
    
    
alter session set current_schema=SA_ORDERS;
drop table t_sa_orders;

alter session set current_schema=SA_ORDERS;
Create table t_sa_orders (
region_id                     INT              not null,
employee_id                   INT              not null,
client_id                     INT              not null,
product_name                  VARCHAR2(15)     not null,
order_price                   FLOAT            not null,
order_status                  VARCHAR2(10)     not null,
order_date                    DATE             not null,
receiving_date                DATE             not null
);

--
alter session set current_schema=SA_ORDERS;
INSERT INTO t_sa_orders
    WITH create_product_name AS (
        SELECT
            1      AS id
          , 'TV set'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2      AS id
          , 'Laptop'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3      AS id
          , 'Dishwasher'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4      AS id
          , 'Camera'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5      AS id
          , 'Deep-fryer'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6      AS id
          , 'Computer'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7      AS id
          , 'Washing machine'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8      AS id
          , 'Frige'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9      AS id
          , 'Air-conditioner'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10      AS id
          , 'Hotplate'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            11      AS id
          , 'Extractor'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            12      AS id
          , 'Sofa'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            13      AS id
          , 'Bookcase'  AS a
        FROM
            dual
    ),  create_order_status AS (
        SELECT
            1         AS id
          , 'Accepted'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'Delivered'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 'In process'  AS a
        FROM
            dual
    ), create_region_id AS (
        SELECT
            1         AS id
          , trunc(dbms_random.value(111, 112))  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , trunc(dbms_random.value(123, 125))  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , trunc(dbms_random.value(136, 137))  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4          AS id
          , 248  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5        AS id
          , 259  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6        AS id
          , 3610  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7          AS id
          , 4711  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8        AS id
          , 5812  AS a
        FROM
            dual    
    ), create_order_date AS (
        SELECT 
        1 as id,
        TO_DATE(TRUNC(DBMS_RANDOM.VALUE(
            TO_CHAR(TO_DATE('01-01-2020','dd-mm-yyyy'),'J'),
             TO_CHAR(TO_DATE('01-01-2022','dd-mm-yyyy'),'J'))),'J') as a
        FROM DUAL
        CONNECT BY level <= 1000
    ), cte_gen AS (
        SELECT
            a.*
          , trunc(dbms_random.value(1, 9))           AS id_region
          , trunc(dbms_random.value(8, 150))         AS id_emloyees
          , trunc(dbms_random.value(1, 13))          AS id_pn
          , trunc(dbms_random.value(100, 600))       AS price
          , trunc(dbms_random.value(1, 2))           AS id_status
          , trunc(dbms_random.value(1, 1))           AS order_date
        FROM
            (
                SELECT
                    ROWNUM rn
                FROM
                    dual
                CONNECT BY
                    level <= 200
            ) a
    )
    SELECT
        rid.a
      , id_emloyees 
      , rn AS client_id
      , pn.a
      , price
      , st.a
      , od.a
      , TO_DATE(od.a + trunc(dbms_random.value(7, 25)))
    FROM
        cte_gen  g
        LEFT OUTER JOIN create_region_id     rid ON g.id_region = rid.id
        LEFT OUTER JOIN create_product_name   pn ON g.id_pn = pn.id
        LEFT OUTER JOIN create_order_status   st ON g.id_status = st.id
        LEFT OUTER JOIN create_order_date     od ON g.order_date = od.id;
   