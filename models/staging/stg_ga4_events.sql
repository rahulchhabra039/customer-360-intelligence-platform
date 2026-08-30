with source_data as (

    select *
    from {{ source('customer360_raw', 'ga4_events') }}

)

select *
from source_data