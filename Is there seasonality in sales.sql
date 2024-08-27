with OrderProfits as (
    select 
        h.OrderDate,
        (d.LineTotal / d.OrderQty) - p.StandardCost as PureProfit, -- calculate the pure profit
        case 
            when month(h.OrderDate) IN (12, 1, 2) then 'Winter'
            when month(h.OrderDate) IN (3, 4, 5) then 'Spring'
            when month(h.OrderDate) IN (6, 7, 8) then 'Summer'
            when month(h.OrderDate) IN (9, 10, 11) then 'Fall'
        end as Season --devision to seasons
    from Sales.SalesOrderHeader h
    join Sales.SalesOrderDetail d
    on h.SalesOrderID = d.SalesOrderID
    join Production.Product p
    on p.ProductID = d.ProductID
) -- use 2 joins to conact bewtten 3 tables with the desire columns

select 
    Season,
    sum(PureProfit) as TotalProfit, 
	YEAR(OrderProfits.OrderDate) YearC
from OrderProfits
group by Season , YEAR(OrderProfits.OrderDate)
order by YearC desc, TotalProfit

-- the profit for each year, each year divided into seasons
