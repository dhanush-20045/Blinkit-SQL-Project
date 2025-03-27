CREATE DATABASE CASE_STUDY1;
USE CASE_STUDY1;
--TASKS
--1. Display the number of states present in theLocationTable
select count(distinct(state)) from Location1

--2. 
select count(product) from Product1 where type='regular'

--3) 

Select SUM(Marketing) as Spending from Fact11 where ProductId=1

--4)

select min(sales) from fact11

--5) 
select max(cogs) from fact11

--6) 
Select * from Product1 where Product_Type = 'Coffee'

--7)
select * from fact11 where Total_Expenses>40 order by Total_Expenses

--8)
select avg(sales) from fact11 where Area_Code=719

--9) 
Select State,SUM(Profit) as Profit from Fact11
join
Location1
on 
Fact11.Area_Code= Location1.Area_Code
group by State
having State ='Colorado'

or

Select State,SUM(Profit) as Profit from Fact11
join
Location1
on 
Fact11.Area_Code= Location1.Area_Code
where State ='Colorado'
group by State

--10) 
Select ProductId, AVG(Inventory) as Average_Inventory from Fact11 
group by ProductId order by ProductId

--11) 

Select Distinct(State) from Location1 order by State

-- 12) 

select productid,avg(budget_margin) from fact11 
group by Budget_Margin,ProductId
having avg(budget_margin)>100


--13) 

select date,sum(sales) as sum_of_sales from fact11 group by date having date='2010-01-01'

--14)
Select ProductId, Date, AVG(Total_Expenses) as Average_Total_Expenses 
from Fact11 group by ProductId, Date order by productId asc,date desc


--15)

Select Date, P.productid, product_type, product, Sales, profit, state, L.area_code from 
Fact11 F
inner join
Product1 P
on F.ProductId = P.ProductId
inner join
Location1 L
on F.Area_Code = L.Area_Code
--16
select *, rank()over(order by sales)as saleswise_rank from fact11
--17
select l.state,sum(f.profit)as profit,sum(f.sales)as sales from Location1 as l join fact11 as f on l.Area_Code=f.Area_Code group by l.state
--18.
 
 select l.state,p.product,sum(f.profit)as profit,sum(f.sales)as sales from Location1 as l join fact11 as f on l.Area_Code=f.Area_Code
 join Product1 as p on p.ProductId=f.ProductId group by l.State,p.Product
 --19
select sales ,sales*1.05 as increased_sales from fact11
--20
select p.Product_Type,f.productid,max(f.profit)as maxprofit from fact11 as f join product1 as p on f.ProductId=p.ProductId group by p.Product_Type,f.ProductId 
order by maxprofit desc
--21
create procedure usp_result
 (
 @producttype varchar(50)
 )
 as
 begin
 
 select * from Product where Product_Type=@producttype
 end
 
 execute usp_result 'coffee'


 --22
select *, profit_cloumn=
 case
 when total_expenses< 60 then 'profit'
 else 'loss'
 end
  from fact11
  --23
select date,datepart(week,date) as sales_week, sum(sales) as total_weeklysales,productid from fact11 group by  rollup(date,datepart(week,date),ProductId)
 order by date,datepart(week,date),ProductId
 --24
 select Area_Code  from fact11 
 union
 select Area_Code from Location1

 select area_code from fact11
 intersect
 select area_code from location1
 --25
 create function udf_product
 (
 @product_type varchar(50)
 )
 returns table
 as
 return
 (
 select * from Product1 where product_type=@product_type
 )    
 
 select * from dbo.udf_product('herbal tea')
 --26
 begin transaction
 update product1 set Product_Type='tea' where ProductId=1 and Product_Type='coffee'
 rollback transaction

 select*from Product1
 --27
 select date,productid,sales,Total_Expenses from fact11 where Total_Expenses between 100 and 200
 --28
delete from Product1 where type='regular'
 select*from Product1
 --29
 select ASCII(SUBSTRING(Product, 5, 1)) as ASCII_Value
from Product1