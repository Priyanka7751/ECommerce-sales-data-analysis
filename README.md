# 📊 E-Commerce Data Analysis using SQL

## 📌 Project Overview

This project involves analyzing an E-Commerce business database using **SQL** to extract meaningful business insights. Using structured queries, we perform customer profiling, product analysis, sales trend identification, and supplier-country mapping. The analysis aims to assist business teams in understanding customer behavior, product performance, and regional sales variations.

## 🎯 Objective

While there is no formal problem statement, the goal of this project is to:
- Explore customer, product, and sales data.
- Derive actionable insights using SQL queries.
- Enable better decision-making for marketing, supply chain, and product teams.

## 📂 Dataset Description

The datasets used in this project were imported into a SQL Server Management Studio (SSMS) environment, under the database name **E_Commerce**. The key tables include:

- `Customer`: Customer demographics and locations.
- `Supplier`: Supplier details including country and contact info.
- `Product`: Product specifications, pricing, and inventory.
- `Orders`: Basic order data with total amount and order dates.
- `OrderItem`: Itemized details of each product per order.

## 🛠️ SQL Functionalities Used

The following SQL concepts and functionalities were utilized:
- `SELECT`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`
- `JOIN` operations (`INNER JOIN`, `LEFT JOIN`, `FULL JOIN`)
- Subqueries and nested queries
- `CASE` statements
- `DENSE_RANK()` and `ROW_NUMBER()` window functions
- `DATEPART`, `YEAR()`, `MONTH()` functions
- `UNION ALL`, `NOT IN`, `IN`
- Aggregation functions: `COUNT()`, `SUM()`, `MAX()`, `MIN()`

## 🔍 Key Insights / SQL Query Categories

### 🧾 General Information
- List of all customers and suppliers.
- Country-wise breakdowns for customers and suppliers.

### 📦 Orders & Sales
- Total sales per customer.
- Sales trends by month (including specific year 2013).
- Top 10 and top N most expensive products.

### 🌍 Regional Analysis
- Customers with and without suppliers in their country.
- Supplier countries count.
- Targeted marketing ideas based on countries with fewer orders.

### 📈 Advanced Analytics
- Average Order Value (AOV) per customer.
- Most ordered products by quantity.
- Repeat vs. first-time customer orders.
- Top 2 customers per country by order value using `DENSE_RANK`.

## ✅ Conclusion

This project demonstrates how raw relational data can be transformed into valuable business intelligence using SQL. It provides insights into sales performance, customer behavior, and supplier efficiency, laying the foundation for further reporting or dashboard creation.
