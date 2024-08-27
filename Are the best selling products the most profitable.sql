select top 10 d.ProductID,
		c.[Name],
		p.StandardCost ProductCost,
		sum(OrderQty) AmountQNTY,
		(d.LineTotal / d.OrderQty) - p.StandardCost as PureProfitPerUnit,
		sum(LineTotal) TotalPrice
		
from Sales.SalesOrderDetail d join
Production.Product p
on d.ProductID = p.ProductID
join Production.ProductSubcategory sc
on p.ProductSubcategoryID = sc.ProductSubcategoryID
join Production.ProductCategory c
on sc.ProductCategoryID = c.ProductCategoryID
group by d.ProductID, (d.LineTotal / d.OrderQty) - p.StandardCost,
		p.StandardCost, c.[Name]
--order by PureProfitPerUnit desc -- for top 10 profit products
order by sum(OrderQty) desc
 
 /*
 finding the top 10 best selling products
 calculating the pure profit - after discount and purchase price
 */

