--Q1
(select City, CompanyName as Name, ContactName as [Contact Name], 'Supplier' as Type 
from dbo.Suppliers)
union
(select City, CompanyName as Name, ContactName as [Contact Name], 'Customer' as Type 
from dbo.Customers)
order by city

--Q2a
select distinct city
from Customers
where City not in (select distinct City from Employees)
order by city

--Q2b
select distinct c.city
from Customers c full join Employees e on c.City = e.City
where e.City is null
order by c.city

--Q3
select p.ProductName, sum(od.Quantity) as totalQualities
from [Order Details] od inner join Orders o on od.OrderID = o.OrderID
inner join Products p on p.productId = od.ProductID
group by p.ProductID, p.ProductName

--Q4
select o.ShipCity, sum(od.Quantity) as totalQualities
from [Order Details] od inner join Orders o on od.OrderID = o.OrderID
where o.ShipCity in (select distinct city from Customers)
group by o.ShipCity

--Q5a
SELECT distinct City 
FROM Customers 
EXCEPT SELECT City FROM Customers Group By City HAVING Count(*) = 1 
UNION SELECT City FROM Customers Group By City HAVING Count(*) = 0

--Q5b
SELECT distinct City 
FROM Customers 
where city not in  
(SELECT City FROM Customers Group By City HAVING Count(*) < 2)

--Q6
select c.city
from Customers c inner join 
(select distinct o.ShipCity, od.ProductID from [Order Details] od inner join Orders o on od.OrderID = o.OrderID) orderProduct
on c.city = orderProduct.ShipCity
group by c.city
having count(*) > 2

--Q7 
select distinct c.CustomerID, c.CompanyName, o.ShipCity
from Customers c inner join Orders o on c.CustomerID = o.CustomerID
where c.city != o.ShipCity

--Q8
-- solution 1
-- using rank
with topFiveProducts
as
(
select top 5 p.ProductID as productID, sum(od.Quantity*od.UnitPrice*(1-od.Discount))/sum(od.UnitPrice) as price
from [Order Details] od inner join Products p on od.ProductID = p.ProductID
group by p.ProductID
order by sum(od.Quantity*od.UnitPrice*(1-od.Discount))/sum(od.UnitPrice) desc
)
select ProductID, price,name
from
(select t.productID as productID, t.price as price, c.CompanyName as name, (rank() over (partition by o.CustomerID order by sum(od.Quantity) desc)) as rank
from (topFiveProducts t inner join [Order Details] od on t.productID	= od.ProductID
inner join Orders o on od.OrderID  = o.OrderID
inner join Customers c on o.CustomerID = c.CustomerID)
group by t.productID, t.price,o.CustomerID,c.CompanyName) as ranking
where rank = 1
order by productID

--Q9a
select city
from Employees
where city not in (select distinct ShipCity from Orders)

--Q9b
select e.city
from Employees e left join Orders o on e.city = o.ShipCity
where o.ShipCity is null

--Q10

select city1.ShipCity
from
(
	select shipCity
	from
	(
		select ShipCity, count(*) as totalOrder, rank() over(order by count(orderID) desc) as rank
		from Orders
		group by ShipCity
	) as orderCount
	where rank = 1
) as city1
inner join
(
	select shipCity
	from
	(
		select o.ShipCity, sum(od.quantity) as totalProduct, rank() over(order by sum(od.quantity) desc) as rank
		from Orders o inner join [Order Details] od on o.OrderID = od.OrderID
		group by o.ShipCity) as orderCount
		where rank = 1
	) city2
on city1.ShipCity = city2.ShipCity

--Q11
-- reference: https://docs.microsoft.com/en-us/troubleshoot/sql/database-design/remove-duplicate-rows-sql-server-tab

--DELETE T
--FROM
--(
--SELECT *
--, DupRank = ROW_NUMBER() OVER (
--              PARTITION BY key_value
--              ORDER BY (SELECT NULL)
--            )
--FROM original_table
--) AS T
--WHERE DupRank > 1 

-- function ROW_NUMBER() will return the number of duplicate row of current row
-- after that, all we need to do is delete those duplicate from the datebase












