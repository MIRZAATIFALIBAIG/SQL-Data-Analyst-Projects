
use Netflix_db;
select * from netflix;
----------------------------------------------------------------------------------------------------------------------------------------
--Business problems

--1). Write a SQL query to count the number of movies vs tv shows

select type,count(*) as content from netflix
group by type;
------------------------------------------------------------------------------------------------------------------------------------
--2).Write a SQL query to find the most common rating for movies and tv shows

select x.type,x.rating,x.total_ratings from
(select type,rating,count(*) as total_ratings,rank() over(partition by type order by count(*)desc) ranked from netflix
group by type ,rating
)x
where x.ranked=1;

------------------------------------------------------------------------------------------------------------------------------------

--3).Write a SQL query to list all movies released in a specific year(e.g:2018)
select * from netflix
where type='Movie' and release_year=2020;


------------------------------------------------------------------------------------------------------------------------------------


--4).Write a SQL query to find top 5 countries with the most content on netflix

--select new.value from string_split('an example of love',' ') as new;

 ------------------------------------------------
SELECT TOP 5 
    TRIM(country.value) AS country, 
    COUNT(*) AS total_content
FROM netflix
CROSS APPLY STRING_SPLIT(country, ',') AS country
WHERE TRIM(country.value) IS NOT NULL
GROUP BY TRIM(country.value)
ORDER BY total_content DESC;



------------------------------------------------------------------------------------------------------------------------------------


 --5) Write a SQL query to Identify the longest movie 
 select * from netflix

SELECT top 1
    title,duration
FROM netflix
WHERE type = 'Movie'
ORDER BY 
    CAST(SUBSTRING(duration, 1, CHARINDEX(' ', duration) - 1) AS INT) DESC
	
------------------------------------------------------------------------------------------------------------------------------------

-- 6.Write a SQL query to  Find content added in the last 5 years
select * from netflix
where date_added>=DATEADD(Year,-5,getdate());


------------------------------------------------------------------------------------------------------------------------------------


-- 7.Write a SQL query to  Find all the movies/TV shows by director 'Rajiv Chilaka'!

select * from netflix
 cross apply string_split(director,',') as new_director
 where lower(director) like 'Rajiv Chilaka'
 
------------------------------------------------------------------------------------------------------------------------------------




-- 8. Write a SQL query to Count the number of content items in each genre
select listed_split.value,count(*) as total_count from netflix
cross apply string_split(listed_in,',') as listed_split
group by listed_split.value
order by total_count desc

------------------------------------------------------------------------------------------------------------------------------------

-- 9.Write a SQL query to  Find each year and the no of  content release by India on netflix. 

select x.release_year,x.total from 
(select country,release_year,count(*) as total from netflix
group by country,release_year)x
where country='India'
order by release_year desc;




------------------------------------------------------------------------------------------------------------------------------------

-- 10.Write a SQL query to  List all movies that are documentaries

select *  from netflix
where  listed_in like 'documentaries'


------------------------------------------------------------------------------------------------------------------------------------
-- 11.Write a SQL query to  Find all content without a director

select * from netflix
where director is null;


------------------------------------------------------------------------------------------------------------------------------------
-- 12.Write a SQL query to Find how many movies actor 'Salman Khan' appeared in last 10 years!

select * from netflix
where cast like 'salman%'
and release_year>=dateadd(year,-10,getdate());


------------------------------------------------------------------------------------------------------------------------------------
-- 13.Write a SQL query to  Find the top 10 actors who have appeared in the highest number of movies produced in India.


select top 10 new_cast.value,count(*) as total_movies from netflix
cross apply string_split(cast,',') as new_cast
where country='India'
group by  new_cast.value
order by total_movies desc;


------------------------------------------------------------------------------------------------------------------------------------
/*
14. Write a SQL query to  Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.
*/

select x.category ,type,count(*) total_content from
 (select *,case 
 when lower(description) like '%kill%' or lower(description) like '%violence%' then 'bad'
 else 'good'
 end as category
 from netflix)x
 group by category,type
 order by type, total_content desc;
 

    




 



