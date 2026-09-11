SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT event_date) AS day_count,
  MIN(SAFE.PARSE_DATE('%Y%m%d', event_date)) AS first_event_date,
  MAX(SAFE.PARSE_DATE('%Y%m%d', event_date)) AS last_event_date,
  COUNT(DISTINCT user_pseudo_id) AS unique_users,
  COUNTIF(event_name IS NULL) AS null_event_names,
  COUNTIF(user_pseudo_id IS NULL) AS null_user_ids,
  COUNTIF(SAFE.PARSE_DATE('%Y%m%d', event_date) IS NULL) AS invalid_event_dates
FROM `rahul-customer360-2026.customer360_raw.ga4_events`;