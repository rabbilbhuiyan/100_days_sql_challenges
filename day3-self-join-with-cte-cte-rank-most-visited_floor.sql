/*
A company allows only one entry per employee per day.
However, employees found a loophole:
they can enter multiple times using different email IDs.
You are given an entries table that logs:
employee name
address
email used
floor visited
resource used
🎯 Your task is to write an SQL query that returns:
For each person:
Total number of visits
Most visited floor
List of distinct resources used
*/


drop table if exists entries;
create table entries (
	name varchar(20),
	address varchar(20),
	email varchar(20),
	floor int,
	resources varchar(20)
);

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),
('A','Bangalore','A1@gmail.com',1,'CPU'),
('A','Bangalore','A2@gmail.com',2,'DESKTOP'),
('B','Bangalore','B@gmail.com',2,'DESKTOP'),
('B','Bangalore','B1@gmail.com',2,'DESKTOP'),
('B','Bangalore','B2@gmail.com',1,'MONITOR');

select * from entries

/* first find the most visited floor by the person*/
with total_visit as (
select 
	name,
	count(name) as total_visit,
	string_agg(distinct resources, ',') as resources_used
from entries
group by name
),

floor_visit as
(select 
	name,
	floor,
	count(name) no_of_floor_visit,
	rank() over(partition by name order by count(name) desc) as rnk
from entries
group by name, floor)
select 
fv.name, fv.floor as most_visited_floor, tv.total_visit, tv.resources_used
from floor_visit fv
inner join total_visit tv
on tv.name = fv.name

where rnk = 1

/* now for total visit */

/* combine three cte */
with distinct_resources as (
select name, group_concat(resources) as used_resources
from
(SELECT DISTINCT name, resources FROM entries)
group by name),

total_visits as (
select 
name, floor, resources,
count(name) as total_visit
from entries
group by name),

most_visit as(
select 
    name, floor, (resources),
    rank() over(partition by name order by count(name)) as rnk
from entries
group by name)

select 
    mv.name, mv.floor as most_visited_floor, 
    tv.total_visit as total_visits,
    dr.used_resources as used_resources
from most_visit mv
inner join total_visits tv
on mv.name = tv.name
inner join distinct_resources dr 
on mv.name = dr.name
where mv.rnk = 1;
