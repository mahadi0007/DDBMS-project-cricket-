DROP TABLE country2;
create table country2(
    countryId number, totalWin number, totalLose number, totalTie number,PRIMARY KEY(countryId)
);
insert into country2 values(1,0,0,0);
insert into country2 values(2,0,0,0);
insert into country2 values(3,0,0,0);
insert into country2 values(4,0,0,0);
insert into country2 values(5,0,0,0);
insert into country2 values(6,0,0,0);
insert into country2 values(7,0,0,0);
insert into country2 values(8,0,0,0);

commit;
select * from country2;