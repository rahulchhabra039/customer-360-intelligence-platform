# Customer 360 Project Methodology

## Objective

The project combines CRM customer records, GA4 behavioural events and sales orders to create a unified Customer 360 analytics layer and business dashboard.

## 1. Source Preparation in BigQuery

- Used public GA4 e-commerce event data as the behavioural source.
- Prepared CRM customer, identity-mapping and sales-order tables.
- Validated event distribution, customer coverage and purchase data before transformation.

## 2. Transformation with dbt

- Created four staging models to clean and standardise CRM, identity, sales and GA4 data.
- Created customer, sales-order and GA4 fact/dimension models.
- Built `mart_customer_360` as the final customer-level analytical dataset.
- Applied not-null and uniqueness tests to important identifiers and event fields.
- Stored descriptions and tests in the dbt YAML files.

## 3. Python Funnel Analysis

Python was used to analyse movement through the e-commerce funnel:

`view_item → add_to_cart → begin_checkout → purchase`

The analysis calculated:

- Stage conversion rate = users at the current stage ÷ users at the previous stage.
- Drop-off rate = 1 − stage conversion rate.
- Overall conversion rate = users at the current stage ÷ users who viewed an item.
- Checkout conversion by device = purchasers ÷ checkout users.
- A two-proportion z-test and 95% confidence interval for the mobile-versus-desktop difference.

## 4. Tableau Reporting

The final Tableau workbook contains three dashboard pages:

1. Executive Overview
2. Customer & Sales Insights
3. Digital Funnel & Conversion

The dashboards present high-level KPIs, customer and sales patterns, acquisition performance and funnel conversion results.

## Data-quality Controls

- Checked source row distributions and required fields in BigQuery.
- Tested important identifiers for nulls and duplicates in dbt.
- Retained guest and unmatched orders instead of incorrectly assigning customers.
- Exported reproducible CSV results and charts from the Python notebook.

## Limitations

- The project uses anonymised public GA4 sample data.
- The device comparison is observational and does not establish causation.
- Unmatched and guest transactions can have a null customer identifier.
- Business recommendations should be validated using controlled experiments and current production data.
