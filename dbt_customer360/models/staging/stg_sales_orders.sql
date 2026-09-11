with source_data as (

    select *
    from {{ source('customer360_raw', 'sales_orders') }}

)

select *
from source_data