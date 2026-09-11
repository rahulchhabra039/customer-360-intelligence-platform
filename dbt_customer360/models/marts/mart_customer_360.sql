{{ config(materialized='table') }}

with ga4_by_customer as (

    select
        identity_map.customer_id,
        count(*) as total_events,
        countif(events.event_name = 'session_start') as total_sessions,
        countif(events.event_name = 'purchase') as ga4_purchase_events,
        min(events.event_date) as first_event_date,
        max(events.event_date) as last_event_date,
        sum(coalesce(events.purchase_revenue_usd, 0)) as ga4_purchase_revenue_usd
    from {{ ref('fct_ga4_events') }} as events
    inner join {{ ref('stg_crm_identity_map') }} as identity_map
        on events.user_pseudo_id = identity_map.user_pseudo_id
    group by identity_map.customer_id

),

sales_by_customer as (

    select
        customer_id,
        count(distinct order_id) as total_orders,
        sum(revenue_usd) as sales_revenue_usd,
        sum(item_quantity) as total_items,
        min(order_date) as first_order_date,
        max(order_date) as last_order_date
    from {{ ref('fct_sales_orders') }}
    where customer_id is not null
    group by customer_id

)

select
    customers.customer_id,
    customers.synthetic_email,
    customers.registration_date,
    customers.last_seen_date,
    customers.country,
    customers.region,
    customers.city,
    customers.initial_device,
    customers.acquisition_source,
    customers.acquisition_medium,
    customers.customer_lifetime_days,
    coalesce(ga4.total_events, 0) as total_events,
    coalesce(ga4.total_sessions, 0) as total_sessions,
    coalesce(ga4.ga4_purchase_events, 0) as ga4_purchase_events,
    ga4.first_event_date,
    ga4.last_event_date,
    coalesce(ga4.ga4_purchase_revenue_usd, 0) as ga4_purchase_revenue_usd,
    coalesce(sales.total_orders, 0) as total_orders,
    coalesce(sales.sales_revenue_usd, 0) as sales_revenue_usd,
    coalesce(sales.total_items, 0) as total_items,
    sales.first_order_date,
    sales.last_order_date,
    case
        when coalesce(sales.total_orders, 0) > 0 then true
        else false
    end as has_purchased
from {{ ref('dim_customers') }} as customers
left join ga4_by_customer as ga4
    on customers.customer_id = ga4.customer_id
left join sales_by_customer as sales
    on customers.customer_id = sales.customer_id