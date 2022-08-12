alter session set current_schema=SA_ORDERS;
drop table t_sa_doers;

alter session set current_schema=SA_ORDERS;
SELECT
    *
FROM
    t_sa_doers
ORDER BY
    1; 
    
commit;


alter session set current_schema=SA_ORDERS;

Create table t_sa_doers (
vehicle_registration_plate    VARCHAR2(8)     not null,
driving_category              VARCHAR2(20)     not null
);

alter session set current_schema=SA_ORDERS;
INSERT INTO t_sa_doers
    WITH create_driving_category AS (
        SELECT
            1      AS id
          , 'A,B,BE,C,D,DE'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2      AS id
          , 'B'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3      AS id
          , 'C'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4      AS id
          , 'D'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5      AS id
          , 'BE'  AS a
        FROM
            dual
            UNION ALL
        SELECT
            6      AS id
          , 'CE'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7      AS id
          , 'DE'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8      AS id
          , 'A,B,C'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9      AS id
          , 'B,C'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10      AS id
          , 'B,C,BE,CE'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            11      AS id
          , 'B,BE'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            12      AS id
          , 'B,BE,C'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            13      AS id
          , 'A,B,C,D,BE,CE,DE'  AS a
        FROM
            dual
    ), create_doer AS (
        SELECT
            a.*
          , trunc(dbms_random.value(1, 13))               AS id_driving_category
          , TO_CHAR(concat(concat(trunc(dbms_random.value(1000, 9999)),'AA-'),trunc(dbms_random.value(1, 7)))) AS vehicle_registration_plate
        FROM
            (
                SELECT
                    ROWNUM rn
                FROM
                    dual
                CONNECT BY
                    level <= 6
            ) a
    )
    SELECT
        vehicle_registration_plate
      , d_driving_category.a

    FROM
        create_doer  cr_doer
        LEFT OUTER JOIN create_driving_category    d_driving_category   ON cr_doer.id_driving_category = d_driving_category.id;   
--