# E-Commerce Sales & Customer Analytics

An end-to-end analysis of the Olist Brazilian e-commerce dataset: data-quality checks and analysis in MySQL, preparation in Excel, and an interactive Power BI dashboard covering orders, sales, payments, customers, and reviews.

![Dashboard](dashboard.png)

## Business Questions
- How many orders and how much sales revenue did the business generate?
- How have orders changed over time?
- Which payment methods do customers use most?
- Which states have the most customers?
- What is the order status breakdown, and how satisfied are customers (review scores)?

## Tools Used
MySQL (analysis) | Excel (data preparation) | Power BI (dashboard and KPIs)

## Key Numbers
| KPI | Value |
|---|---|
| Total Orders | 99.441K |
| Total Sales (sum of item price) | 13.59M |
| Average Review Score | 4.09 |

**Orders by year:** 2016: 0.33K (0.33%) | 2017: 45.1K (45.35%) | 2018: 54.01K (54.31%)

## Key Insights
- Customers rate their experience well overall, with an average review score of 4.09.
- Order volume grew from 2017 to 2018, and 2018 holds the largest share of orders.
- The vast majority of orders have a "delivered" status; other statuses are a small fraction.
- [TODO: add 2 or 3 findings from your own analysis, e.g. the top payment method, the top state by customers, the peak month]

## Project Workflow
1. **Data-quality checks (SQL):** checked for duplicate records, missing values, and unmatched order records across tables.
2. **Analyze (MySQL):** queries using joins, aggregate functions, CTEs, subqueries, and window functions on orders, customers, payments, and reviews.
3. **Visualize (Power BI):** KPI cards, monthly orders trend, orders by payment method, customers by state, orders by status, and customer review scores.

## Files in this Repository
| File | Description |
|---|---|
| [TODO: your SQL file name] | MySQL analysis queries |
| [TODO: your .pbix file name] | Power BI dashboard |
| [TODO: your Excel file name, if any] | Prepared data |
| `dashboard.png` | Dashboard screenshot |

## Dataset
[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) from Kaggle. Tables used: customers, orders, order items, payments, and reviews.

## How to Open
Download the `.pbix` file and open it in Power BI Desktop.

## Author
Mohammed Muzammil | [LinkedIn](https://linkedin.com/in/mmuzammil39) | muzammilmohammad330@gmail.com
