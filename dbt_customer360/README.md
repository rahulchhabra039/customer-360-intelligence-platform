# Customer 360 dbt Transformation Layer

## Overview

This dbt project transforms BigQuery source data into clean, documented and tested datasets for Customer 360 analytics.

The transformation flow is:

**BigQuery source tables → Staging models → Analytics marts**

## Staging Models

* `stg_crm_customers.sql` – cleans and standardises CRM customer data.
* `stg_crm_identity_map.sql` – prepares the customer identity mapping.
* `stg_ga4_events.sql` – prepares GA4 event-level data.
* `stg_sales_orders.sql` – cleans sales order data.

## Analytics Marts

* `dim_customers.sql` – customer dimension.
* `fct_sales_orders.sql` – sales order fact model.
* `fct_ga4_events.sql` – GA4 event fact model.
* `mart_customer_360.sql` – unified Customer 360 dataset.

## Testing and Documentation

Model documentation and data-quality tests are defined in:

* `models/staging/staging.yml`
* `models/marts/marts.yml`

The dbt pipeline and its model and test checks were successfully validated before being merged into the main GitHub branch.

## Main Technologies

* dbt
* Google BigQuery
* SQL
* GitHub

