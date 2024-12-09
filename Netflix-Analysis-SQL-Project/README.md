# Netflix Movies and TV Shows Data Analysis using SQL

![](https://github.com/najirh/netflix_sql_project/blob/main/logo.png)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

## Objectives

- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema

```sql
use Netflix_db;
drop table if exists netflix
create table netflix(
show_id varchar(50),	
type varchar(50),
title varchar(500),
director varchar(800),
casts varchar(2000),
country	varchar(100),
date_added date,
release_year int,
rating	varchar(200),
duration varchar(50),
listed_in	varchar(100),
description varchar(3000)
);
```

## Business Problems and Solutions

### 1.  Write a SQL query to count the number of movies vs tv shows

```sql
select type,count(*) as content from netflix
group by type;

```



### 2. Write a SQL query to  find the most common rating for movies and tv shows

```sql
select x.type,x.rating,x.total_ratings from
(select type,rating,count(*) as total_ratings,rank() over(partition by type order by count(*)desc) ranked from netflix
group by type ,rating
)x
where x.ranked=1;


```



### 3. Write a SQL query to list all movies released in a specific year(e.g:2018)
```sql
select * from netflix
where type='Movie' and release_year=2018;
```



### 4. Write a SQL query to find top 5 countries with the most content on netflix

```sql
SELECT TOP 5 
    TRIM(country.value) AS country, 
    COUNT(*) AS total_content
FROM netflix
CROSS APPLY STRING_SPLIT(country, ',') AS country
WHERE TRIM(country.value) IS NOT NULL
GROUP BY TRIM(country.value)
ORDER BY total_content DESC;
```



### 5. Write a SQL query to Identify the longest movie 

```sql
SELECT top 1
    title,duration
FROM netflix
WHERE type = 'Movie'
ORDER BY 
    CAST(SUBSTRING(duration, 1, CHARINDEX(' ', duration) - 1) AS INT) DESC;
```



### 6.  Write a SQL query to Find content added in the last 5 years

```sql
select * from netflix
where date_added>=DATEADD(Year,-5,getdate());
```



### 7. Write a SQL query to Find all the movies/TV shows by director 'Rajiv Chilaka'!

```sql
select * from netflix
 cross apply string_split(director,',') as new_director
 where lower(director) like 'Rajiv Chilaka';
 
```



### 8.Write a SQL  Count the number of content items in each genre

```sql
select listed_split.value,count(*) as total_count from netflix
cross apply string_split(listed_in,',') as listed_split
group by listed_split.value
order by total_count desc;

```



### 9.Write a SQL query to Find each year and the average numbers of content release in India on netflix. 


```sql
select x.release_year,x.total from 
(select country,release_year,count(*) as total from netflix
group by country,release_year)x
where country='India'
order by release_year desc;
```



### 10.Write a SQL query to  List All Movies that are Documentaries

```sql
select *  from netflix
where  listed_in like 'documentaries';
```


### 11. Write a SQL query to Find All Content Without a Director

```sql
select * from netflix
where director is null;
```



### 12. Write a SQL query to Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

```sql
select * from netflix
where cast like '%salman%'
and release_year>=dateadd(year,-10,getdate());
```



### 13.Write a SQL query to  Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

```sql

select top 10 new_cast.value,count(*) as total_movies from netflix
cross apply string_split(cast,',') as new_cast
where country='India'
group by  new_cast.value
order by total_movies desc;
```



### 14. Write a SQL query to Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords

```sql
select x.category ,type,count(*) total_content from
 (select *,case 
 when lower(description) like '%kill%' or lower(description) like '%violence%' then 'bad'
 else 'good'
 end as category
 from netflix)x
 group by category,type
 order by type, total_content desc;
```



## Findings and Conclusion

- **Content Distribution:** The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
- **Common Ratings:** Insights into the most common ratings provide an understanding of the content's target audience.
- **Geographical Insights:** The top countries and the average content releases by India highlight regional content distribution.
- **Content Categorization:** Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.

This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making.



## Author - Mirza Atif Ali Baig

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:

- 
- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/mirza-atif-ali-baig)


Thank you for your support, and I look forward to connecting with you!
