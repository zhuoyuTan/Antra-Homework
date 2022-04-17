--Q1
--Drop view  if exists view_product_order_tan;

create view view_product_order_tan
as
select p.ProductName, sum(od.Quantity) as totalQuantity
from Products p inner join [Order Details] od on p.ProductID = od.ProductID
group by p.ProductID, p.ProductName;


--Q2
--Drop proc if exists sp_product_order_quantity_tan;

create proc sp_product_order_quantity_tan
@id int,
@quantities int out
as 
begin
select @quantities= sum(od.Quantity)
from Products p inner join [Order Details] od on p.ProductID = od.ProductID
where p.ProductID = @id
end;

--begin 
--declare @out int
--exec sp_product_order_quantity_tan 1, @out out
--print @out
--end

--Q3
--select *
--from Products
--order by ProductName

--drop proc sp_product_order_city_tan

create proc sp_product_order_city_tan
@name varchar(20)
as 
begin
select top 5 c.City, sum(od.Quantity) as totalQuantities
from Products p inner join [Order Details] od on p.ProductID = od.ProductID
inner join Orders o on od.OrderID = o.OrderID
inner join Customers c on o.CustomerID = c.CustomerID
where @name = p.ProductName
group by c.City
order by sum(od.Quantity) desc
end

--exec sp_product_order_city_tan [Alice Mutton]

--Q4

--step 1: create table city and people

--drop table if exists city_tan

create table city_tan(
Id int primary key,
City varchar(255) unique not null 
)

--drop table if exists people_tan

create table people_tan(
Id int primary key,
Name varchar(255) not null, 
City int foreign key references city_tan(Id)
)

--step 2: insert values

insert into city_tan values(1,'Seattle')
insert into city_tan values(2,'Green Bay')


insert into people_tan values(1,'Aaron Rodgers',2)
insert into people_tan values(2,'Russell Wilson',1)
insert into people_tan values(3,'Jody Nelson',2)

select *
from city_tan

select *
from people_tan

-- step 3: remove city of seattle
-- because people table refering city table's id instead name, so we can change 'seattle' to 'Madison' indirectly

update city_tan
set city = 'Madison'
where City = 'seattle'

--step 4: create view Packers
create view Packers_Zhuoyu_Tan
as
select name
from people_tan p inner join city_tan c on p.city = c.Id
where c.City = 'Green Bay'

select *
from Packers_Zhuoyu_Tan

--step 5: drop table and view

--drop view first, then people for reference integrity 
drop view if exists Packers_Zhuoyu_Tan
drop table if exists people_tan
drop table if exists city_tan


--Q5
drop proc if exists sp_birthday_employees_tan
create proc sp_birthday_employees_tan
as 
begin
select distinct FirstName + ' ' + LastName as name
from Employees
where month(BirthDate) = 2
end

exec sp_birthday_employees_tan
--screenshot
--https://github.com/zhuoyuTan/Antra-Homework/blob/main/A4Q5%20screenshot.png

--Q6

-- step 1: check if two tables have same number of rows using count() function, if not, they do not have same data
-- step 2: select any data from table 1 is in table using subquery and 'not in', if the output is not empty, the are not the same
