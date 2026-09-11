# BigQuery Workflow Index

This index lists the BigQuery workflow files in execution order. SQL files are the primary implementation evidence, while CSV results and screenshots provide supporting validation evidence.

| Step | Purpose | SQL or source evidence | Result evidence |
| ---: | --- | --- | --- |
| 1 | Review the public GA4 source tables | `screenshots/01_public_ga4_source_table_details.png` | Source schema screenshot |
| 2 | Analyse the GA4 event distribution | `sql/02_ga4_event_distribution.sql` | `query-results/02_ga4_event_distribution.csv` |
| 3 | Ingest GA4 events into the project dataset | `sql/03_ingest_ga4_raw_events.sql` | Created BigQuery table |
| 4 | Validate the ingested GA4 event data | `sql/04_validate_ga4_raw_events.sql` | `query-results/04_validate_ga4_raw_events.csv` |
| 5 | Check customer identity coverage | `sql/05_check_ga4_identity_coverage.sql` | `query-results/05_check_ga4_identity_coverage.csv` |
| 6 | Create the CRM-to-GA4 identity map | `sql/06_create_crm_identity_map.sql` | Created BigQuery table |
| 7 | Create the CRM customer table | `sql/07_create_crm_customers.sql` | Created BigQuery table |
| 8 | Validate CRM customer records | `sql/08_validate_crm_customers.sql` | `query-results/08_validate_crm_customers.csv` |
| 9 | Validate GA4 purchase activity | `sql/09_validate_ga4_purchase_data.sql` | `query-results/09_validate_ga4_purchase_data.csv` |
| 10 | Create the sales-order table | `sql/10_create_sales_orders.sql` | Created BigQuery table |

Steps that create tables do not have separate CSV files because their output is stored directly in BigQuery.
