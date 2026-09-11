CREATE OR REPLACE TABLE
  `rahul-customer360-2026.customer360_raw.sales_orders`
OPTIONS (
  description = 'Deduplicated GA4 purchase orders linked to the synthetic CRM identity map'
)
AS

WITH purchases AS (
  SELECT
    COALESCE(
      NULLIF(e.ecommerce.transaction_id, ''),
      CONCAT(
        'GENERATED_',
        e.user_pseudo_id,
        '_',
        CAST(e.event_timestamp AS STRING)
      )
    ) AS order_id,

    m.customer_id,
    e.user_pseudo_id,

    SAFE.PARSE_DATE(
      '%Y%m%d',
      e.event_date
    ) AS order_date,

    TIMESTAMP_MICROS(
      e.event_timestamp
    ) AS order_timestamp,

    e.ecommerce.purchase_revenue_in_usd AS revenue_usd,
    e.ecommerce.total_item_quantity AS item_quantity,
    e.ecommerce.unique_items AS unique_items,

    e.geo.country AS country,
    e.device.category AS device_category,
    e.traffic_source.source AS acquisition_source,
    e.traffic_source.medium AS acquisition_medium,

    m.customer_id IS NOT NULL AS is_identified_customer

  FROM `rahul-customer360-2026.customer360_raw.ga4_events` AS e

  LEFT JOIN `rahul-customer360-2026.customer360_raw.crm_identity_map` AS m
    ON e.user_pseudo_id = m.user_pseudo_id

  WHERE e.event_name = 'purchase'
),

ranked_orders AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY order_id
      ORDER BY order_timestamp
    ) AS duplicate_rank
  FROM purchases
)

SELECT
  * EXCEPT(duplicate_rank)
FROM ranked_orders
WHERE duplicate_rank = 1;