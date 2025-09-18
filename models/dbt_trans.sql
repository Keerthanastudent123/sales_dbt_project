{{ config(
    materialized = 'view'
) }}

select 
    o.O_ORDERKEY,
    o.O_ORDERDATE,
    sum(l.L_EXTENDEDPRICE) as total_sales,
    count(distinct l.L_PARTKEY) as unique_parts
from {{ source('raw','orders') }} o
join {{ source('raw','lineitem') }} l
    on o.O_ORDERKEY = l.L_ORDERKEY
group by 1,2
