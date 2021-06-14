DROP TABLE playerList CASCADE CONSTRAINTS;
	
create table playerList(
    playerId number, playerName varchar2(20), 
    PRIMARY KEY(playerId),
    countryId number REFERENCES country (countryId)
);

insert into playerList values(1,'Adam Gilchrist',1);
insert into playerList values(2,'Glenn McGrath',1);
insert into playerList values(3,'Tamim Iqbal',2);
insert into playerList values(4,'Shakib Al Hasan',2 );
insert into playerList values(5,'Alastair Cook',3);
insert into playerList values(6,'James Anderson',3);
insert into playerList values(7,'Inzamam-ul-Haq',4);
insert into playerList values(8,'Shoaib Akhtar',4);
insert into playerList values(9,'Sachin Tendulkar',5);
insert into playerList values(10,'Jasprit Bumrah',5);
insert into playerList values(11,'Kumar Sangakkara',6);
insert into playerList values(12,'Chaminda Vaas',6);
insert into playerList values(13,'Graeme Smith',7);
insert into playerList values(14,'Dale Steyn',7);
insert into playerList values(15,'Kane Williamson',8);
insert into playerList values(16,'Tim Southee',8);


commit;
select * from playerList;