SELECT
  COUNT(*) AS total_events,

  COUNTIF(
    user_id IS NOT NULL AND user_id != ''
  ) AS identified_events,

  ROUND(
    100 * SAFE_DIVIDE(
      COUNTIF(user_id IS NOT NULL AND user_id != ''),
      COUNT(*)
    ),
    2
  ) AS identified_event_percentage,

  COUNT(DISTINCT NULLIF(user_id, '')) AS identified_customers,

  COUNT(DISTINCT user_pseudo_id) AS pseudo_users

FROM `rahul-customer360-2026.customer360_raw.ga4_events`;