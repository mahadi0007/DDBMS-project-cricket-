DROP TABLE rules CASCADE CONSTRAINTS;
	
create table rules(
    rulesId number, num int, val varchar2(20), details varchar2(20),
    PRIMARY KEY(rulesId)
);

insert into rules values(1,0,'0','0 run');
insert into rules values(2,1,'1','1 run');
insert into rules values(3,2,'2','2 runs');
insert into rules values(4,3,'3','3 runs');
insert into rules values(5,4,'4','4 runs');
insert into rules values(6,5,'5','5 runs');
insert into rules values(7,6,'6','6 runs');
insert into rules values(8,7,'w','bowled out');
insert into rules values(9,8,'w','catch out');




commit;
select * from rules;