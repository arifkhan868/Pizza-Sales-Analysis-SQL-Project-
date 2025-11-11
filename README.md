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
