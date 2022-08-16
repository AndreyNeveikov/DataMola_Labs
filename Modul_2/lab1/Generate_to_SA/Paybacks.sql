alter session set current_schema=SA_ORDERS;
SELECT
    *
FROM
    t_sa_paybacks;
    
commit;
--------------------------------------------------------------------------------    
    
alter session set current_schema=SA_ORDERS;
drop table t_sa_paybacks;


alter session set current_schema=SA_ORDERS;
Create table t_sa_paybacks (
customer_payment              FLOAT            not null,
product_costs                 FLOAT            not null,
fuel_costs                    FLOAT            not null,
vehicle_depreciation          FLOAT            not null,
insurance_cost                FLOAT            not null,
unexpected_expenses           FLOAT            not null
);

--
alter session set current_schema=SA_ORDERS;
INSERT INTO t_sa_paybacks
    WITH create_unexpected_expenses AS (
        SELECT
            1         AS id
          , trunc(dbms_random.value(0, 5))  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , trunc(dbms_random.value(8, 10))  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 0  AS a
        FROM
            dual
    ), cte_gen AS (
        SELECT
            a.*
          , trunc(dbms_random.value(100, 600))       AS customer_payment
          , trunc(dbms_random.value(1, 3))           AS id_unexpected_expenses
        FROM
            (
                SELECT
                    ROWNUM rn
                FROM
                    dual
                CONNECT BY
                    level <= 20000
            ) a
    )
    SELECT
          customer_payment
        , trunc(customer_payment * dbms_random.value(0.45, 0.64))  -- product_costs
        , trunc(customer_payment * dbms_random.value(0.05, 0.07))  -- fuel_cost
        , trunc(customer_payment * dbms_random.value(0.09, 0.11))  -- vehicle_depreciation 
        , trunc(customer_payment * dbms_random.value(0.01, 0.03))  -- insurance_cost
        , un_exp.a
    FROM
        cte_gen ctg
        LEFT OUTER JOIN create_unexpected_expenses   un_exp ON ctg.id_unexpected_expenses = un_exp.id;
  
   