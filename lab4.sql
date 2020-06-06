--Part 1. WARMUP

/* the most expensive product with color 'Red' */
SELECT MAX([ListPrice]) 
FROM [Production].[Product]
WHERE [Color] = 'Red'

/* product with color red and price 3578.27 */
SELECT [Name], [ListPrice], [Color]
FROM [Production].[Product]
WHERE [Color] = 'Red'  AND [ListPrice] = 3578.27

/* color red and price the most expensive among color red products*/
SELECT [Name]
FROM [Production].[Product]
WHERE [Color] = 'Red' AND [ListPrice] = (SELECT MAX([ListPrice]) FROM [Production].[Product]
WHERE [Color] = 'Red')

/* color != red and price == ANY red color product */
SELECT [Name]
FROM [Production].[Product]
WHERE [Color] != 'Red' and [ListPrice] = ANY (SELECT [ListPrice] FROM [Production].[Product] 
WHERE [Color] = 'Red')

/* product list with price more than ALL products with color red */
SELECT [Name]
FROM [Production].[Product]
WHERE [ListPrice] > ALL (SELECT [ListPrice] FROM [Production].[Product]
WHERE [Color] = 'Red')

/*  color1 == color2 products with price2 > 3000 */
SELECT [Name]
FROM [Production].[Product]
WHERE [Color] IN (SELECT [Color] FROM [Production].[Product]
WHERE [ListPrice] > 3000)

/* Category Name with the most expensive product */
SELECT [Name]
FROM [Production].[ProductCategory]
WHERE [ProductCategoryID] IN (SELECT [ProductCategoryID] FROM [Production].[ProductSubcategory]
WHERE [ProductSubcategoryID] IN (SELECT [ProductSubcategoryID] FROM [Production].[Product]
WHERE [ListPrice] = (SELECT MAX([ListPrice]) FROM [Production].[Product])))

/* Products with color and style matching the most expensive product */
SELECT [Name]
FROM [Production].[Product]
WHERE [Color] IN (SELECT [Color] FROM [Production].[Product] WHERE [ListPrice] = (SELECT MAX([ListPrice])
FROM [Production].[Product]))
AND
[Style] IN (SELECT [Style] FROM [Production].[Product] WHERE [ListPrice] = (SELECT MAX([ListPrice]) 
FROM [Production].[Product]))

/*GROUP BY HAVING. Find Subcategory ID with the most products */
SELECT [ProductSubCategoryID]
FROM [Production].[Product]
GROUP BY [ProductSubcategoryID]
HAVING COUNT(*) = (SELECT TOP 1 COUNT(*) FROM [Production].[Product] 
GROUP BY [ProductSubcategoryID] ORDER BY 1 DESC)

/* List of most expensive products from subcategory. Three methods: hard, correlated, connected */
SELECT [Name], [ListPrice]
FROM [Production].[Product] as P1
WHERE [ListPrice] = (SELECT MAX([ListPrice]) FROM [Production].[Product] as P2
WHERE P1.ProductSubcategoryID = P2.ProductSubcategoryID)

--Part 2. Examples with solutions

/*Subcategory ID with max number of products, except null products*/
--1
SELECT [Name]
FROM [Production].[ProductSubcategory]
WHERE [ProductSubcategoryID] IN (SELECT [ProductSubcategoryID] FROM [Production].[Product] 
	WHERE [ProductSubcategoryID] IS NOT NULL
	GROUP BY [ProductSubcategoryID]
	HAVING COUNT(*) = (SELECT TOP 1 COUNT(*) FROM [Production].[Product] WHERE [ProductSubcategoryID] is not NULL
	GROUP BY [ProductSubcategoryID] ORDER BY 1 DESC))

--2 Customer who bought each product with different amount, so he always had the same sales list
--2.1
SELECT [CustomerID], COUNT(*)
FROM [Sales].[SalesOrderHeader] as SOH1
GROUP BY [CustomerID]
HAVING COUNT(*) > 1 AND COUNT(*) = ALL
(SELECT COUNT(*) FROM [Sales].[SalesOrderHeader] as SOH JOIN
[Sales].[SalesOrderDetail] as SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.CustomerID, SOD.ProductID
HAVING SOH.CustomerID = SOH1.CustomerID)

--2.2
SELECT SOH.CustomerID, p.Name
FROM [Sales].[SalesOrderHeader] as SOH JOIN
[Sales].[SalesOrderDetail] as SOD
ON SOH.SalesOrderID = SOD.SalesOrderID JOIN
Production.Product as p
ON SOD.ProductID = p.ProductID
WHERE SOH.CustomerID IN (SELECT [CustomerID] FROM [Sales].[SalesOrderHeader] as SOH1
GROUP BY [CustomerID]
HAVING COUNT(*) > 1 AND COUNT(*) = ALL
(SELECT COUNT(*) FROM [Sales].[SalesOrderHeader] as SOH JOIN
[Sales].[SalesOrderDetail] as SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.[CustomerID], SOD.ProductID
HAVING SOH.CustomerID = SOH1.CustomerID))
ORDER BY 1

--2.3
SELECT SOH1.CustomerID
FROM [Sales].[SalesOrderDetail] as SOD1 JOIN
[Sales].[SalesOrderHeader] as SOH1
ON SOD1.SalesOrderID = SOH1.SalesOrderID
GROUP BY SOH1.CustomerID
HAVING COUNT(SOH1.SalesOrderID) > 1 AND COUNT(DISTINCT SOD1.ProductID) > 1
AND COUNT(DISTINCT SOD1.ProductID) = ALL
(
SELECT COUNT(*) FROM [Sales].[SalesOrderDetail] as SOD2 JOIN
[Sales].[SalesOrderHeader] as SOH2
ON SOD2.SalesOrderID = SOH2.SalesOrderID 
GROUP BY SOH2.CustomerID, SOD2.SalesOrderID
HAVING SOH2.CustomerID = SOH1.CustomerID
)

--3 Product name, count of customers buying the product,  count of customers not buying the product
SELECT p.[ProductID],
(SELECT COUNT(DISTINCT SOH.CustomerID)
FROM [Sales].[SalesOrderDetail] as SOD JOIN
[Sales].[SalesOrderHeader] as SOH 
ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE SOD.ProductID = p.ProductID),
(SELECT COUNT(DISTINCT SOH.CustomerID)
FROM [Sales].[SalesOrderDetail] as SOD JOIN
[Sales].[SalesOrderHeader] as SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE SOH.CustomerID NOT IN
(SELECT DISTINCT SOH.CustomerID
FROM [Sales].[SalesOrderDetail] as SOD JOIN
[Sales].[SalesOrderHeader] as SOH
ON SOD.SalesOrderID = SOH.SalesOrderID WHERE
SOD.ProductID = p.ProductID))
FROM [Production].[Product] as p

--4 Products bought by different customers where these customers bought these products from one subcategory
SELECT Name
FROM [Production].[Product]
WHERE ProductID IN
(SELECT SOD.ProductID
FROM [Sales].[SalesOrderDetail] as SOD JOIN
[Sales].[SalesOrderHeader] as SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE SOH.CustomerID IN
(SELECT SOH.CustomerID 
FROM [Sales].[SalesOrderDetail] as SOD JOIN
[Sales].[SalesOrderHeader] as SOH
ON SOH.SalesOrderID = SOD.SalesOrderID JOIN
[Production].[Product] as P ON
SOD.ProductID = P.ProductID
GROUP BY SOH.CustomerID
HAVING COUNT(DISTINCT P.ProductSubcategoryID) = 1)
GROUP BY SOD.ProductID 
HAVING COUNT(DISTINCT SOH.CustomerID)>1)

--5 Customers with different check each time
SELECT DISTINCT CustomerID
FROM [Sales].[SalesOrderHeader] 
WHERE CustomerID NOT IN
(SELECT SOH.CustomerID
FROM [Sales].[SalesOrderDetail] as SOD JOIN
[Sales].[SalesOrderHeader] as SOH 
ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE EXISTS(SELECT ProductID FROM [Sales].[SalesOrderDetail] as SOD1 JOIN
[Sales].[SalesOrderHeader] as SOH1
ON SOD.SalesOrderID = SOH.SalesOrderID 
WHERE SOH1.CustomerID = SOH.CustomerID AND
SOD1.ProductID = SOD.ProductID AND SOD.SalesOrderID != SOH.SalesOrderID))

--6 Products bought by only one customer, not by others.
--6.1
SELECT SOH1.CustomerID
FROM [Sales].[SalesOrderDetail] as SOD1 JOIN
[Sales].[SalesOrderHeader] as SOH1
ON SOD1.SalesOrderID = SOH1.SalesOrderID
GROUP BY SOH1.CustomerID
HAVING COUNT(DISTINCT SOD1.ProductID) = 
(SELECT COUNT(DISTINCT SOD.ProductID)
FROM [Sales].[SalesOrderDetail] as SOD JOIN
[Sales].[SalesOrderHeader] as SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE SOH.CustomerID = SOH1.CustomerID
AND SOD.ProductID IN
(SELECT SOD.ProductID FROM [Sales].[SalesOrderDetail] as SOD JOIN
[Sales].[SalesOrderHeader] as SOH
ON SOD.SalesOrderID = SOH.SalesOrderID 
GROUP BY SOD.ProductID
HAVING COUNT(DISTINCT SOH.CustomerID) = 1))

--6.2
SELECT DISTINCT SOH.CustomerID
FROM [Sales].[SalesOrderHeader] as SOH
WHERE SOH.CustomerID NOT IN (
SELECT DISTINCT SOH.CustomerID 
FROM [Sales].[SalesOrderDetail] as SOD JOIN
[Sales].[SalesOrderHeader] as SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE ProductID NOT IN (
SELECT SOD.ProductID
FROM [Sales].[SalesOrderDetail] as SOD JOIN
[Sales].[SalesOrderHeader] as SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
GROUP BY SOD.ProductID
HAVING COUNT(DISTINCT SOH.CustomerID)= 1 ))












