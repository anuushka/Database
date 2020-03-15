--task 1
SELECT p.name, p.Color, p.Size
from [Production].[Product] as p

--task 2
SELECT p.Name, p.Color, p.Size
from  [Production].[Product] as p
WHERE p.ListPrice > 100

--task 3
SELECT p.Name, p.Color, p.Size
from [Production].[Product] as p
WHERE p.ListPrice  < 100 and p.Color = 'Black'

--task 4
SELECT p.Name, p.Color, p.Size
FROM [Production].[Product] as p
WHERE p.ListPrice < 100 and p.Color = 'Black'
order by p.ListPrice asc

--task 5
SELECT top 3 p.Name, p.Size, p.color, p.ListPrice
from [Production].[product] as p
WHERE p.color = 'Black'
order by p.ListPrice desc

--task 6
Select p.Name, p.Color
from [Production].[Product] as p
WHERE p.Color is not NULL and p.Size is not NULL

--task 7
SELECT DISTINCT p.Color
from [Production].[Product] as p
WHERE p.ListPrice >= 10 and p.ListPrice <= 5

--task 8
SELECT p.Color
FROM [Production].[Product] as p 
WHERE p.Name like 'L%' and p.Name like '__N%'

--task 9
SELECT p.Name
from [Production].[Product] as p
where p.name like '[DM]%' and len(p.Name) > 3

--task 10
SELECT p.Name, p.SellStartDate
from [Production].[Product] as p 
where p.SellStartDate < '2012-01-01'

--task 11
SELECT p.Name
from [Production].[ProductSubcategory] as p

--task 12
SELECT p.Name
from [Production].[ProductCategory] as p

--task 13
SELECT per.Title, per.FirstName, per.MiddleName, per.LastName
from [Person].[Person] as per
WHERE per.Title = 'Mr.'

--task 14
SELECT per.Title, per.FirstName, per.MiddleName, per.LastName
FROM [Person].[Person] as per
WHERE per.Title is NULL





