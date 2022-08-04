alter session set current_schema=SA_CURRENCIES;
--drop table t_sa_currencies;

alter session set current_schema=SA_CURRENCIES;
Create table t_sa_currencies ( 
currenci_id                   INT              not null,
currenci_name                 VARCHAR2(25)     not null,
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
        UNION ALL
        SELECT
            2      AS id
          , 'EUR'  AS a
          , 1.02   AS b
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
          , 'RUB'  AS a
          , 0.016  AS b
        FROM
            dual
        UNION ALL
        SELECT
            5      AS id
          , 'PLN'  AS a
          , 0.22   AS b
        FROM
            dual
    ), create_currenci_rate AS (
        SELECT
            1      AS id
          , 'BYN'  AS a
          , 0.40   AS b
        FROM
            dual
        UNION ALL
        SELECT
            2      AS id
          , 'EUR'  AS a
          , 1.02   AS b
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
          , 'RUB'  AS a
          , 0.016  AS b
        FROM
            dual
        UNION ALL
        SELECT
            5      AS id
          , 'PLN'  AS a
          , 0.22   AS b
        FROM
            dual
    ), create_rates AS (
        SELECT
            a.*
          , trunc(dbms_random.value(1, 5))           AS id_create_currenci_name
          , trunc(dbms_random.value(1, 5))           AS id_create_currenci_rate
        FROM
            (
                SELECT
                    ROWNUM rn
                FROM
                    dual
                CONNECT BY
                    level <= 15000
            ) a
    )
    SELECT
        concat(create_currenci_name.id, create_currenci_rate.id)
      , concat(create_currenci_name.a, concat('/', create_currenci_rate.a)) 
      , trunc(create_currenci_name.b/create_currenci_rate.b, 2)
      , trunc(create_currenci_rate.b/create_currenci_name.b, 2)
    FROM
        create_rates 
        LEFT OUTER JOIN create_currenci_name   ON create_rates.id_create_currenci_name = create_currenci_name.id
        LEFT OUTER JOIN create_currenci_rate   ON create_rates.id_create_currenci_rate = create_currenci_rate.id;
--
SELECT
    *
FROM
    t_sa_currencies;   
