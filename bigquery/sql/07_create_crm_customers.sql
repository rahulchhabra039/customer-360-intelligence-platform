CREATE OR REPLACE TABLE
  `rahul-customer360-2026.customer360_raw.crm_customers`
OPTIONS (
  description = 'Synthetic CRM customer profiles linked to the GA4 portfolio dataset through crm_identity_map'
)
AS

WITH customer_base AS (
  SELECT
    m.customer_id,
    m.first_seen_date AS registration_date,
    m.last_seen_date,

    ARRAY_AGG(
      e.geo.country IGNORE NULLS
      ORDER BY e.event_timestamp
      LIMIT 1
    )[SAFE_OFFSET(0)] AS country,

    ARRAY_AGG(
      e.geo.region IGNORE NULLS
      ORDER BY e.event_timestamp
      LIMIT 1
    )[SAFE_OFFSET(0)] AS region,

    ARRAY_AGG(
      e.geo.city IGNORE NULLS
      ORDER BY e.event_timestamp
      LIMIT 1
    )[SAFE_OFFSET(0)] AS city,

    ARRAY_AGG(
      e.device.category IGNORE NULLS
      ORDER BY e.event_timestamp
      LIMIT 1
    )[SAFE_OFFSET(0)] AS initial_device,

    ARRAY_AGG(
      e.traffic_source.source IGNORE NULLS
      ORDER BY e.event_timestamp
      LIMIT 1
    )[SAFE_OFFSET(0)] AS acquisition_source,

    ARRAY_AGG(
      e.traffic_source.medium IGNORE NULLS
      ORDER BY e.event_timestamp
      LIMIT 1
    )[SAFE_OFFSET(0)] AS acquisition_medium

  FROM `rahul-customer360-2026.customer360_raw.crm_identity_map` AS m

  INNER JOIN `rahul-customer360-2026.customer360_raw.ga4_events` AS e
    ON m.user_pseudo_id = e.user_pseudo_id

  GROUP BY
    m.customer_id,
    m.first_seen_date,
    m.last_seen_date
),

customer_enriched AS (
  SELECT
    *,
    ABS(MOD(FARM_FINGERPRINT(customer_id), 100)) AS customer_bucket
  FROM customer_base
)

SELECT
  customer_id,

  CONCAT(
    LOWER(customer_id),
    '@example.com'
  ) AS synthetic_email,

  registration_date,
  last_seen_date,

  COALESCE(country, 'Unknown') AS country,
  COALESCE(region, 'Unknown') AS region,
  COALESCE(city, 'Unknown') AS city,
  COALESCE(initial_device, 'Unknown') AS initial_device,
  COALESCE(acquisition_source, 'Unknown') AS acquisition_source,
  COALESCE(acquisition_medium, 'Unknown') AS acquisition_medium,

  customer_bucket < 65 AS marketing_consent,

  CASE MOD(customer_bucket, 3)
    WHEN 0 THEN 'Email'
    WHEN 1 THEN 'SMS'
    ELSE 'Push notification'
  END AS preferred_contact_channel,

  CASE
    WHEN DATE_DIFF(DATE '2021-01-31', last_seen_date, DAY) <= 30
      THEN 'Active'
    WHEN DATE_DIFF(DATE '2021-01-31', last_seen_date, DAY) <= 60
      THEN 'Dormant'
    ELSE 'Inactive'
  END AS account_status,

  TRUE AS is_synthetic

FROM customer_enriched;