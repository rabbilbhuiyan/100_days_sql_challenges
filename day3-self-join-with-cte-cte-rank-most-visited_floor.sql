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

