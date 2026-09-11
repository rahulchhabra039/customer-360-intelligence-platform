with source_data as (

    select *
    from {{ source('customer360_raw', 'crm_identity_map') }}

)

select *
from source_data