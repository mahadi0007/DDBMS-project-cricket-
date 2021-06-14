DROP TABLE country CASCADE CONSTRAINTS;
create table country(
    countryId number, countryName varchar2(20),
    PRIMARY KEY(countryId)
);

insert into country values(1,'AUSTRALIA');
insert into country values(2,'BANGLADESH');
insert into country values(3,'ENGLAND');
insert into country values(4,'PAKISTAN');
insert into country values(5,'INDIA');
insert into country values(6,'SRILANKA');
insert into country values(7,'SOUTH AFRICA');
insert into country values(8,'NEW ZEALAND');


commit;
select * from country;