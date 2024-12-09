use [india cenus 2011];
select * from data1;
select * from data2;

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



--1 .Write a SQL query to find Write a SQL query to find data for jharkand and bihar
select * from data1 
where State in('Jharkhand','Bihar')
-- 2.Write a SQL query to find Write a SQL query to find total population of india
select sum(Population) as Total_population from data2;

--3.Write a SQL query to find  Average growth of india
select round(avg(Growth)*100,2) as Average_growth from data1;

--4. Write a SQL query to find Average growth for each state 
select State,round(avg(Growth)*100,2) as Average_Growth from data1
group by State;

--5.Write a SQL query to find Average sex_ratio 
select State,round(avg(Sex_Ratio),0)as Average_sex_ratio from data1
group by State
order by Average_sex_ratio desc;
--6.Write a SQL query to find Average literacy rate
select State,round(avg(Literacy),0 )as literacy_rate from data1
group by State
having round(avg(Literacy),0)>90;

--7.Write a SQL query to find Top 3 state with highest avg growth rate
select Top 3 State, round(avg(Growth)*100,2) as growth_rate from data1
group by State
order by growth_rate desc;

--8. Write a SQL query to find state with lowest avg growth rate
select  top 3 State,round(avg(Growth)*100,2) as growth_rate from data1
group by State
order by growth_rate;

---9.Write a SQL query to find  Top 3 state with highest sex ratio

select Top 3 State,round(avg(Sex_Ratio),0) as Average_sex_ratio from data1
group by State
order by Average_sex_ratio desc;

--10.Write a SQL query to find state with lowest sex ratio
select top 3 State,round(avg(Sex_Ratio),0) as Average_sex_ratio from data1
group by State
order by Average_sex_ratio;

---11.Write a SQL query to find  top and bottom 3 states with literacy state
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

--12.Write a SQL query to find  States starting with letter a
select distinct State from Data1
where State like 'a%';

--13. Write a SQL query to find calculating the total no of males and females for each state

select t.State,sum(t.male) as Total_Males,sum(t.female) Total_Females from
(select s.State,s.District ,round(((population*sex_ratio)/(1+sex_ratio)),0) as male ,round((population/(1+sex_ratio)),0) as female
from
(select a.State,a.district,b.Population,a.sex_ratio/1000 as sex_ratio from data1 a join data2  b on a.district=b.district ) s)t
group by t.State;

--14.Write a SQL query to find calculating the litearcy rate  for each state



select y.state,sum(y.Literate_population) as Total_Literate_population ,sum(y.Illerate_population) as Total_Illerate_population from
(
select x.state,x.district, round((x.literacy_ratio*population),0) as Literate_population,round((1-x.literacy_ratio)*x.population,0) as Illerate_population
from
(select a.state,a.district,a.literacy/100 as literacy_ratio,b.population from data1 a join data2 b on a.district=b.district) x)y

group by y.state;

---15. Write a SQL query to find calcualting the previous cenus population

select * from data1;
select * from data2;


select y.state,sum(previous_census_population) as prev_cen_total_popualtion ,sum(current_population) as current_total_population from 
(
select x.state,x.district,round(x.population/(1+growth),0) as previous_census_population,x.population as current_population from
(
select a.state,a.district,a.growth,b.population from data1 a join data2 b on a.district=b.district)x)y
group by y.state

--16.Write a SQL query to find calcualting the population of india in previous census and current census

select sum(prev_cen_total_popualtion) as prev_census_india_population ,sum(current_total_population) as current_census_india_population from
(

select y.state,sum(previous_census_population) as prev_cen_total_popualtion ,sum(current_population) as current_total_population from 
(
select x.state,x.district,round(x.population/(1+growth),0) as previous_census_population,x.population as current_population from
(
select a.state,a.district,a.growth,b.population from data1 a join data2 b on a.district=b.district)x)y
group by y.state)z

--17.Write a SQL query to find Top 3 district for every state based on literacy

select a.state,a.district ,a.literacy,a.rank from
(
select state,district,literacy ,rank() over(partition by state order by literacy desc)  as rank  from data1)a
where a.rank <4;

--end


