CREATE OR REPLACE TABLE
  `rahul-customer360-2026.customer360_raw.ga4_events`
OPTIONS (
  description = 'Raw GA4 ecommerce events from the Google public sample dataset, covering 2020-11-01 to 2021-01-31'
)
AS
SELECT *
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131';