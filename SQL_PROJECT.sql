/*See all the data imported:
--SELECT * FROM Blinkit_data;

A) DATA CLEANING:
Cleaning the Item_Fat_Content field ensures data consistency and accuracy in analysis. 
The presence of multiple variations of the same category (e.g., LF, low fat vs. Low Fat) can cause issues in reporting, aggregations, and filtering. 
By standardizing these values, we improve data quality, making it easier to generate insights and maintain uniformity in our datasets.
 
UPDATE blinkit_data
SET Item_Fat_Content = 
    CASE 
        WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN Item_Fat_Content = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END;

After executing this query check the data has been cleaned or not using below query
	
	SELECT DISTINCT Item_Fat_Content FROM blinkit_data;

B)KPI’s
1) TOTAL SALES BY LOCATION AND OUTLET EASTABLISHMENT YEAR

SELECT 
	Outlet_Location_Type,
	outlet_Establishment_year,
	CAST(SUM(Total_Sales) / 1000000.0 AS DECIMAL(10,2)) AS Total_Sales_Million
FROM blinkit_data
GROUP BY 
	Outlet_Location_Type, 
	outlet_Establishment_year
ORDER BY 
	Outlet_Location_Type,
	outlet_Establishment_year;

2) AVERAGE SALES BY LOCATION AND OUTLET EASTABLISHMENT YEAR

SELECT 
	Outlet_Location_Type,
	outlet_Establishment_year,
	CAST(AVG(Total_Sales) AS INT) AS Avg_Sales
FROM blinkit_data
GROUP BY 
	Outlet_Location_Type,
	outlet_Establishment_year
ORDER BY 
	Outlet_Location_Type,
	outlet_Establishment_year;

3) NO OF ITEMS

SELECT 
	COUNT(*) AS No_of_Orders
FROM blinkit_data;

4) AVG RATING BASED ON SPECIFIC YEARS AND OUTLET TYPE
SELECT 
	Outlet_Type,
	Outlet_Establishment_Year,
	CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Rating
FROM blinkit_data
GROUP BY 
	Outlet_Type,
	Outlet_Establishment_Year
ORDER BY 
	Outlet_Establishment_Year,
	Outlet_Type

5) Total Sales by Fat Content:
SELECT 
	Item_Fat_Content, 
	CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Item_Fat_Content

6) Total Sales by Item Type
SELECT 
	Item_Type, 
	CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC

7) Fat Content by Outlet for Total Sales
SELECT Outlet_Location_Type, 
       ISNULL([Low Fat], 0) AS Low_Fat, 
       ISNULL([Regular], 0) AS Regular
FROM 
(
    SELECT Outlet_Location_Type, Item_Fat_Content, 
           CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
    FROM blinkit_data
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT 
(
    SUM(Total_Sales) 
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;

8) Percentage of Sales by Outlet Size
SELECT 
    Outlet_Size, 
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

9) All Metrics by Outlet Type:
SELECT 
	Outlet_Establishment_Year,
	Outlet_Type, 
	CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
	CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
	COUNT(*) AS No_Of_Items,
	CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
	CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Avg_Item_Visibility
FROM blinkit_data
GROUP BY 
	Outlet_Establishment_Year,
	Outlet_Type
ORDER BY Total_Sales DESC

10) TOP 5 BEST SELLING PRODUCTS
WITH ItemSales AS (
    SELECT 
        item_identifier, 
        item_Type, 
        SUM(Total_sales) AS Total_Sales,
        RANK() OVER (ORDER BY SUM(Total_sales) DESC) AS Sales_Rank
    FROM Blinkit_data
    GROUP BY Item_Identifier, Item_Type
)
SELECT Item_Identifier, Item_Type, Total_Sales, Sales_Rank
FROM ItemSales
WHERE Sales_Rank <= 5;





	




