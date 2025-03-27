# 📊 Blinkit SQL Analysis  

## 📌 Project Overview  
This project analyzes **Blinkit Grocery Sales Data** using **MS SQL Server** to perform **data cleaning, transformation, and KPI analysis**.  
The dataset includes details about **product sales, outlet locations, establishment years, fat content, and customer ratings**.  

By leveraging SQL queries, we extract valuable insights to enhance **business decision-making** and **sales strategy**.  

---

## 🛠️ Tools & Technologies Used  
- **🗄️ Database:** Microsoft SQL Server  
- **📄 Query Language:** SQL  
- **📊 Data Processing:** SQL Aggregations, Joins, Window Functions, CTEs  
- **🔍 Data Cleaning:** Standardization, Null Handling  
- **📉 Data Analysis:** KPI Computation, Sales Insights, Trend Analysis  

---

## 📜 Project Objectives  
✔️ **Data Cleaning** – Standardizing and correcting inconsistencies in dataset.  
✔️ **Total & Average Sales Analysis** – Analyzing sales based on outlet locations and establishment years.  
✔️ **Best-Selling Products** – Identifying top-performing products based on total sales.  
✔️ **Outlet Performance Metrics** – Evaluating outlet sales based on size, location, and type.  
✔️ **Customer Ratings Analysis** – Finding average ratings per outlet type and year.  

---

## 📝 SQL Queries & Key Insights  

### **1️⃣ Data Cleaning – Standardizing Item_Fat_Content**  
```sql
UPDATE blinkit_data  
SET Item_Fat_Content =  
    CASE  
        WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'  
        WHEN Item_Fat_Content = 'reg' THEN 'Regular'  
        ELSE Item_Fat_Content  
    END;
### **2️⃣ KPI: Total Sales by Location & Establishment Year
sql
Copy
Edit
SELECT  
    Outlet_Location_Type,  
    outlet_Establishment_year,  
    CAST(SUM(Total_Sales) / 1000000.0 AS DECIMAL(10,2)) AS Total_Sales_Million  
FROM blinkit_data  
GROUP BY Outlet_Location_Type, outlet_Establishment_year  
ORDER BY Outlet_Location_Type, outlet_Establishment_year;
✅ Provides insights into revenue generation based on location type and establishment year.

3️⃣ KPI: Best-Selling Products (Top 5)
sql
Copy
Edit
WITH ItemSales AS (  
    SELECT  
        Item_Identifier,  
        Item_Type,  
        SUM(Total_Sales) AS Total_Sales,  
        RANK() OVER (ORDER BY SUM(Total_Sales) DESC) AS Sales_Rank  
    FROM Blinkit_data  
    GROUP BY Item_Identifier, Item_Type  
)  
SELECT Item_Identifier, Item_Type, Total_Sales, Sales_Rank  
FROM ItemSales  
WHERE Sales_Rank <= 5;
✅ Identifies top 5 highest-selling products, helping the business focus on best-performing items.

4️⃣ KPI: Percentage of Sales by Outlet Size
sql
Copy
Edit
SELECT  
    Outlet_Size,  
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,  
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage  
FROM blinkit_data  
GROUP BY Outlet_Size  
ORDER BY Total_Sales DESC;
✅ Helps understand which outlet size contributes most to total sales.

📈 Conclusion & Findings
✔️ Sales are highest in Urban areas compared to Rural & Tier-2 cities.
✔️ Outlets established in earlier years show better sales performance.
✔️ Best-selling products include high-demand grocery items.
✔️ Outlet size significantly impacts sales volume.
✔️ Fat content does not heavily influence total sales.

