# Customer 360 Data Dictionary

## Purpose

This document describes the main dbt models and the key fields used in the Customer 360 analytics pipeline. The detailed transformation logic remains in the corresponding SQL model files.

## Staging Models

| Model | Grain | Purpose |
| --- | --- | --- |
| `stg_crm_customers` | One row per CRM customer | Cleans and standardises CRM customer records. |
| `stg_crm_identity_map` | One row per GA4 user mapping | Links anonymous GA4 users to CRM customers. |
| `stg_sales_orders` | One row per sales order | Cleans customer and guest order records. |
| `stg_ga4_events` | One row per GA4 event | Prepares event-level behavioural data. |

## Analytics Marts

| Model | Grain | Purpose |
| --- | --- | --- |
| `dim_customers` | One row per customer | Stores customer profile and acquisition attributes. |
| `fct_sales_orders` | One row per order | Stores identified and guest sales transactions. |
| `fct_ga4_events` | One row per GA4 event | Stores customer behaviour and purchase activity. |
| `mart_customer_360` | One row per customer | Combines CRM, GA4 behaviour and sales metrics into a unified customer view. |

## Key Fields and Tests

| Model | Field | Meaning | Data-quality tests |
| --- | --- | --- | --- |
| `stg_crm_customers` | `customer_id` | Unique CRM customer identifier. | Not null, unique |
| `stg_crm_identity_map` | `user_pseudo_id` | Anonymous GA4 user identifier. | Not null, unique |
| `stg_crm_identity_map` | `customer_id` | CRM customer linked to the GA4 user. | Not null |
| `stg_sales_orders` | `order_id` | Unique sales order identifier. | Not null, unique |
| `stg_sales_orders` | `customer_id` | Customer identifier; may be null for guest or unmatched orders. | None |
| `stg_ga4_events` | `event_name` | Name of the GA4 event. | Not null |
| `stg_ga4_events` | `event_timestamp` | Timestamp when the event occurred. | Not null |
| `dim_customers` | `customer_id` | Unique customer identifier. | Not null, unique |
| `fct_sales_orders` | `order_id` | Unique order identifier. | Not null, unique |
| `fct_sales_orders` | `customer_id` | Customer identifier; may be null for guest or unmatched orders. | None |
| `fct_ga4_events` | `event_name` | GA4 event name. | Not null |
| `fct_ga4_events` | `event_timestamp` | Timestamp when the event occurred. | Not null |
| `mart_customer_360` | `customer_id` | Unique customer identifier in the unified mart. | Not null, unique |

## Notes

- The YAML files in `dbt_customer360/models` are the source of truth for model descriptions and tests.
- Null customer identifiers are retained for legitimate guest or unmatched orders.
- Additional fields created by SQL transformations are documented through the model logic and project README.
