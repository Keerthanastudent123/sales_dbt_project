{% snapshot customers_timestamp_snapshot %}
{{
    config(
        target_schema='snapshots',
        unique_key='C_CUSTKEY',
        strategy='timestamp',
        updated_at='updated_at'
    )
}}

select
    C_CUSTKEY,
    C_NAME,
    C_ADDRESS,
    C_NATIONKEY,
    C_PHONE,
    C_ACCTBAL,
    C_MKTSEGMENT,
    C_COMMENT,
    updated_at
from {{ source('demo_db', 'customers') }}

{% endsnapshot %}
