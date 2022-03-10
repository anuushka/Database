/*
--WARMUP
Select s.Name, s.ProductSubcategoryID
FROM [Production].[ProductSubcategory] s

SELECT p.Name, s.Name
FROM [Production].[product] p JOIN
[Production].[ProductSubcategory] s
ON p.ProductSubcategoryID = s.ProductSubcategoryID

SELECT p.Name, s.Name
FROM [Production].[product] p LEFT JOIN
[Production].[ProductSubcategory] s
ON p.ProductSubcategoryID = s.ProductSubcategoryID

SELECT p.Name, s.Name
FROM [Production].[product] p RIGHT JOIN
[Production].[ProductSubcategory] s
ON p.ProductSubcategoryID = s.ProductSubcategoryID

SELECT p.Name, s.Name
FROM [Production].[product] p FULL JOIN
[Production].[ProductSubcategory] s
ON p.ProductSubcategoryID = s.ProductSubcategoryID

--PRACTICE
--1
SELECT p1.Name, p2.Name, p1.ProductID, p2.ProductSubcategoryID
FROM [Production].[Product] p1 JOIN
[Production].[ProductSubcategory] p2
ON p1.ProductID != p2.ProductSubcategoryID

--2
SELECT p.Name, PSC.Name
FROM [Production].[Product] as P INNER JOIN
[Production].[ProductSubcategory] AS PSC
ON p.ProductSubcategoryID = PSC.ProductSubcategoryID
WHERE [ListPrice] > 100

--3
SELECT p.Name, PC.Name
FROM [Production].[Product] as P INNER JOIN
[Production].[ProductSubcategory] as PSC
ON p.ProductSubcategoryID = PSC.ProductSubcategoryID
INNER  JOIN [Production].[ProductCategory] as PC
ON PSC.ProductCategoryID = PC.ProductCategoryID

--4
SELECT p.Name, p.ListPrice, PV.LastReceiptCost
FROM [Production].[Product] as p INNER JOIN
[Purchasing].[ProductVendor] as PV
ON p.ProductID = PV.ProductID

--5
SELECT p.Name, p.ListPrice, PV.LastReceiptCost
FROM [Production].[Product] as P INNER JOIN
[Purchasing].[ProductVendor] as PV
ON p.ProductID = PV.ProductID
WHERE p.ListPrice != 0 AND p.ListPrice < PV.LastReceiptCost

--6
SELECT COUNT(DISTINCT PV.ProductID)
FROM [Purchasing].[ProductVendor] as PV INNER JOIN
[Purchasing].[Vendor] AS V
ON PV.BusinessEntityID = V.BusinessEntityID
WHERE V.CreditRating = 1

--7
SELECT [CreditRating], COUNT(DISTINCT PV.ProductID)
FROM [Purchasing].[ProductVendor] as PV INNER JOIN
[Purchasing].[Vendor] as V
ON V.BusinessEntityID = PV.BusinessEntityID
GROUP BY [CreditRating]

--8
SELECT TOP 3 p.ProductSubcategoryID, COUNT(*) as 'Count'
FROM [Production].[Product] as p JOIN
[Production].[ProductSubcategory] as PSC
ON p.ProductSubcategoryID = PSC.ProductSubcategoryID
GROUP BY p.ProductSubcategoryID
ORDER BY COUNT(*) DESC

--9
SELECT TOP 3 psc.Name, COUNT(*)
FROM [Production].[Product] as p INNER JOIN
[Production].[ProductSubcategory] as psc
ON p.ProductSubcategoryID = psc.ProductSubcategoryID
GROUP BY p.ProductSubcategoryID, psc.Name
ORDER BY COUNT(*) DESC

SELECT TOP 3 psc.Name, COUNT(*) as 'COUNT'
FROM [Production].[ProductSubcategory] as PSC INNER JOIN
[Production].[Product] as p
ON p.ProductSubcategoryID = PSC.ProductSubcategoryID INNER JOIN
[Production].[ProductCategory] as PC
ON PC.ProductCategoryID = PSC.ProductCategoryID
GROUP BY PC.ProductCategoryID, psc.Name
ORDER BY COUNT(*) DESC

--10
SELECT 1.0*COUNT(*)/COUNT(DISTINCT [ProductSubCategoryID])
FROM [Production].[Product]
WHERE [ProductSubcategoryID] is NOT NULL

SELECT CAST(COUNT(*) AS FLOAT) / COUNT(DISTINCT [ProductSubCategoryID])
FROM [Production].[Product]
WHERE [ProductSubcategoryID] is not NULL

SELECT CAST((CAST(COUNT(p.ProductID) as FLOAT) / COUNT(DISTINCT p.ProductSubCategoryID))
as decimal(6,3))
FROM [Production].[Product] as p
WHERE p.ProductSubcategoryID is not null

--11
SELECT COUNT(*)/COUNT(DISTINCT PSC.ProductSubcategoryID)
FROM [Production].[ProductSubcategory] as PSC INNER JOIN
[Production].[Product] as P
ON PSC.ProductSubcategoryID = P.ProductSubcategoryID
RIGHT JOIN [Production].[ProductCategory] as PC
ON PSC.ProductSubcategoryID = PC.ProductCategoryID

--12
SELECT PC.ProductCategoryID, COUNT(DISTINCT [Color]) as 'Count'
FROM [Production].[Product] as P INNER JOIN
[Production].[ProductSubcategory] as PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
RIGHT JOIN [Production].[ProductCategory] as PC
ON PC.ProductCategoryID = PSC.ProductCategoryID
GROUP BY PC.ProductCategoryID

--13
SELECT AVG(ISNULL([Weight],10))
FROM [Production].[Product]

--14
SELECT [Name], [SellStartDate], [SellEndDate],
DATEDIFF(D, [SellStartDate], ISNULL([SellEndDate],GETDATE()))
FROM [Production].[Product]
WHERE [SellStartDate] is not NULL

--15
SELECT LEN([Name]) as 'Name Length', COUNT(*) as 'Number of products'
FROM [Production].[Product]
GROUP BY LEN([Name])

--16
SELECT PV.BusinessEntityID, COUNT(DISTINCT p.ProductSubCategoryID) as 'ProductSubCategoryID'
FROM [Production].[Product] as p INNER JOIN
[Purchasing].[ProductVendor] as PV
ON p.ProductID = PV.ProductID
WHERE p.ProductSubcategoryID is NOT NULL
GROUP BY PV.BusinessEntityID

--17
SELECT p1.Name
FROM [Production].[Product] as p1 JOIN
[Production].[Product] as p2
ON p1.Name = p2.Name AND
p1.ProductID != p2.ProductID

--17v2
SELECT [Name]
FROM [Production].[Product]
GROUP BY [ProductID],[Name]
HAVING COUNT(*) > 1

--18
SELECT TOP 10 WITH TIES [Name]
FROM [Production].[Product]
ORDER BY [ListPrice] DESC

--19
SELECT TOP 10 Percent WITH TIES [Name]
FROM [Production].[Product]
ORDER BY [ListPrice] desc

--20
SELECT TOP 3 WITH TIES PV.BusinessEntityID, COUNT(P.ProductID) as 'COUNT'
FROM [Production].[Product] as P JOIN
[Purchasing].[ProductVendor] as PV
ON PV.ProductID = P.ProductID
GROUP BY PV.[HELLO HEY]
ORDER BY COUNT(P.ProductID) DESC

--EXERCISES
--1
SELECT P.Name as 'Product Name', PC.Name as 'Category Name'
FROM [Production].[Product] as P JOIN
[Production].[ProductSubcategory] as PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
JOIN [Production].[ProductCategory] as PC
ON PSC.ProductCategoryID = PC.ProductCategoryID
WHERE P.Color = 'Red' AND P.ListPrice > 100

--2
SELECT PSC1.Name
FROM [Production].[ProductSubcategory] as PSC1,
[Production].[ProductSubCategory] as PSC2
WHERE PSC1.Name = PSC2.Name AND
PSC1.ProductSubCategoryID != PSC2.ProductSubCategoryID

--3
SELECT PSC.Name, COUNT(*) as 'COUNT'
FROM [Production].[ProductSubcategory] as PSC JOIN
[Production].[Product] as P
ON PSC.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY(PSC.Name)

--4
SELECT PSC.Name, COUNT(P.ProductID) as 'Count'
FROM [Production].[Product] as P INNER JOIN
[Production].[ProductSubcategory] as PSC
ON PSC.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY PSC.Name, PSC.ProductSubcategoryID
HAVING COUNT(PSC.Name) > 1

--5
SELECT * FROM [PRODUCTION.PRODUCT];

--6
SELECT PSC.Name, P.Color, MAX(StandardCost) as 'MAX price'
FROM [Production].[Product] as P JOIN
[Production].[ProductSubcategory] as PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
WHERE P.Color = 'Red'
GROUP BY PSC.Name, P.Color

--7
SELECT V.Name, COUNT(P.ProductID) as 'Count'
FROM [Purchasing].[Vendor] as V JOIN
[Purchasing].[ProductVendor] as PV
ON V.BusinessEntityID = PV.BusinessEntityID JOIN
[Production].[Product] as P
ON P.ProductID = PV.ProductID
GROUP BY V.Name

--8
SELECT P.Name, COUNT(*)
FROM [Purchasing].[ProductVendor] as PV JOIN
[Production].[Product] as P
ON PV.ProductID = P.ProductID
GROUP BY P.Name
HAVING COUNT(*) > 1

--9
SELECT TOP 1 P.Name, COUNT(*)
FROM [Production].[Product] as P JOIN
[Purchasing].[ProductVendor] as PV
ON P.ProductID = PV.ProductID
GROUP BY P.Name
ORDER BY COUNT(*) DESC

--10
SELECT TOP 1 PC.Name
FROM [Production].[ProductSubcategory] as PSC JOIN
[Production].[Product] as P
ON PSC.ProductSubcategoryID = P.ProductSubcategoryID JOIN
[Production].[ProductCategory] as PC
ON PSC.ProductCategoryID = PC.ProductCategoryID JOIN
[Purchasing].[ProductVendor] as PPV
ON PPV.ProductID = P.ProductID
GROUP BY PC.Name
ORDER BY COUNT(*) DESC
*/
--12
--credit rating no, product id count with this credit rating
SELECT CreditRating, COUNT(ProductID) as 'Product Count'
FROM [Purchasing].[ProductVendor] as PPV JOIN
[Purchasing].[Vendor]  as PV
ON PPV.BusinessEntityID = PV.BusinessEntityID
GROUP BY CreditRating