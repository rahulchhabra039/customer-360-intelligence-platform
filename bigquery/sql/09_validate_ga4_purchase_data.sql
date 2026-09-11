SELECT
  COUNT(*) AS purchase_events,

  COUNT(DISTINCT ecommerce.transaction_id)
    AS unique_transaction_ids,

  COUNTIF(
    ecommerce.transaction_id IS NULL
    OR ecommerce.transaction_id = ''
  ) AS missing_transaction_ids,

  COUNTIF(
    ecommerce.purchase_revenue_in_usd IS NULL
  ) AS missing_revenue_values,

  ROUND(
    SUM(ecommerce.purchase_revenue_in_usd),
    2
  ) AS total_revenue_usd

FROM `rahul-customer360-2026.customer360_raw.ga4_events`

WHERE event_name = 'purchase';