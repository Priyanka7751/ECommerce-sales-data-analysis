-- Created new database 
CREATE DATABASE E_Commerce

SELECT TOP 1 * FROM Customer
SELECT TOP 1 * FROM Product
SELECT TOP 1 * FROM Orders
SELECT TOP 1 * FROM OrderItem
SELECT TOP 1 * FROM Supplier

--1. List all customers

SELECT * FROM Customer

--2. List all countries of customers

SELECT DISTINCT A.Country FROM Customer AS A

--3. List all Supplier countries

SELECT DISTINCT A.Country AS Supplier_Countries FROM Supplier AS A

--4. List the customers in Sweden.

SELECT * FROM Customer AS A
WHERE A.Country = 'SWEDEN'

--5. List the number of customers in each country.  SELECT A.Country, COUNT(A.Id) AS CUST_CNT FROM Customer AS A GROUP BY A.Country ORDER BY CUST_CNT DESC--6. Average order value per customerSELECT A.CustomerId,AVG(A.TotalAmount) AS AVG_ORDER_VALUEFROM Orders AS AGROUP BY A.CustomerId--7. List the total amount for items ordered by each customer.  SELECT A.CustomerId,SUM(A.TotalAmount) AS TOTAL_AMT FROM Orders AS A GROUP BY A.CustomerId--8.List the number of customers in each country. Only include countries with more than 10 customers.
  SELECT A.Country, COUNT(A.Id) AS CUST_CNT FROM Customer AS A GROUP BY A.Country HAVING COUNT(A.Id) > 10--9. List all suppliers in the 'USA', 'Japan', and 'Germany', ordered by country from A-Z, and then by company name in reverse order.  SELECT * FROM Supplier AS A WHERE A.Country IN ('USA','JAPAN','GERMANY') ORDER BY A.Country, A.CompanyName DESC--10. List of Most Ordered Products (by quantity)  SELECT B.ProductName,SUM(A.Quantity) AS Total_Units_Sold FROM OrderItem AS A INNER JOIN Product AS B ON A.ProductId=B.Id GROUP BY B.ProductName ORDER BY Total_Units_Sold DESC --11. Show all orders, sorted by total amount (the largest amount first), within each year.SELECT *,YEAR(A.OrderDate) AS YEAR_FROM Orders AS AORDER BY YEAR_,A.TotalAmount DESC--12. List top 10 most expensive products.SELECT TOP 10 * FROM Product AS AORDER BY A.UnitPrice DESC--13. Get Sales Trend by Month Across All YearsSELECT YEAR(A.OrderDate) AS Year_, MONTH(A.OrderDate) AS Month_,SUM(A.TotalAmount) AS Total_SalesFROM Orders AS A GROUP BY YEAR(A.OrderDate),MONTH(A.OrderDate)ORDER BY YEAR(A.OrderDate),MONTH(A.OrderDate)--14. Get the 10th to 15th most expensive products sorted by price.SELECT * FROM(            SELECT * ,            DENSE_RANK() OVER(ORDER BY UNITPRICE DESC) AS RANK_            FROM PRODUCT AS A			) AS TWHERE T.RANK_ BETWEEN 10 AND 15--15. Write a query to get the number of supplier countries.SELECT COUNT(DISTINCT A.Country) AS TOTAL_SUPPLIER_COUNTRIESFROM Supplier AS A--16. Find the total sales cost in each month of the year 2013.SELECT MONTH(A.OrderDate) AS MONTH_,SUM(A.TotalAmount) AS TOTAL_SALESFROM Orders AS AINNER JOIN OrderItem AS BON A.Id = B.OrderIdWHERE YEAR(A.OrderDate) = 2013GROUP BY MONTH(A.OrderDate)ORDER BY MONTH_--17. There are some suppliers without fax numbers. We have to get a list of suppliers  
--with remark as "No fax number" for suppliers who do not have fax numbers (fax numbers might be null or blank). 
--Also, Fax number should be displayed for customer with fax numbers.SELECT *,CASE WHEN Fax IS NULL OR LEN(FAX) = 0 THEN 'NO FAX NUMBER'ELSE Fax END AS FAX_UPDATEDFROM Supplier AS A--18. List all orders, their orderDates with product names, quantities, and prices.SELECT A.Id,A.OrderDate,A.TotalAmount,C.ProductName,B.Quantity,B.UnitPrice FROM Orders AS AINNER JOIN OrderItem AS BON A.Id = B.OrderIdINNER JOIN Product AS CON B.ProductId = C.Id--19. Number of Products Supplied per Supplier CountrySELECT S.Country, COUNT(DISTINCT P.Id) AS Product_CountFROM Product AS PINNER JOIN Supplier AS SON P.SupplierId=S.IdGROUP BY S.Country--20. List all customers who have not placed any OrdersSELECT A.* FROM Customer AS ALEFT JOIN Orders AS BON A.Id = B.CustomerIdWHERE B.Id IS NULL--21. Check Customer Retention by listing First vs. Repeat OrdersSELECT A.CustomerId,COUNT(*) AS TotalOrders,CASE WHEN COUNT(*)=1 THEN 'First-Time' ELSE 'Repeat' END AS OrderTypeFROM ORDERS AS AGROUP BY A.CustomerId--22. List suppliers that have no customers in their country,
--and customers that have no suppliers in their country, 
--and customers and suppliers that are from the same country. 

SELECT A.FirstName,A.LastName,A.Country AS Cust_country,
b.Country AS Supplier_country, b.CompanyName
FROM Customer AS A
FULL JOIN Supplier AS B
ON A.Country = B.Country
WHERE A.Country IS NULL
UNION ALL
SELECT A.FirstName,A.LastName,A.Country AS Cust_country,
b.Country AS Supplier_country, b.CompanyName
FROM Customer AS A
FULL JOIN Supplier AS B
ON A.Country = B.Country
WHERE B.Country IS NULL
UNION ALL
SELECT A.FirstName,A.LastName,A.Country AS Cust_country,
b.Country AS Supplier_country, b.CompanyName
FROM Customer AS A
FULL JOIN Supplier AS B
ON A.Country = B.Country
WHERE A.Country = B.Country--23. Suppose we would like to see the last OrderID and the OrderDate for this 
--last order that was shipped to 'Paris'. Along with that information, 
--say we would also like to see the OrderDate for the last order shipped 
--regardless of the Shipping City. In addition to this, we would also like 
--to calculate the difference in days between these two OrderDates that you get. 

SELECT * ,
DATEDIFF(DAY,LASTPARISORDER,LASTORDERDATE) AS DAY_DIFF
FROM(

            SELECT MAX(A.Id) AS LASTORDERID,MAX(A.OrderDate) AS LASTPARISORDER,
            (SELECT MAX(C.OrderDate) FROM Orders AS C) AS LASTORDERDATE
            FROM Orders AS A
            INNER JOIN Customer AS B
            ON A.CustomerId = B.Id
            WHERE B.City = 'PARIS'
			) AS T

--24. Find those customer countries who do not have suppliers.
--This might help you provide better delivery time to customers by adding suppliers
--to these countires.

SELECT DISTINCT A.Country FROM Customer AS A
WHERE A.Country NOT IN (SELECT DISTINCT B.Country FROM Supplier AS B)

--25. Suppose a company would like to do some targeted marketing where it would 
--contact customers in the country with the fewest number of orders.
--It is hoped that this targeted marketing will increase the overall sales in the 
--targeted country. You are asked to write a query to get all details of such 
--customers from top 5 countries with fewest numbers of orders.SELECT A.Country,A.Id AS CUST_ID,COUNT(B.Id) AS ORDER_CNTFROM Customer AS AINNER JOIN Orders AS BON A.Id = B.CustomerIdWHERE A.Country IN (SELECT TOP 5 A.Country                     FROM Customer AS A                     INNER JOIN Orders AS B                     ON A.Id = B.CustomerId                     GROUP BY A.Country                     ORDER BY SUM(B.TotalAmount) DESC					 )GROUP BY A.Country,A.IdHAVING COUNT(B.Id) <= 7ORDER BY ORDER_CNT--26. Display the top two customers, based on the total dollar amount
--associated with their orders, per country. The dollar amount is 
--calculated as OI.unitprice * OI.Quantity * (1 -OI.Discount).
--You might want to perform a query like this so you can reward these customers, --since they buy the most per country.SELECT * FROM (                 SELECT *,                 DENSE_RANK() OVER(PARTITION BY COUNTRY ORDER BY TOTAL_AMT DESC) AS RANK_                 FROM (                                             SELECT C.Country,B.CustomerId, SUM(A.UnitPrice*A.Quantity*(1-A.Discount)) AS TOTAL_AMT                            FROM OrderItem AS A                            INNER JOIN Orders AS B                            ON A.OrderId = B.Id                            INNER JOIN Customer AS C                            ON B.CustomerId = C.Id                            GROUP BY C.Country,B.CustomerId                 		   ) AS T						) AS T1WHERE T1.RANK_ <=2