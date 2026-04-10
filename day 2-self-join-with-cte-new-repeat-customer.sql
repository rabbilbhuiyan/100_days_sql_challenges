/*
You are working on an e-commerce platform (Amazon-like).
Every day:
Customers place orders
Some customers are new (first-time buyers)
Some customers are repeat buyers
🎯 Goal
For each day, find:
Number of new customers
Number of repeat customers
*/

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000);


select * from customer_orders;

/* find the total new customer and repeat customer for each day of orders*/
with first_visit as (
	select 
		customer_id,
		min(order_date) as first_visit_day
	from customer_orders
	group by customer_id)
	
select  
	co.order_date, 
	sum(case when co.order_date = fv.first_visit_day then 1 else 0 end) as new_customers,
	sum(case when co.order_date != fv.first_visit_day then 1 else 0 end) as repeat_customers
from customer_orders co 
inner join first_visit fv
on co.customer_id = fv.customer_id
group by co.order_date
