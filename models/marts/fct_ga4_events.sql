{{ config(materialized='view') }}

select
    safe.parse_date('%Y%m%d', event_date) as event_date,
    timestamp_micros(event_timestamp) as event_timestamp,
    event_name,
    user_pseudo_id,
    device.category as device_category,
    geo.country as country,
    traffic_source.source as traffic_source,
    traffic_source.medium as traffic_medium,
    platform,
    ecommerce.purchase_revenue_in_usd as purchase_revenue_usd
from {{ ref('stg_ga4_events') }}