with orders_cte as (
    select
        o.orderkey,
        o.custkey,
        l.partkey,
        l.suppkey,
        l.extendedprice
    from {{ source('demo_db', 'orders') }} o
    join {{ source('demo_db', 'lineitem') }} l
      on o.orderkey = l.orderkey
)

select
    custkey as customer_id,
    count(distinct orderkey) as total_orders,
    sum(extendedprice) as total_revenue
from orders_cte
group by custkey
