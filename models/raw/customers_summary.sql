with orders_cte as (
    select
        O_CUSTKEY,
        O_ORDERKEY,
        O_TOTALPRICE
    from {{ source('demo_db', 'orders') }}
),

customers_cte as (
    select
        C_CUSTKEY,
        C_NAME,
        C_MKTSEGMENT,
        C_NATIONKEY
    from {{ source('demo_db', 'customers') }}
)

select
    c.C_CUSTKEY,
    c.C_NAME,
    c.C_MKTSEGMENT,
    count(distinct o.O_ORDERKEY) as total_orders,
    sum(o.O_TOTALPRICE) as total_revenue
from customers_cte c
left join orders_cte o
    on c.C_CUSTKEY = o.O_CUSTKEY
group by c.C_CUSTKEY, c.C_NAME, c.C_MKTSEGMENT
