with source_data as (

    select *
    from {{ source('customer360_raw', 'crm_customers') }}

)

select *
from source_data