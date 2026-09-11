# Customer 360 Tableau Dashboard

## Overview

This Tableau workbook presents the final reporting layer of the Customer 360 Intelligence Platform. It converts the prepared customer, sales and GA4 datasets into clear business-facing dashboards.

## Published Dashboard

[Open the Customer 360 Analytics Dashboard on Tableau Public](https://public.tableau.com/app/profile/rahul.chhabra2325/viz/Customer360AnalyticsDashboard_17890289216270/ExecutiveOverview?publish=yes)

## Dashboard Pages

### 1. Executive Overview

Provides a high-level view of overall digital activity and performance, including events, sessions, purchases, conversion and acquisition trends.

### 2. Customer & Sales Insights

Explores customer and sales behaviour to support customer-value, order and revenue analysis.

### 3. Digital Funnel & Conversion

Shows the e-commerce journey from user activity to purchase, together with acquisition-source and device-level conversion comparisons.

## Main Dashboard Metrics

- Total events: 1.06 million
- Total sessions: 88.8 thousand
- Purchase events: 1,374
- Reported conversion rate: 1.55%

These dashboard-level figures use event and session definitions and should not be directly compared with the unique-user funnel figures calculated in Python.

## Folder Contents

```text
tableau/
├── exports/
│   └── Customer_360_Tableau_Dashboard.pdf
├── screenshots/
│   ├── 01_Executive_Overview.png
│   ├── 02_Customer_Sales_Insights.png
│   └── 03_Digital_Funnel_Conversion.png
├── workbook/
│   └── Customer 360 Analytics Dashboard.twb
└── README.md
```

## Opening the Workbook

Open `workbook/Customer 360 Analytics Dashboard.twb` in Tableau Desktop or Tableau Public. The published link can be used to view the completed interactive dashboard without opening the local workbook.
