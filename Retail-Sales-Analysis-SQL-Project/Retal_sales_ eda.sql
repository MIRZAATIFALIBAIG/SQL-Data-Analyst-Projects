use retail_sales;
--fetching the null records

use retail_sales;
SELECT 
    *
FROM
    retail_sales
WHERE
    transactions_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantiy IS NULL
        OR price_per_unit IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;

--dropping the null records from the table

DELETE FROM retail_sales 
WHERE
    transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantiy IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;

--------------fetching all records------------------------------------------
SELECT 
    *
FROM
    retail_sales;

--fetching the total no of records
SELECT 
    COUNT(*)
FROM
    retail_sales;

--fetching total no of records with respect to gender-------------------------------

SELECT 
    gender, COUNT(*)
FROM
    retail_sales
GROUP BY gender;
------------------------------------------------------------------------------------------------------------------------------------------

--1.Write a SQL query to retrieve all columns for sales made on '2022-11-14:

SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022/11/14';

-------------------------------------------------------------------------------------------------------------------------------------------
--2.Write a SQL query to retrieve all transactions where the category is 'Electronics' and the quantity sold is more than 4 in the month of june-2023:

SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Electronics'
        AND YEAR(sale_date) = 2023
        AND MONTH(sale_date) = 6;

-------------------------------------------------------------------------------------------------------------------------------------------

--3 Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT 
    category, SUM(total_sale) AS Total_sales
FROM
    retail_sales
GROUP BY category;

-------------------------------------------------------------------------------------------------------------------------------------------
--4 Write a SQL query to find the average age of customers who purchased items from the 'Electronics' category.


SELECT 
    AVG(age) AS average_age
FROM
    retail_sales
GROUP BY category
HAVING category = 'Electronics';

-------------------------------------------------------------------------------------------------------------------------------------------
-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:


SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000;
-------------------------------------------------------------------------------------------------------------------------------------------

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT 
    category, gender, COUNT(*) AS total_transactions
FROM
    retail_sales
GROUP BY category , gender;

-------------------------------------------------------------------------------------------------------------------------------------------

--7.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category and show which gender spent the most in each categoy.:

select * from
	(select category,gender ,count(*) as most_transactions, rank() over(partition by category order by count(*) desc) as rank from retail_sales 
	group by category,gender) as t

where rank=1;
-------------------------------------------------------------------------------------------------------------------------------------------

-- 8. write a sql query to find the most no of spendings by category and gender
select * from 
(
select category,gender,sum(total_sale) as most_spending  ,rank() over(partition by category order by sum(total_sale) desc)as rank from retail_sales
group by category,gender) as m

where rank=1;

-------------------------------------------------------------------------------------------------------------------------------------------

--9. write a sql query to find the customer for each category with respect to their gender

SELECT 
    category,
    gender,
    COUNT(DISTINCT (customer_id)) AS Total_no_of_customers
FROM
    retail_sales
GROUP BY category , gender;

-------------------------------------------------------------------------------------------------------------------------------------------



--10. Top 10  customers based on highest sales

SELECT TOP 10 customer_id AS customers, 
       SUM(total_sale) AS net_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY net_sales DESC;

-------------------------------------------------------------------------------------------------------------------------------------------
--11. Write a SQL query to find the number of unique customers who purchased items from each category.:

SELECT 
    category, COUNT(DISTINCT customer_id) AS Total_customers
FROM
    retail_sales
GROUP BY category;

-------------------------------------------------------------------------------------------------------------------------------------------

--12.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):


SELECT 
    x.shift, COUNT(transactions_id) AS total_orders
FROM
    (SELECT 
        *,
            CASE
                WHEN DATEPART(hour, sale_time) < 12 THEN 'Morning'
                WHEN DATEPART(hour, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
                ELSE 'Evening'
            END AS shift
    FROM
        retail_sales) x
GROUP BY x.shift
ORDER BY total_orders DESC;













