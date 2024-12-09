# India-population-census-2011-Analysis-SQL-Project

•Census is nothing but a process of collecting, compiling, analyzing, evaluating, publishing and disseminating statistical data regarding the population.

•It is a reflection of truth and facts as they exist in a country about its people, their diversity of habitation, religion, culture, language, education, health and socio-economic status.

•The word ‘Census’ is derived from the Latin word ‘Censere’ meaning ‘to assess or to rate’.

•It covers demographic, social and economic data and are provided as of a particular date. Census is useful for formulation of development policies and plans and demarcating constituencies for elections.

•The Census of India has been conducted 15 times, As of 2011. It has been conducted every 10 years, beginning in 1871.

## Project Overview

**Project Title**:  India Census Analysis
**Level**: Advanced.

**Database**: `india cenus 2011`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives


1. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
use [india cenus 2011];
select count(*) from data1 ;
select count(*) from data2;

select * from data1;
-- Handling null values--
select * from data1
where District is null
or State is null
or Growth is null
or Sex_Ratio is null
or Literacy is null;

select * from data2
where District is null
or State is null
or Area_km2 is null
or Population is null;


```

### 2. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to find data for jharkand and bihar**:

```sql
select * from data1 
where State in('Jharkhand','Bihar')
```

2. **Write a SQL query to find total population of india**:

```sql
select sum(Population) as Total_population from data2;

```

3. **Write a SQL query to find Average growth of india**:

```sql
select round(avg(Growth)*100,2) as Average_growth from data1;
```

4. **Write a SQL query to find Average growth for each state**:

```sql
select State,round(avg(Growth)*100,2) as Average_Growth from data1
group by State;
```

5. **Write a SQL query to find Average sex_ratio**:

```sql
select State,round(avg(Sex_Ratio),0)as Average_sex_ratio from data1
group by State
order by Average_sex_ratio desc;

```

6. **Write a SQL query to find Average literacy rate**:

```sql
select State,round(avg(Literacy),0 )as literacy_rate from data1
group by State
having round(avg(Literacy),0)>90;
```

7. **Write a SQL query to find Top 3 state with highest avg growth rate**:

```sql
select Top 3 State, round(avg(Growth)*100,2) as growth_rate from data1
group by State
order by growth_rate desc;

```

8. **Write a SQL query to find state with lowest avg growth rate**:

```sql
select  top 3 State,round(avg(Growth)*100,2) as growth_rate from data1
group by State
order by growth_rate;
```

9. **Write a SQL query to find Top 3 state with highest sex ratio**:

```sql
select Top 3 State,round(avg(Sex_Ratio),0) as Average_sex_ratio from data1
group by State
order by Average_sex_ratio desc;
```

10. **Write a SQL query to find state with lowest sex ratio**:

```sql
select top 3 State,round(avg(Sex_Ratio),0) as Average_sex_ratio from data1
group by State
order by Average_sex_ratio;

```

11. **Write a SQL query to find top and bottom 3 states with literacy state**:

```sql
drop table if exists #topstates
create table #topstates
(State nvarchar(255) ,
top_state float
)

insert into #topstates
select State,round(avg(Literacy),0) as literacy_rate from data1
group by State;
 
select top 3 * from #topstates 
order by top_state desc;

drop table if exists #bottomstates
create table #bottomstates
(State nvarchar(255) ,
bottomstates float
)

insert into #bottomstates
select State,round(avg(Literacy),0) as literacy_rate from data1
group by State;
 
select top 3 * from #bottomstates
order by bottomstates;

select * from (
select top 3 * from #topstates 
order by top_state desc)a

union

select * from(
select top 3 * from #bottomstates
order by bottomstates)b
order by top_state desc;

```

12. **Write a SQL query to find States starting with letter a**:

```sql
select distinct State from Data1
where State like 'a%';


```
13. **Write a SQL query to find calculating the total no of males and females for each state**:

```sql
select t.State,sum(t.male) as Total_Males,sum(t.female) Total_Females from
(select s.State,s.District ,round(((population*sex_ratio)/(1+sex_ratio)),0) as male ,round((population/(1+sex_ratio)),0) as female
from
(select a.State,a.district,b.Population,a.sex_ratio/1000 as sex_ratio from data1 a join data2  b on a.district=b.district ) s)t
group by t.State;


```
14. **Write a SQL query to find calculating the litearcy rate  for each state**:

```sql
select y.state,sum(y.Literate_population) as Total_Literate_population ,sum(y.Illerate_population) as Total_Illerate_population from
(
select x.state,x.district, round((x.literacy_ratio*population),0) as Literate_population,round((1-x.literacy_ratio)*x.population,0) as Illerate_population
from
(select a.state,a.district,a.literacy/100 as literacy_ratio,b.population from data1 a join data2 b on a.district=b.district) x)y

group by y.state;


```
15. **Write a SQL query to find calcualting the previous cenus population**:

```sql
select * from data1;
select * from data2;


select y.state,sum(previous_census_population) as prev_cen_total_popualtion ,sum(current_population) as current_total_population from 
(
select x.state,x.district,round(x.population/(1+growth),0) as previous_census_population,x.population as current_population from
(
select a.state,a.district,a.growth,b.population from data1 a join data2 b on a.district=b.district)x)y
group by y.state;

```

16. **Write a SQL query to find calcualting the population of india in previous census and current census**:

```sql
select sum(prev_cen_total_popualtion) as prev_census_india_population ,sum(current_total_population) as current_census_india_population from
(

select y.state,sum(previous_census_population) as prev_cen_total_popualtion ,sum(current_population) as current_total_population from 
(
select x.state,x.district,round(x.population/(1+growth),0) as previous_census_population,x.population as current_population from
(
select a.state,a.district,a.growth,b.population from data1 a join data2 b on a.district=b.district)x)y
group by y.state)z

```


17. **Write a SQL query to find Top 3 district for every state based on literacy**:

```sql
select a.state,a.district ,a.literacy,a.rank from
(
select state,district,literacy ,rank() over(partition by state order by literacy desc)  as rank  from data1)a
where a.rank <4;


```

## Findings

- **State-Wise Population**: The dataset includes states  with population distributed across different districts.
- **Average growth rate**: Found average growth rate for each states and sorted them with highest growth rate .
- **Literacy Rate**: Found Average Literacy rate for each state .
- **State-Wise Insights**: The analysis identifies the top states  and the most populated states.

## Reports

- **Population Growth**: A detailed report summarizing the population growth and compared previous census population with current population.
- **State-Wise Analysis**: Insights into average growth of sex_ratio,literacy_rate and gender distribution for each state.
- **Insights**: Reports on top states related to gender distribution ,literacy rate and growth rate.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding  growth_rate,literacy_rate,sex_ratio,total census population.
## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Upload the csv files to the mysql work bench or ssms.
3. **Run the Queries**: Use the SQL queries provided in the `indiacensus.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Mirza Atif Ali Baig

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/mirza-atif-ali-baig)

Thank you for your support, and I look forward to connecting with you!

