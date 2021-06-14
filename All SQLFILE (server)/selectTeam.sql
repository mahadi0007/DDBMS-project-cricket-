SET VERIFY OFF;
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE selectTeam(A IN number, B OUT country.countryId%TYPE)
IS
    team number;
    teamName varchar2(20);
    country_id country.countryId%TYPE;
    i int := 0;
    
BEGIN
	team := A;
    if team=1 then
        teamName:= 'AUSTRALIA';
    elsif team=2 then
        teamName:= 'BANGLADESH';
    elsif team=3 then
        teamName:= 'ENGLAND';
    elsif team=4 then
        teamName:= 'PAKISTAN';
    elsif team=5 then
        teamName:= 'INDIA';
    elsif team=6 then
        teamName:= 'SRILANKA';
    elsif team=7 then
        teamName:= 'SOUTH AFRICA';
    elsif team=8 then
        teamName:= 'NEW ZEALAND';
    else
        DBMS_OUTPUT.PUT_LINE('invalid input.');
    end if;
    DBMS_OUTPUT.PUT_LINE('your selected team is '||teamName);
    SELECT distinct countryId into country_id  FROM country WHERE countryName = teamName;
    B := country_id;
    DBMS_OUTPUT.PUT_LINE(teamName||' team players: ');
    i:=0;
    FOR R IN (SELECT playerName FROM playerList WHERE countryId = country_id ) LOOP
        i:=i+1;
        DBMS_OUTPUT.PUT_LINE(i||'. ' || R.playerName||'.');     
	END LOOP; 
END selectTeam;
/

CREATE OR REPLACE PROCEDURE OppselectTeam(A IN number, B OUT country.countryId%TYPE)
IS
    oppSelect int;
    oppTeam varchar2(20);
    country_id country.countryId%TYPE;
    i int;
    targetScore int;
    oppScore int;
    
BEGIN
    
    LOOP
        oppSelect := dbms_random.value(0,8);

        if oppSelect=1 then
            oppTeam:= 'AUSTRALIA';
        elsif oppSelect=2 then
            oppTeam:= 'BANGLADESH';
        elsif oppSelect=3 then
            oppTeam:= 'ENGLAND';
        elsif oppSelect=4 then
            oppTeam:= 'PAKISTAN';
        elsif oppSelect=5 then
            oppTeam:= 'INDIA';
        elsif oppSelect=6 then
            oppTeam:= 'SRILANKA';
        elsif oppSelect=7 then
            oppTeam:= 'SOUTH AFRICA';
        elsif oppSelect=8 then
            oppTeam:= 'NEW ZEALAND';
        else
            DBMS_OUTPUT.PUT_LINE('invalid input');
        end if;

        DBMS_OUTPUT.PUT_LINE('opponenet selected ' ||oppTeam||'.');
        SELECT distinct countryId into country_id  FROM country WHERE countryName = oppTeam;
        B := country_id;
        DBMS_OUTPUT.PUT_LINE(oppTeam||' team players: ');
        i:=0;
        FOR R IN (SELECT playerName FROM playerList WHERE countryId = country_id ) LOOP
            i:=i+1;
            DBMS_OUTPUT.PUT_LINE(i||'. ' || R.playerName||'.');     
        END LOOP;
        EXIT WHEN A != B;
    END LOOP;
    
END OppselectTeam;
/

DROP TRIGGER Team_Selected;

CREATE OR REPLACE TRIGGER Team_Selected
BEFORE INSERT  
ON scorecard
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Team is Selected........(from TRIGGER).');
END;
/


DECLARE
    i int := 0;
    allTeamName varchar2(20);

BEGIN
        DBMS_OUTPUT.PUT_LINE('Team List: ');
        FOR R IN (SELECT countryName into allTeamName  FROM country  ) LOOP
                i:=i+1;
                DBMS_OUTPUT.PUT_LINE(i||'. ' || R.countryName||'.');
        END LOOP; 
END;
/



accept y number prompt 'select your team : (1 to 8 )= '
DECLARE
    A number;
    B country.countryId%TYPE;
    C country.countryId%TYPE;
    D number;
    game_id number;
BEGIN
    A := &y;
    selectTeam(A, B);
    -- DBMS_OUTPUT.PUT_LINE('your team id= '||B);
    
    OppselectTeam(B,C);
    -- DBMS_OUTPUT.PUT_LINE('opponent team id= '||C);
    SELECT COUNT(gameId) INTO D FROM scorecard;
    D := D+1;
    insert into scorecard values(D,B,C);

END;
/
