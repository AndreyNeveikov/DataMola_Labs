alter session set current_schema=SA_CUSTOMERS;
--drop table t_sa_customers;

SELECT
    *
FROM
    t_sa_customers
ORDER BY
    1; 
    
commit;

alter session set current_schema=SA_CUSTOMERS;
Create table t_sa_customers (       
client_name                   VARCHAR2(50)     not null,
client_surname                VARCHAR2(50)     not null,
client_patronymic             VARCHAR2(15)     not null,
phone_number                  NUMBER           not null,
client_address                VARCHAR2(50)     not null,
payment_method                VARCHAR2(15)     not null
)

--
alter session set current_schema=SA_CUSTOMERS;
INSERT INTO t_sa_customers
    WITH create_client_name AS (
        SELECT
            1      AS id
          , 'Andrew'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2      AS id
          , 'Joe'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3      AS id
          , 'Mark'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4      AS id
          , 'Linda'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5      AS id
          , 'Jake'  AS a
        FROM
            dual
            UNION ALL
        SELECT
            6      AS id
          , 'Mary'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7      AS id
          , 'Victoria'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8      AS id
          , 'Barbara'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9      AS id
          , 'Martin'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10      AS id
          , 'Bill'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            11      AS id
          , 'Donald'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            12      AS id
          , 'Liz'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            13      AS id
          , 'Bob'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            14      AS id
          , 'Dorian'  AS a
        FROM
            dual
    ), create_client_surname AS (
        SELECT
            1         AS id
          , 'Neveykov'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'Trump'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 'Miligun'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4         AS id
          , 'Martines'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5         AS id
          , 'Daniels'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6         AS id
          , 'Capybara'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7         AS id
          , 'Gosling'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8         AS id
          , 'Grey'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9         AS id
          , 'Black'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10         AS id
          , 'White'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            11         AS id
          , 'Manson'  AS a
        FROM
            dual
    ), create_client_patronymic AS (
        SELECT
            1         AS id
          , 'Sergeevich'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'Andreevich'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 'Petrovich'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4         AS id
          , 'Vladimirovich'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5         AS id
          , 'Victorovna'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6         AS id
          , 'Alexandrona'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7         AS id
          , 'Andreevna'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8         AS id
          , 'Alekseevich'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9         AS id
          , 'Platonovich'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10         AS id
          , 'Mihailovich'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            11         AS id
          , 'Genadievna'  AS a
        FROM
            dual
    ), create_client_address AS (
        SELECT
            1         AS id
          , 'Slobodskaya st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'Esenina st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 'Independent blv.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4         AS id
          , 'Park ln.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5         AS id
          , 'Kosmonavtov st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6         AS id
          , 'Market blv.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7         AS id
          , 'Garden ln.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8         AS id
          , 'Pushkina st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9         AS id
          , 'Market st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10         AS id
          , 'Central blv.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            11         AS id
          , 'Jakson ln.'  AS a
        FROM
            dual
    ), create_client_payment_method AS (
        SELECT
            1         AS id
          , 'Cash'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'Card'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 'Check'  AS a
        FROM
            dual
    ), create_customer AS (
        SELECT
            a.*
          , trunc(dbms_random.value(1, 14))                 AS id_customer_name
          , trunc(dbms_random.value(1, 11))                 AS id_customer_surname
          , trunc(dbms_random.value(1, 11))                 AS id_customer_patronymic
          , trunc(dbms_random.value(1000000, 9999999))      AS phone_number
          , trunc(dbms_random.value(1, 11))                 AS id_customer_address
          , trunc(dbms_random.value(1, 3))                  AS id_customer_payment_method
        FROM
            (
                SELECT
                    ROWNUM rn
                FROM
                    dual
                CONNECT BY
                    level <= 150000
            ) a
    )
    SELECT
        c_name.a
      , c_surname.a
      , c_patronymic.a
      , cr_customer.phone_number
      , c_address.a
      , c_payment_method.a
    FROM
        create_customer  cr_customer
        LEFT OUTER JOIN create_client_name              c_name              ON cr_customer.id_customer_name = c_name.id
        LEFT OUTER JOIN create_client_surname           c_surname           ON cr_customer.id_customer_surname = c_surname.id
        LEFT OUTER JOIN create_client_patronymic        c_patronymic        ON cr_customer.id_customer_patronymic = c_patronymic.id
        LEFT OUTER JOIN create_client_address           c_address           ON cr_customer.id_customer_address = c_address.id
        LEFT OUTER JOIN create_client_payment_method    c_payment_method    ON cr_customer.id_customer_payment_method = c_payment_method.id;   
--