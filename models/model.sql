with line_items_cte as (
    select
        l.L_ORDERKEY,
        l.L_PARTKEY,
        l.L_SUPPKEY,
        l.L_LINENUMBER,
        l.L_EXTENDEDPRICE,
        l.L_DISCOUNT,
        l.L_TAX,
        l.L_RETURNFLAG,
        l.L_LINESTATUS,
        l.L_SHIPDATE
    from {{ source('demo_db', 'lineitem') }} l
),

orders_cte as (
    select
        o.O_ORDERKEY,
        o.O_CUSTKEY,
        o.O_TOTALPRICE,
        o.O_ORDERDATE,
        o.O_ORDERPRIORITY,
        o.O_SHIPPRIORITY
    from {{ source('demo_db', 'orders') }} o
)

select
    o.O_ORDERKEY,
    o.O_CUSTKEY,
    count(l.L_LINENUMBER) as total_line_items,
    sum(l.L_EXTENDEDPRICE * (1 - l.L_DISCOUNT)) as total_revenue,
    o.O_TOTALPRICE,
    o.O_ORDERDATE,
    o.O_ORDERPRIORITY
from orders_cte o
left join line_items_cte l
    on o.O_ORDERKEY = l.L_ORDERKEY
group by o.O_ORDERKEY, o.O_CUSTKEY, o.O_TOTALPRICE, o.O_ORDERDATE, o.O_ORDERPRIORITY
