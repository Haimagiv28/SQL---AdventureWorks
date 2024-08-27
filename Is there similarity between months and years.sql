with OrderProfits as (
    select 
        h.SalesOrderID,
        (d.LineTotal / d.OrderQty) - p.StandardCost as PureProfit,
        datepart(year, h.OrderDate) as YearOfSale,
        datepart(month, h.OrderDate) as MonthOfSale
    from Sales.SalesOrderHeader h
    join Sales.SalesOrderDetail d on h.SalesOrderID = d.SalesOrderID
    join Production.Product p on p.ProductID = d.ProductID
) -- cte use for import info like month and year, use 2 joins to conact bewtten 3 tables with the desire columns

select 
    YearOfSale,
    MonthOfSale,
    sum(PureProfit) as TotalProfit -- sum the profit of any month from any year
from OrderProfits
group by YearOfSale, MonthOfSale
order by YearOfSale, MonthOfSale; -- order begin from 2012 to 2014, betwwen any year all the months
