# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `retail_sales`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `retail_sales`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE retail_sales;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-14**:

```sql
SELECT
    *
FROM
    retail_sales
WHERE
    sale_date = '2022/11/14';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Electronics' and the quantity sold is more than 4 in the month of june-2023:**:

```sql
SELECT
    *
FROM
    retail_sales
WHERE
    category = 'Electronics'
        AND YEAR(sale_date) = 2023
        AND MONTH(sale_date) = 6;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:

```sql
SELECT
    category, SUM(total_sale) AS Total_sales
FROM
    retail_sales
GROUP BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Electronics' category.**:

```sql
SELECT
    AVG(age) AS average_age
FROM
    retail_sales
GROUP BY category
HAVING category = 'Electronics';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:

```sql
SELECT
    *
FROM
    retail_sales
WHERE
    total_sale > 1000;

```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:

```sql
SELECT
    category, gender, COUNT(*) AS total_transactions
FROM
    retail_sales
GROUP BY category , gender;
```

7. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category and show which gender spent the most in each categoy**:

```sql
select * from
		(select category,gender ,count(*) as most_transactions, rank() over(partition by category order by count(*) desc) as rank from retail_sales
		group by category,gender) as t

where rank=1;
```

8. **write a sql query to find the most no of spendings by category and gender**:

```sql
select * from
(
select category,gender,sum(total_sale) as most_spending  ,rank() over(partition by category order by sum(total_sale) desc)as rank from retail_sales
group by category,gender) as m

where rank=1;
```

9. **write a sql query to find the customer for each category with respect to their gender**:

```sql
SELECT
    category,
    gender,
    COUNT(DISTINCT (customer_id)) AS Total_no_of_customers
FROM
    retail_sales
GROUP BY category , gender;
```

10. **Top 10 customers based on highest sales**:

```sql
SELECT TOP 10 customer_id AS customers,
       SUM(total_sale) AS net_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY net_sales DESC;
```

11. **Write a SQL query to find the number of unique customers who purchased items from each category.:**:

```sql
SELECT
    category, COUNT(DISTINCT customer_id) AS Total_customers
FROM
    retail_sales
GROUP BY category;

```

12. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

```sql
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

```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `retail_sales_database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `Retail_sales_eda_sql_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Mirza Atif Ali Baig

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/mirza-atif-ali-baig)

Thank you for your support, and I look forward to connecting with you!
