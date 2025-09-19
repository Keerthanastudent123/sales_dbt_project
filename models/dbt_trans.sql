{{ config(
    materialized = 'view'
) }}

select 
    O_ORDERKEY,
    O_ORDERDATE,
    
from {{ source('demo_db','orders') }}
