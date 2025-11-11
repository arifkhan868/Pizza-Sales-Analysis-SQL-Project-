# Advanced Pizza Sales Analysis

**Professional Data Analysis & SQL Portfolio Project**

---

## 📊 Project Objective
This project analyzes a pizza sales dataset to uncover business insights and provide actionable recommendations. The analysis covers:

- Total orders and quantity sold  
- Revenue generation by pizza and category  
- Top-selling pizza types and sizes  
- Hourly and daily order patterns  
- Cumulative and Month-over-Month revenue trends  
- Percentage contribution of each pizza type/category to revenue  
- Customer behavior and segmentation (advanced)  
- Profit margin analysis per pizza (if cost data available)

---

## 📂 Dataset Overview
The dataset includes four main tables:

| Table Name      | Description |
|-----------------|-------------|
| `orders`        | Contains order_id, date, time, and customer information |
| `order_details` | Contains order_id, pizza_id, and quantity |
| `pizzas`        | Contains pizza_id, pizza_type_id, size, price |
| `pizza_types`   | Contains pizza_type_id, name, category, ingredients |

---

## 💡 Key Insights
1. **Total Orders & Quantity** – Total unique orders and total pizzas sold  
2. **Revenue Analysis** – Total revenue, top 3 pizza types by revenue, cumulative revenue  
3. **Percentage Contribution** – Pizza-wise and category-wise contribution to overall revenue  
4. **Hourly & Daily Patterns** – Peak ordering hours and daily averages  
5. **Top 5 / Top 3 Analysis** – Most ordered pizzas and top pizzas per category using `DENSE_RANK()`  
6. **Customer Behavior** – Frequent vs occasional customers, order time trends  
7. **Month-over-Month Growth** – Revenue growth trends month-wise  
8. **Profit Margin Analysis** – Revenue minus cost per pizza/category (if cost available)  

---

## ⚡ Skills Demonstrated
- **SQL**: JOINs, Aggregations, Subqueries, Window Functions (`SUM() OVER`, `DENSE_RANK()`, `LEAD()`, `LAG()`), CTEs  
- **Data Analysis**: Business insights, trend analysis, KPI computation  
- **Business Intelligence**: Dashboard creation in Power BI / Excel  
- **Portfolio Readiness**: Professional documentation, screenshots, query explanations  

---

## 📌 Example SQL Queries Included

### Total Orders & Quantity
```sql
-- Total unique orders
SELECT COUNT(DISTINCT order_id) AS total_order
FROM pizza.orders;

-- Total quantity of pizzas sold
SELECT SUM(quantity) AS total_quantity
FROM pizza.order_details;
---
```
## Revenue Analysis
```
-- Total revenue from all pizzas
SELECT SUM(p.price * od.quantity) AS total_revenue
FROM pizza.pizzas p
JOIN pizza.order_details od ON od.pizza_id = p.pizza_id;

-- Top 3 pizzas by revenue
SELECT pt.name, SUM(p.price * od.quantity) AS total_revenue
FROM pizza.order_details od
JOIN pizza.pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza.pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 3;
```
---
##  Revenue Over Time

```
SELECT order_month,
       total_revenue,
       SUM(total_revenue) OVER (ORDER BY order_month) AS cumulative_revenue
FROM (
    SELECT DATE_TRUNC('month', date) AS order_month,
           SUM(p.price * od.quantity) AS total_revenue
    FROM pizza.order_details od
    JOIN pizza.orders o ON od.order_id = o.order_id
    JOIN pizza.pizzas p ON p.pizza_id = od.pizza_id
    GROUP BY 1
) AS ct;
```
---
## Top 3 Pizzas per Category
```
WITH pizza_category AS (
    SELECT pt.category,
           pt.name,
           SUM(p.price * od.quantity) AS total_revenue
    FROM pizza.order_details od
    JOIN pizza.pizzas p ON od.pizza_id = p.pizza_id
    JOIN pizza.pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
    GROUP BY pt.category, pt.name
)
SELECT *
FROM (
    SELECT category,
           name,
           total_revenue,
           DENSE_RANK() OVER (PARTITION BY category ORDER BY total_revenue DESC) AS ranking
    FROM pizza_category
) AS ct
WHERE ranking <= 3;
```
---
## Hourly Order Distribution
```
SELECT EXTRACT(HOUR FROM time) AS order_hour,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza.orders
GROUP BY 1
ORDER BY total_orders DESC;
```
---
## 📁 Repository Structure
```
SQL-Queries/      # All SQL scripts, numbered
Dashboards/       # Power BI & Excel dashboards
Screenshots/      # Charts and visualizations
README.md         # Project summary and insights
