SELECT * FROM house_price_regression.house_price_data;
use house_price_regression;


-- Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. 
-- Select all the data from the table to verify if the command worked. Limit your returned results to 10.
alter table house_price_data drop column date;
SELECT * FROM house_price_data limit 10;

-- Use sql query to find how many rows of data you have.
select count(*) from house_price_data;


-- What are the unique values in the column bedrooms?
Select distinct bedrooms FROM house_price_data;

-- What are the unique values in the column bathrooms?
Select distinct bathrooms FROM house_price_data;

-- What are the unique values in the column floors?
Select distinct floors FROM house_price_data;

-- What are the unique values in the column condition?
Select distinct house_price_data.condition from house_price_data;

-- What are the unique values in the column grade?
Select distinct grade FROM house_price_data;

-- Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.
Select id FROM house_price_data 
order by price desc limit 10;

-- What is the average price of all the properties in your data
select avg(price) from house_price_data;

-- What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the prices.
-- Use an alias to change the name of the second column.
select bedrooms, avg(price) from house_price_data
group by bedrooms;

-- What is the average sqft_living of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the sqft_living. 
-- Use an alias to change the name of the second column.
select bedrooms, avg(sqft_living) as avg_sqrft_lvg from house_price_data
group by bedrooms;

-- What is the average price of the houses with a waterfront and without a waterfront? The returned result should have only two columns, 
-- waterfront and Average of the prices. Use an alias to change the name of the second column.
select waterfront, avg(price) as avg_price from house_price_data
group by waterfront; 

-- Is there any correlation between the columns condition and grade? You can analyse this by grouping the data by one of the variables and then 
-- aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.
select house_price_data.condition, avg(grade) from house_price_data
group by house_price_data.condition order by house_price_data.condition asc;
		-- NO CORRELATION
select avg(house_price_data.condition), grade from house_price_data
group by grade order by grade asc;
        -- NO CORRELATION

-- One of the customers is only interested in the following houses:
-- Number of bedrooms either 3 or 4, Bathrooms more than 3, One Floor, No waterfront.
-- Condition should be 3 at least, Grade should be 5 at least, Price less than 300000

Select id, bedrooms, bathrooms, floors, waterfront, house_price_data.condition, grade, price
 from house_price_data 
where (bedrooms = 3 or bedrooms = 4) and
bathrooms > 3 and
floors = 1 and
waterfront = 0 and 
house_price_data.condition >= 3 and
grade >= 5 and
price < 300000;

-- Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties
 -- in the database. Write a query to show them the list of such properties. You might need to use a sub query for this problem.
select id, price from house_price_data 
where price >= 2*(select avg(price) from house_price_data);

-- Since this is something that the senior management is regularly interested in, create a view of the same query
CREATE VIEW Expensive_Properties AS 
SELECT id, price from house_price_data 
where price >= 2*(select avg(price) from house_price_data)
order by price asc; 

-- Most customers are interested in properties with three or four bedrooms.
 -- What is the difference in average prices of the properties with three and four bedrooms?
 
 select id, avg(price) from house_price_data where bedrooms = 3 or bedrooms = 4
 group by bedrooms order by bedrooms desc;
 
-- What are the different locations where properties are available in your database? (distinct zip codes)
select distinct(zipcode) from house_price_data
 order by zipcode asc;

-- Show the list of all the properties that were renovated.
select id, yr_renovated from house_price_data where yr_renovated>0;

-- Provide the details of the property that is the 11th most expensive property in your database.
 select * from house_price_data 
 order by price desc limit 11;