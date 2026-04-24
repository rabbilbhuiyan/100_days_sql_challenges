
Create table friend (pid int, fid int);
insert into friend (pid , fid ) values ('1','2');
insert into friend (pid , fid ) values ('1','3');
insert into friend (pid , fid ) values ('2','1');
insert into friend (pid , fid ) values ('2','3');
insert into friend (pid , fid ) values ('3','5');
insert into friend (pid , fid ) values ('4','2');
insert into friend (pid , fid ) values ('4','3');
insert into friend (pid , fid ) values ('4','5');

create table person (PersonID int,	Name varchar(50),	Score int);
insert into person(PersonID,Name ,Score) values('1','Alice','88');
insert into person(PersonID,Name ,Score) values('2','Bob','11');
insert into person(PersonID,Name ,Score) values('3','Devis','27');
insert into person(PersonID,Name ,Score) values('4','Tara','45');
insert into person(PersonID,Name ,Score) values('5','John','63');

select * from person;
select * from friend;

/* write a query to find personID, Name, number of friends, sum of marks of person 
who have friends with total score greater than 100 */

select 
	f.pid, f.fid, p.score as friend_score
from friend f
inner join person p 
on f.fid = p.PersonID
-- now need to aggregate the total score with person level
-- remove fid and use sum on score 
select 
	f.pid, 
	sum(score) as total_friend_score
from friend f
inner join person p 
on f.fid = p.PersonID
group by f.pid
having sum(score) > 100

-- we also need number of toal friends
select 
	f.pid,
	count(pid) as no_of_friends,
	sum(score) as total_friend_score
from friend f
inner join person p 
on f.fid = p.PersonID
group by f.pid
having sum(score) > 100
-- we need the person name now
-- for that apply cte and then join with person table

with score_details as (
select 
	f.pid,
	count(pid) as no_of_friends,
	sum(score) as total_friend_score
from friend f
inner join person p 
on f.fid = p.PersonID
group by f.pid
having sum(score) > 100
)
select 
	s.*, 
	p.Name
from person p
inner join score_details s 
on p.PersonID = s.pid