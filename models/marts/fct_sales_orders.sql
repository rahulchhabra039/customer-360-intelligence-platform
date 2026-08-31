{{ config(materialized='table') }}

select
    order_id,
    customer_id,
    user_pseudo_id,
    order_date,
    order_timestamp,
    revenue_usd,
    item_quantity,
    unique_items,
    country,
    device_category,
    case
        when customer_id is null then 'Guest or Unmatched'
        else 'Identified Customer'
    end as customer_type
from {{ ref('stg_sales_orders') }}