# README: SQL Scripts for Analysis

## Overview
This repository contains a comprehensive collection of SQL scripts for analyzing data across various domains, including sales, financials, and movies. The scripts are structured to provide insights into key metrics, generate detailed reports, and support decision-making processes.

The following sections provide a summary of the scripts included, their purpose, and how they can be executed.

---

## Purpose
These SQL scripts are designed to:
- Extract, transform, and analyze data.
- Generate detailed and aggregated reports.
- Perform analytics tasks for specific use cases (e.g., sales trends, profitability analysis).
- Provide insights for business and operational improvements.

---

## Requirements
To execute these SQL scripts, you will need:
- A database management system (e.g., MySQL, PostgreSQL, or equivalent).
- Access to the respective datasets, including tables such as `movies`, `financials`, `dim_product`, `fact_sales_monthly`, and more.
- Basic knowledge of SQL to modify or adapt the queries as needed.

---

## Scripts Overview

### Croma India Sales Analysis
#### Purpose:
Analyze Croma India's sales data for FY 2021.

#### Key Queries:
- Fetching customer details for Croma.
- Aggregating product sales on a monthly basis.
- Generating detailed sales reports with pre- and post-invoice discount calculations.

#### Highlight:
- Uses CTEs (Common Table Expressions) to calculate net sales after applying pre- and post-invoice discounts.

### Hollywood Movies Analysis
#### Purpose:
Evaluate Hollywood movies based on profitability and IMDb ratings.

#### Key Queries:
- Identify highly profitable movies with over 500% ROI.
- Highlight movies with below-average IMDb ratings.
- Analyze movies released after the year 2000 with significant profits.

#### Highlight:
- Demonstrates multi-step filtering using CTEs.

### Financials and Metrics Analysis
#### Purpose:
Generate financial insights from the `financials` table.

#### Key Queries:
- Calculate profits and profitability percentages.
- Convert revenue into a uniform unit (e.g., millions).
- Perform inner, left, and right joins between `movies` and `financials` tables.

#### Highlight:
- Includes complex calculations such as profit percentages and unit conversions.

### Expenses Analysis with Window Functions
#### Purpose:
Analyze expenses using advanced SQL window functions.

#### Key Queries:
- Calculate the percentage contribution of each expense category.
- Perform cumulative sum analysis for tracking total expenses over time.

#### Highlight:
- Uses `OVER()` with `PARTITION BY` for advanced analytics.

---

## Conclusion
This repository provides a robust framework for performing detailed data analysis using SQL. The included scripts demonstrate practical use cases such as sales performance tracking, profitability analysis, and expense management. They are designed to be flexible, allowing users to adapt them to their specific datasets and objectives.

For any questions or further enhancements, feel free to reach out or create an issue in the repository.
