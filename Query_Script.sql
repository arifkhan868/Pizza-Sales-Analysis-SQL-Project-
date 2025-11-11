

create schema pizza;

create table pizza.orders
(
order_id int ,	
date timestamp,	
time time 
);

create table pizza.pizzas
(
pizza_id varchar,	
pizza_type_id varchar,	
size varchar,	
price float
);
create table pizza.pizza_types
(
pizza_type_id varchar,	
name varchar,	
category varchar,	
ingredients varchar
);

create table pizza.order_details
(
order_details_id int,	
order_id int,	
pizza_id varchar,	
quantity int
);


-- Basic:
-- Retrieve the total number of orders placed.
select 
count(distinct order_id) as total_order
from pizza.orders
;
select 
sum(quantity) as total_order
from pizza.order_details
;
-- Calculate the total revenue generated from pizza sales.
select 
sum(ps.price * od.quantity) as total_revenue
from pizza.pizzas ps 
join 
pizza.order_details od 
on od.pizza_id = ps.pizza_id
;
-- Identify the highest-priced pizza.
select 
*
from pizza.pizzas 
order by price desc 
limit 1 
;
-- Identify the most common pizza size ordered.
select 
p."size",
count(o.order_id) as total_order
from pizza.orders o 
join 
pizza.order_details od 
on o.order_id = od.order_id
join 
pizza.pizzas p 
on od.pizza_id = p.pizza_id 
group by 1 
order by 2 desc 
;
-- List the top 5 most ordered pizza types along with their quantities.
select 
pt."name",
sum(od.quantity) as total_quantity
from pizza.order_details od
join 
pizza.pizzas p 
on p.pizza_id = od.pizza_id
join 
pizza.pizza_types pt 
on pt.pizza_type_id = p.pizza_type_id 
group by 1 
order by 2 desc 
limit 5 
;

-- Intermediate:
-- Join the necessary tables to find the total quantity of each pizza category ordered.
select 
pt.category,
sum(quantity) as total_quantity
from pizza.order_details od 
join 
pizza.pizzas p 
on od.pizza_id = p.pizza_id
join 
pizza.pizza_types pt
on pt.pizza_type_id = p.pizza_type_id 
group by 1 
;
-- Determine the distribution of orders by hour of the day.
select 
extract (hour from time ) as per_day_hour,
count(distinct order_id) as total_order
from pizza.orders 
group by 1 
order by 2 desc 
;
-- Join relevant tables to find the category-wise distribution of pizzas.
select 
category,
count(name) as count_pizza_name
from pizza.pizza_types 
group by 1 
;
-- Group the orders by date and calculate the average number of pizzas ordered per day.
select 
avg(total_quantity) as avg_order_per_day
from 
(select 
o.date ,
sum(od.quantity) as total_quantity
from pizza.orders o
join 
pizza.order_details od 
on o.order_id = od.order_id
group by 1 ) as ct 
;

-- Determine the top 3 most ordered pizza types based on revenue.
select 
pt."name",
sum(p.price * od.quantity) as total_revenue
from pizza.order_details od 
join 
pizza.pizzas p 
on p.pizza_id = od.pizza_id
join 
pizza.pizza_types pt  
on pt.pizza_type_id = p.pizza_type_id 
group by 1 
order by 2 desc 
limit 3 
;
-- Advanced:
-- Calculate the percentage contribution of each pizza type to total revenue.

select 
pt.category,
(sum(p.price * od.quantity))/ 
(select sum(p.price*od.quantity) from pizza.order_details od join pizza.pizzas p 
on p.pizza_id = od.pizza_id join pizza.pizza_types pt on pt.pizza_type_id = p.pizza_type_id)*100 as revenue_contribution 
from pizza.order_details od 
join 
pizza.pizzas p 
on od.pizza_id = p.pizza_id
join 
pizza.pizza_types pt 
on pt.pizza_type_id = p.pizza_type_id 
group by 1 
;

-- Analyze the cumulative revenue generated over time.
select 
order_month,
total_revenue,
sum(total_revenue) over(order by order_month desc) as cumulative_revenue
from 
(select 
date_trunc('month', date) as order_month ,
sum(p.price * od.quantity) as total_revenue 
from pizza.order_details od 
join 
pizza.orders o 
on od.order_id = o.order_id
join 
pizza.pizzas p 
on p.pizza_id = od.pizza_id
group by 1 ) as ct 
;
-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
with pizza_category as (
select 
pt.category,
pt."name",
sum(p.price * od.quantity) as total_revenue
from pizza.order_details od 
join 
pizza.pizzas p 
on od.pizza_id = p.pizza_id
join 
pizza.pizza_types pt 
on pt.pizza_type_id = p.pizza_type_id 
group by 1 ,2 )
select 
*
from 
(select 
category,
name,
total_revenue,
DENSE_RANK () over (partition by category order by total_revenue desc ) as ranking 
from pizza_category) as ct
where ranking <= 3 
;








