Use BlinkitDB;       
select * from BlinkIT_Data;

select count(*)
from BlinkIT_Data;

1) For Cleaning The Messy data --->

update BlinkIT_Data
set Item_Fat_Content = 
CASE
WHEN Item_Fat_Content in ('LF','low fat') THEN 'Low Fat'
WHEN Item_Fat_Content = 'reg' THEN 'Regular'
ELSE Item_Fat_Content
END

select DISTINCT(Item_Fat_Content) from BlinkIT_Data;


1) Total Sales --->

select CAST(SUM(Sales)/1000000 AS decimal(10,2)) Total_Sales_Miliians
from BlinkIT_Data;



2) Average Sales--->

Select CAST(AVG(Sales) As decimal(10,0)) Average_Sales
from BlinkIT_Data;



3) Count /Number of Items--->

select count(*) No_of_Item_Sold
from BlinkIT_Data;

4) Total Sales for LOw Fat--->

select CAST(SUM(Sales) As decimal(10,0)) As Total_sales
from BlinkIT_Data
where Item_Fat_Content='Low Fat';



select count(*),Item_type
from BlinkIT_Data
Group By Item_Type;

5) Average Ratings--->

select CAST(Avg(Rating) As decimal(10,2)) Average_Ratings
from BlinkIT_Data;



0) Bussiness Problems --->

select CAST(Sum(Sales) As decimal(10,2)) Total_Sales,Item_Fat_Content
from BlinkIT_Data
Group by Item_Fat_Content;

select Item_Fat_Content,
       CAST(Sum(Sales) As decimal(10,2)) Total_Sales,
	   CAST(Avg(Rating) As decimal(10,2)) Average_Ratings,
	   count(*) No_Of_Items
from BlinkIT_Data
where Outlet_Establishment_Year=2012 and Outlet_Size ='Medium'
Group by Item_Fat_Content
having count(*) > 300;



2) Item Type--->

select TOP 5 Item_Type,
       CAST(SUM(Sales) As decimal(10,2)) Total_Sales,
	   Cast(Avg(Sales) As decimal(10,2)) Avg_Sales,
	   count(*)  No_Of_items
from BlinkIT_Data
Group By Item_Type
Order By Total_Sales;


select Outlet_Location_Type,
        ISNULL([Low Fat],0) Low_Fat,
		ISNULL([Regular],0) Regular
from
(
  select Outlet_Location_Type,Item_Fat_Content,
         Cast(Sum(Sales) As decimal(10,2)) AS Total_Sales
  from BlinkIT_Data
  group by Outlet_Location_Type,Item_Fat_Content
) As SourseTable
PIVOT
(
   sum(Total_Sales)
   for Item_Fat_Content In ([Low Fat],[Regular])
) As PivotTable
order by Outlet_Location_Type;



4) Outlet_establisment--->

select Outlet_Establishment_Year,
       Cast(Sum(Sales) As decimal(10,2)) as Total_Sales
from BlinkIT_Data
Group by Outlet_Establishment_Year;


5) 
select 
     Outlet_Size,
	 CAST(Sum(Sales) As decimal(10,2)) As Total_Sales,
	 Cast(Sum(Sales) * 100.0 / SUM(SUM(Sales)) Over() As decimal(10,2)) As Sales_Percentage
from BlinkIT_Data
Group By Outlet_Size
Order by Total_Sales Desc;

4) Sales By Outlet Location --->

Select Outlet_location_Type,
       Cast(Sum(Sales) as decimal(10,2)) as Total_Sales
from BlinkIT_Data
group by Outlet_location_Type;

select Outlet_Type,
       Cast(sum(Sales) as decimal(10,2)) as Total_sales,
	   Cast(Sum(Sales) * 100.0 / SUM(SUM(Sales)) Over() As decimal(10,2)) As Sales_Percentage,
	   Cast(Avg(Sales) as decimal(10,2)) as Avg_Sales,
	   Count(*) No_Of_Sales
from BlinkIT_Data
group by Outlet_Type;


1) how we can find duplicates recordes in sql ?

select Item_Type,count(*) AS NO_OF_ITEMS 
from BlinkIT_Data
group by Item_Type
having COUNT(*)>1;