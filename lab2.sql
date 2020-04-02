/*1*/
SELECT [Color], [ListPrice], COUNT(*) as 'Amount'
FROM [Production].[Product]
WHERE [ListPrice] >= 30 
GROUP BY [Color], [ListPrice]
Order by [ListPrice] ASC

/*2*/
SELECT [Color], MIN([ListPrice]) as 'Minimum Price'
FROM [Production].[Product]
GROUP BY [Color]
HAVING MIN([ListPrice]) > 100

/*3*/
SELECT [ProductSubcategoryID], COUNT(*) as 'Amount'
FROM [Production].[Product]
GROUP BY [ProductSubcategoryID]
ORDER BY [ProductSubcategoryID]

/*4*/
SELECT [ProductID], COUNT(LineTotal) as 'Sales Fact'
FROM [Sales].[SalesOrderDetail]
GROUP BY [ProductID] 

/*5*/
SELECT [ProductID], COUNT([LineTotal]) as 'Sales Fact'
FROM [Sales].[SalesOrderDetail] 
GROUP BY [ProductID]
HAVING COUNT([LineTotal]) > 5
ORDER BY COUNT([LineTotal]) ASC 

/*6*/
SELECT [CustomerID], COUNT([SalesOrderID]) as 'Sales Order'
FROM [Sales].[SalesOrderHeader]
GROUP BY [CustomerID], [OrderDate]
HAVING COUNT([SalesOrderID]) > 1  

/*7*/
SELECT [SalesOrderID], COUNT([ProductID]) as 'Number of Products'
FROM [Sales].[SalesOrderDetail]
GROUP BY [SalesOrderID]
HAVING COUNT([ProductID]) > 3
ORDER BY COUNT(*) ASC
 
/*8*/
SELECT [ProductID], COUNT([SalesOrderID]) as 'Sales ID'
FROM [Sales].[SalesOrderDetail]
GROUP BY [ProductID]
HAVING COUNT([SalesOrderID]) > 3
ORDER BY COUNT(*) ASC 

/*9*/
SELECT [ProductID], COUNT([SalesOrderID]) as 'Sales ID'
FROM [Sales].[SalesOrderDetail]
GROUP BY [ProductID]
HAVING COUNT(SalesOrderID) in (3,5)
ORDER BY COUNT(*) ASC

/*10*/
SELECT [ProductSubcategoryID], COUNT([ProductID]) as 'Number of Products'
FROM [Production].[Product]
GROUP BY [ProductSubcategoryID]
HAVING COUNT([ProductID]) > 10
ORDER BY COUNT(*) ASC

/*11*/
SELECT [ProductID], [OrderQty]
FROM [Sales].[SalesOrderDetail]
WHERE [OrderQty] = 1
GROUP BY [ProductID], [OrderQty]
ORDER BY [ProductID]

/*12*/
SELECT TOP 1 [SalesOrderID], 
COUNT([ProductID]) as 'Number of products'
FROM [Sales].[SalesOrderDetail]
GROUP BY [SalesOrderID]
ORDER BY COUNT(*) DESC 

/*13*/
SELECT TOP 1 [SalesOrderID], [UnitPrice], [OrderQty]
FROM [Sales].[SalesOrderDetail]
GROUP BY [SalesOrderID], [UnitPrice], [OrderQty]
ORDER BY COUNT(*) DESC 

/*14*/
SELECT [ProductSubcategoryID], COUNT(*) as 'Product Count'
FROM [Production].[Product]
WHERE [ProductSubcategoryID] is NOT NULL and [Color] is NOT NULL
GROUP BY [ProductSubcategoryID]

/*15*/
SELECT [Color], COUNT(*) as 'Count'
FROM [Production].[Product]
WHERE [Color] is not NULL
GROUP BY [Color]
ORDER BY COUNT(*) DESC 

/*16*/
SELECT [ProductID], COUNT(*) as 'Product Count'
FROM [Sales].[SalesOrderDetail]
WHERE [OrderQty] > 1 
GROUP BY [ProductID]
HAVING COUNT(*) > 2
ORDER BY [ProductID] ASC


