-- Q1
select ProductID, Name, Color, ListPrice 
from Production.Product

-- Q2
select ProductID, Name, Color, ListPrice 
from Production.Product
where ListPrice != 0

-- Q3
select ProductID, Name, Color, ListPrice 
from Production.Product
where Color is null

-- Q4
select ProductID, Name, Color, ListPrice 
from Production.Product
where Color is not null

-- Q5
select ProductID, Name, Color, ListPrice 
from Production.Product
where Color is not null and ListPrice > 0

-- Q6
select Name + ' ' +  Color
from Production.Product
where Color is not null

-- Q7
select 'NAME: ' + Name + ' -- COLOR: ' +  Color
from Production.Product
where (Color = 'Black' or Color = 'Silver')
and (Name like '%Crankarm' or Name like 'Chainring%')

-- Q8
select ProductID, Name
from Production.Product
where ProductID BETWEEN 400 AND 500

-- Q9
select ProductID, Name, Color, ListPrice 
from Production.Product
where Color in ('black', 'blue')

-- Q10
select *
from Production.Product
where Name like 'S%'

-- Q11
select Name, ListPrice
from Production.Product
where Name like 'Seat%' or Name in ('Short-Sleeve Classic Jersey, L', 'Short-Sleeve Classic Jersey, M')
and ListPrice in (0.00,53.99)
order by Name

-- Q12
select Name, ListPrice
from Production.Product
where Name like 'A%' or Name like 'Seat%'
and ListPrice in (0.00,159.00,8.99)
order by Name

-- Q13
select *
from Production.Product
where Name like 'SPO[^k][a-z]%'
order by Name

-- Q14
select distinct Color
from Production.Product
where Color is not null
order by Color desc

-- Q15
select distinct ProductSubcategoryID, Color 
from Production.Product
where ProductSubcategoryID is not null and Color is not null
order by Color desc