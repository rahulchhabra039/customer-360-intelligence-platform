CREATE OR REPLACE TABLE
  `rahul-customer360-2026.customer360_raw.crm_identity_map`
OPTIONS (
  description = 'Synthetic CRM identity bridge connecting selected GA4 pseudonymous users to portfolio customer IDs'
)
AS

WITH user_activity AS (
  SELECT
    user_pseudo_id,
    MIN(SAFE.PARSE_DATE('%Y%m%d', event_date)) AS first_seen_date,
    MAX(SAFE.PARSE_DATE('%Y%m%d', event_date)) AS last_seen_date
  FROM `rahul-customer360-2026.customer360_raw.ga4_events`
  WHERE user_pseudo_id IS NOT NULL
  GROUP BY user_pseudo_id
),

registered_users AS (
  SELECT *
  FROM user_activity
  WHERE MOD(FARM_FINGERPRINT(user_pseudo_id), 4) = 0
)

SELECT
  CONCAT(
    'CUST_',
    LPAD(
      CAST(ROW_NUMBER() OVER (ORDER BY user_pseudo_id) AS STRING),
      6,
      '0'
    )
  ) AS customer_id,
  user_pseudo_id,
  first_seen_date,
  last_seen_date,
  'synthetic_portfolio_mapping' AS mapping_source,
  TRUE AS is_synthetic
FROM registered_users;