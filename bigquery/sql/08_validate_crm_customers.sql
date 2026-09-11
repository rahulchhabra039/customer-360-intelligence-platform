SELECT
  COUNT(*) AS total_customers,

  COUNT(DISTINCT customer_id) AS unique_customer_ids,

  COUNT(DISTINCT synthetic_email) AS unique_emails,

  COUNTIF(customer_id IS NULL) AS null_customer_ids,

  COUNTIF(synthetic_email IS NULL) AS null_emails,

  COUNTIF(account_status IS NULL) AS null_account_status,

  COUNTIF(is_synthetic IS NOT TRUE) AS incorrectly_labelled_records,

  ROUND(
    100 * SAFE_DIVIDE(
      COUNTIF(marketing_consent),
      COUNT(*)
    ),
    2
  ) AS marketing_consent_percentage

FROM `rahul-customer360-2026.customer360_raw.crm_customers`;