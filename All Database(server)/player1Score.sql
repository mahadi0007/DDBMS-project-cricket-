DROP TABLE player1 CASCADE CONSTRAINTS;
	
create table player1(
    player1ID number, run varchar2(20),batsmanPlayerId varchar2(20),bowlerPlayerId varchar2(20)
);


commit;
select * from player1;