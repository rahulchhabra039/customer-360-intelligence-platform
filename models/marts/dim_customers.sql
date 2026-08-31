{{ config(materialized='table') }}

select
    customer_id,
    synthetic_email,
    registration_date,
    last_seen_date,
    country,
    region,
    city,
    initial_device,
    acquisition_source,
    acquisition_medium,
    date_diff(last_seen_date, registration_date, day) as customer_lifetime_days
from {{ ref('stg_crm_customers') }}