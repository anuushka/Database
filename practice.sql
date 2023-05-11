SELECT [Name], [ListPrice], [Color]
FROM [Production].[Product]
WHERE [color] is not NULL

SELECT p.Name, p.ListPrice, p.Color
FROM [Production].[Product] as p 
Where p.color is not null

SELECT COUNT([Color])
FROM [Production].[Product]
WHERE [COLOR] is not null

SELECT COUNT(*)
FROM [Production].[Product]
WHERE [Color] is not null

SELECT MAX([ListPrice])
FROM [Production].[product]
WHERE [Color] = 'Red'

SELECT [Color], COUNT(*) as 'Amount'
FROM [Production].[Product]
WHERE [Color] is not NULL
GROUP BY [Color]

SELECT [Name], [Color], COUNT(*) as 'Amount'
FROM [Production].[Product]
WHERE [Color] is not NULL
GROUP BY [Color]  /* ERROR */

SELECT [Name], [Color], COUNT(*) as 'Amount'
FROM [Production].[Product]
WHERE [Color] is not NULL
GROUP BY [Color], [Name] 

SELECT [Color], [Style], COUNT(*) as 'Amount'
FROM [Production].[Product]
WHERE [Color] is NOT NULL AND [STYLE] IS NOT NULL
GROUP BY [Color], [STYLE]

SELECT [Color], COUNT(*) as 'Amount'
FROM [Production].[product]
WHERE [Color] is not NULL
GROUP BY [Color] 
HAVING COUNT(*) > 10

SELECT [COLOR], COUNT(*) as 'Amount'
FROM [Production].[Product]
WHERE [Color] is not NULL
GROUP BY [Color]
HAVING COUNT(*) > 10 AND MAX([ListPrice]) > 3000

SELECT [Color], COUNT(*) as 'Amount'
FROM [Production].[product] 
GROUP BY [Color]
HAVING [Color] is not NULL

SELECT [Color], COUNT(*) as 'Amount'
FROM [Production].[product]
WHERE [Color] is not NULL
GROUP BY [Color]

SELECT [Color], [Style], [Class], COUNT(*)
FROM [Production].[product]
GROUP BY [Color], [Style], [Class]

SELECT [Color], [Style], [Class], COUNT(*) as 'Amount'
FROM [Production].[Product]
GROUP BY ROLLUP([Color], [Style], [Class]) 
/* ROLLUP calculates grandtotal of 
1. Sum1 of color, style, (class doesn't matter)
2. Add new column with Sum1
3. Sum2 of color only (style, class doesn't matter) 
4. Add new column with Sum2 */

SELECT [Color], [Size], COUNT(*) as 'Amount'
FROM [Production].[Product]
GROUP BY GROUPING SETS(([Color]), ([Size]))

SELECT LEN([NAME]), COUNT(*)
FROM [Production].[Product]
GROUP BY LEN([Name])

/* ---------------------PB SETS------------------------*/

SELECT [ProductSubcategoryID]
FROM [Production].[Product]
WHERE [ProductSubcategoryID] IS NOT NULL
GROUP BY [ProductSubcategoryID]
ORDER BY COUNT(*) DESC

SELECT TOP 3 WITH TIES [ProductSubCategoryID]
FROM [Production].[Product]
WHERE [ProductSubcategoryID] IS NOT NULL
GROUP BY [ProductSubcategoryID]
ORDER BY COUNT(*) DESC

SELECT LEN([Name]), COUNT(*)
FROM [Production].[Product]
GROUP BY LEN([Name])

SELECT([Name])
FROM [Production].[Product]
GROUP BY [ProductID], [Name]
HAVING COUNT(*) > 1

