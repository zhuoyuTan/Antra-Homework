
--Q1
-- 504 products
select *
from production.Product

--Q2
select count(*) as numOfProducts
from production.Product
where ProductSubcategoryID is not null

--Q3
select ProductSubcategoryID, count(*) as CountedProducts
from production.Product
where ProductSubcategoryID is not null
group by ProductSubcategoryID

--Q4
select count(*) as numOfProducts
from production.Product
where ProductSubcategoryID is null

--Q5
select sum(quantity) as quantity 
from production.ProductInventory 

--Q6
select ProductID,quantity as TheSum
from production.ProductInventory 
where LocationID = 40 and quantity < 100

--Q7
select ProductID,quantity as TheSum
from production.ProductInventory 
where LocationID = 40 and quantity < 100 and Shelf != 'N/A'

--Q8
select avg(Quantity) as average
from production.ProductInventory 
where LocationID = 10 

--Q9
select ProductID,Shelf,avg(Quantity) as TheAvg
from production.ProductInventory 
group by ProductID,Shelf

--Q10
select ProductID,Shelf,avg(Quantity) as TheAvg
from production.ProductInventory 
where Shelf != 'N/A'
group by ProductID,Shelf

--Q11
select Color, Class, count(*) as TheCount, avg(listPrice) as AvgPrice
from production.Product 
where Color is not null and Class is not null
group by Color, Class

--Q12
select c.name as Country, s.name as Province
from person.CountryRegion c inner join person.StateProvince s
on c.CountryRegionCode = s.CountryRegionCode
order by c.name

--Q13
select c.name as Country, s.name as Province
from person.CountryRegion c inner join person.StateProvince s
on c.CountryRegionCode = s.CountryRegionCode
where c.name in ('Germany','Canada')
order by c.name

--Q14
select distinct p.ProductName
from dbo.Orders o inner join dbo.[Order Details] od on o.OrderID = od.OrderID
inner join dbo.Products p on od.ProductID = p.ProductID
where DATEDIFF(year,CURRENT_TIMESTAMP,o.OrderDate) < 25

--Q15
select top 5 o.ShipPostalCode
from dbo.Orders o inner join dbo.[Order Details] od on o.OrderID = od.OrderID
where o.ShipPostalCode is not null
group by o.ShipPostalCode
order by sum(od.Quantity) desc

--Q16
select top 5 o.ShipPostalCode
from dbo.Orders o inner join dbo.[Order Details] od on o.OrderID = od.OrderID
where DATEDIFF(year,CURRENT_TIMESTAMP,o.OrderDate) < 25 and o.ShipPostalCode is not null
group by o.ShipPostalCode
order by sum(od.Quantity) desc

--Q17
select City, count(*) as numOfCustomer
from dbo.Customers
group by City

--Q18
select City, count(*) as numOfCustomer
from dbo.Customers
group by City
having count(*) > 2

--Q19
select c.ContactName
from dbo.Orders o inner join dbo.Customers c on o.CustomerID = c.CustomerID
where DATEDIFF(day, o.OrderDate, '1998/01/01') > 0

--Q20
select c.ContactName
from dbo.Orders o inner join dbo.Customers c on o.CustomerID = c.CustomerID
where o.OrderDate = (select max(OrderDate) from dbo.Orders)

--Q20
select c.ContactName
from dbo.Orders o inner join dbo.Customers c on o.CustomerID = c.CustomerID
where o.OrderDate = (select max(OrderDate) from dbo.Orders)

--Q21
select c.ContactName, sum(od.Quantity) as countOfProducts
from dbo.Orders o inner join dbo.Customers c on o.CustomerID = c.CustomerID
inner join dbo.[Order Details] od on od.OrderID = o.OrderID
group by c.CustomerID,c.ContactName

--Q22
select c.ContactName, sum(od.Quantity) as countOfProducts
from dbo.Orders o inner join dbo.Customers c on o.CustomerID = c.CustomerID
inner join dbo.[Order Details] od on od.OrderID = o.OrderID
group by c.CustomerID,c.ContactName
having sum(od.Quantity) > 100

--Q23
select sup.CompanyName as [Supplier Company Name ], shi.CompanyName [Shipping Company Name]
from dbo.Suppliers sup inner join dbo.Products p on sup.SupplierID = p.SupplierID
inner join dbo.[Order Details] od on p.ProductID = od.ProductID
inner join dbo.Orders o on od.OrderID = o.OrderID
inner join dbo.Shippers shi on shi.ShipperID = o.ShipVia
group by sup.CompanyName, shi.CompanyName
order by sup.CompanyName

--Q24
select cast(o.OrderDate as date) as orderDate, p.ProductName
from dbo.Products p 
inner join dbo.[Order Details] od on p.ProductID = od.ProductID
inner join dbo.Orders o on od.OrderID = o.OrderID
group by cast(o.OrderDate as date),p.ProductName
order by cast(o.OrderDate as date)

--Q25
select e1.FirstName + ' ' + e1.LastName as Name1, e2.FirstName + ' ' + e2.LastName as Name2
from dbo.Employees e1 inner join dbo.Employees e2
on e1.Title = e2.Title and e1.EmployeeID != e2.EmployeeID

--Q26 
select (select FirstName + ' ' + LastName from dbo.Employees where e1.EmployeeID = EmployeeID) as Name, count(*) as ReporterCount
from dbo.Employees e1 inner join dbo.Employees e2
on e1.EmployeeID = e2.ReportsTo
group by e1.EmployeeID
having count(*) > 2

--Q27
(select City, CompanyName as Name, ContactName as [Contact Name], 'Supplier' as Type 
from dbo.Suppliers)
union
(select City, CompanyName as Name, ContactName as [Contact Name], 'Customer' as Type 
from dbo.Customers)
order by city
