select * from [finance_transactions csv]

select * from [customers csv]

-------------------------------------------

--1. Total Transactions
select count(*) as total_transactions from [finance_transactions csv]

--2. Total Customers
select count(*) as total_customers from [customers csv]

--3. Average Csutomer Age
select avg(age) as avg_age_customers from [customers csv]

--4. Total Transaction Amount 
select concat('₹ ',round(sum(amount)/1000000,2),' Million') as total_transactional_amount from [finance_transactions csv]

--5. Total Fees Collected 
select concat('₹ ',round(sum(fee_amount)/1000000,2),' Million') as total_fees_amount from [finance_transactions csv]

--6. Total Tax Amount
select sum(tax_amount) as total_tax_amount from [finance_transactions csv]

--7. Total Transaction Amount 
select round(avg(amount),2) as avg_transactional_amount from [finance_transactions csv]

--8. Average Annual Income 
select round(avg(annual_income),2) as avg_annual_income from [customers csv]

--9. Successful Transactions
select count(*) as total_successful_transaction from [finance_transactions csv]
where transaction_status = 'Success'

--10. Fraud Amount
select concat('₹ ', round(sum(amount)/1000000,2), ' Million') as total_fraud_amount from [finance_transactions csv]
where is_fraud = 'Yes'

--11. Success Rate %
select 
cast(count(case when transaction_status = 'Success' then 1
end)*100/count(*) as decimal(10,2)) as success_rate
from [finance_transactions csv]

--12. Fraud Rate %
select 
cast(count(case when is_fraud = 'Yes' then 1
end)*100/count(*) as decimal(10,2)) as fraud_rate
from [finance_transactions csv]

--13. Monthly Transaction Amount
select 
year(transaction_date)as year_, datename(month,transaction_date) as month_name, round(sum(amount),2) as amount
from [finance_transactions csv]
group by year(transaction_date), month(transaction_date), datename(month,transaction_date)
order by year(transaction_date), month(transaction_date)

--14. Transaction Status Distribution
select 
transaction_status, count(*) as total_transations_status
from [finance_transactions csv] 
group by transaction_status 
order by count(*)

--15. Transaction Type Analysis 
select 
transaction_type, count(*) as total_transations_type,
round(sum(amount),2) as amount
from [finance_transactions csv] 
group by transaction_type
order by count(*)

--16. Customer by state
select
state, count(*) as customers_by_state
from[customers csv]
group by state
order by count(*) desc

--17. Customers by Occupation 
select
occupation, count(*) as customers_by_occupation
from[customers csv]
group by occupation
order by count(*) desc

--18. Customer Segment Distribution
select
customer_segment, count(*) as customers_by_customer_segment
from[customers csv]
group by customer_segment
order by count(*) desc

--19. Age Group Analysis 
select min(age), max(age) from[customers csv]
select 
CASE
    when age <= 30 then 'Below 30'
    when age > 31 and age <= 40 then '31-40'
    when age > 41 and age <= 50 then '41-50'
    when age > 51 and age <= 60 then '51-60'
    else 'Above 60'
    end as age_group,
count(*) as total_customers
from[customers csv]
group by
CASE
    when age <= 30 then 'Below 30'
    when age > 31 and age <= 40 then '31-40'
    when age > 41 and age <= 50 then '41-50'
    when age > 51 and age <= 60 then '51-60'
    else 'Above 60'
    end
order by count(*)

--20. Top 10 Highest Transactions 
select top 10 
transaction_id, transaction_date, transaction_status, amount
from [finance_transactions csv] 
order by amount desc 

--21. Top 10 customers by transaction amount
select top 10 
ft.transaction_id, ft.transaction_date, ft.transaction_status, c.customer_id, c.customer_name, ft.amount
from [finance_transactions csv] as ft
left join [customers csv] as c
on ft.customer_id = c.customer_id
order by amount desc 

--22. Monthly Revenue by Customer Segment 
select 
customer_segment, datename(month,transaction_date) as month_name, sum(amount + fee_amount + tax_amount) as revenue from [finance_transactions csv] as ft
left join [customers csv] as c
on ft.customer_id = c.customer_id
group by customer_segment, year(transaction_date), month(transaction_date), datename(month,transaction_date)
order by customer_segment, year(transaction_date), month(transaction_date), datename(month,transaction_date)

--23. Transaction Amount by Gender
select 
gender, round(sum(amount),2) as transaction_amount
from [finance_transactions csv] as ft
left join [customers csv] as c
on ft.customer_id = c.customer_id
group by gender

--24. Revenue by Customer Segment
select 
customer_segment, round(sum(amount + fee_amount + tax_amount),2) as revenue
from [finance_transactions csv] as ft
left join [customers csv] as c
on ft.customer_id = c.customer_id
group by customer_segment

--25. Top States by Transaction Amount
select top 1
state, sum(amount) as amount
from [finance_transactions csv] as ft
left join [customers csv] as c
on ft.customer_id = c.customer_id
group by state
order by sum(amount) desc

--26. Top 10 Cities by Revenue
select 
city, round(sum(amount + fee_amount + tax_amount),2) as revenue
from [finance_transactions csv] as ft
left join [customers csv] as c
on ft.customer_id = c.customer_id
group by city

--27. Age Group Wise Revenue 
select
CASE
    when age <= 30 then 'Below 30'
    when age > 31 and age <= 40 then '31-40'
    when age > 41 and age <= 50 then '41-50'
    when age > 51 and age <= 60 then '51-60'
    else 'Above 60'
    end as age_group, round(sum(amount + fee_amount + tax_amount),2) as revenue
from [finance_transactions csv] as ft
left join [customers csv] as c
on ft.customer_id = c.customer_id
group by CASE
    when age <= 30 then 'Below 30'
    when age > 31 and age <= 40 then '31-40'
    when age > 41 and age <= 50 then '41-50'
    when age > 51 and age <= 60 then '51-60'
    else 'Above 60'
    end






