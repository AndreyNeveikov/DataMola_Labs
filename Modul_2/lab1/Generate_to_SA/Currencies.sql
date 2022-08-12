alter session set current_schema=SA_CURRENCIES;
drop table t_sa_currencies;

alter session set current_schema=SA_CURRENCIES;
Create table t_sa_currencies ( 
currency_id                   INT              not null,
currency_name                 VARCHAR2(7)      not null,
direct_exchange_rate          FLOAT            not null,
reverse_exchange_rate         FLOAT            not null  
);


alter session set current_schema=SA_CURRENCIES;
INSERT INTO t_sa_currencies
    WITH create_currenci_name AS (
        SELECT
            1      AS id
          , 'BYN'  AS a
          , 0.40   AS b
        FROM
            dual
    ), create_currenci_rate AS (
        SELECT
            1      AS id
          , 'EUR'  AS a
          , 1.02   AS b
        FROM
            dual
        UNION ALL
        SELECT
            2      AS id
          , 'RUB'  AS a
          , 0.016  AS b
        FROM
            dual
        UNION ALL
        SELECT
            3      AS id
          , 'USD'  AS a
          , 1.0    AS b
        FROM
            dual
        UNION ALL
        SELECT
            4      AS id
          , 'CNY'  AS a
          , 0.15   AS b
        FROM
            dual
        UNION ALL
        SELECT
            5      AS id
          , 'SAR'  AS a
          , 0.27   AS b
        FROM
            dual
    ), create_rates AS (
        SELECT
            a.*
          , 1                                        AS id_create_currenci_name
          , trunc(dbms_random.value(1, 6))           AS id_create_currenci_rate
        FROM
            (
                SELECT
                    ROWNUM rn
                FROM
                    dual
                CONNECT BY
                    level <= 20
            ) a
    )
    SELECT
        ( CASE
      WHEN concat(create_currenci_name.id, create_currenci_rate.id) = 11 THEN 120
      WHEN concat(create_currenci_name.id, create_currenci_rate.id) = 12 THEN 250
      WHEN concat(create_currenci_name.id, create_currenci_rate.id) = 13 THEN 3600
      WHEN concat(create_currenci_name.id, create_currenci_rate.id) = 14 THEN 4700
      WHEN concat(create_currenci_name.id, create_currenci_rate.id) = 15 THEN 5800
        END ) id
      , concat(create_currenci_name.a, concat('/', create_currenci_rate.a)) 
      , trunc(create_currenci_name.b/create_currenci_rate.b, 2)
      , trunc(create_currenci_rate.b/create_currenci_name.b, 2)
    FROM
        create_rates 
        LEFT OUTER JOIN create_currenci_name   ON create_rates.id_create_currenci_name = create_currenci_name.id
        LEFT OUTER JOIN create_currenci_rate   ON create_rates.id_create_currenci_rate = create_currenci_rate.id; 

alter session set current_schema=SA_CURRENCIES;
select
    *
from
    t_sa_currencies;
commit;