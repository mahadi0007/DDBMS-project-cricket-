SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE mypack AS

	FUNCTION batting
	RETURN varchar2;
	
END mypack;
/


CREATE OR REPLACE PACKAGE BODY mypack AS

    FUNCTION batting
    RETURN varchar2
    IS

        score rules.num%TYPE;
        run rules.val%TYPE;
        detail rules.details%TYPE;
        gameNo scorecard.gameId%TYPE;
        bowler scorecard.gameId%TYPE;
        batsman scorecard.gameId%TYPE;
        wicket int :=0;
    BEGIN
        score := dbms_random.value(0,8);
        

        if score=0 then
            SELECT num,val,details into score, run, detail  FROM rules WHERE num = score;
            DBMS_OUTPUT.PUT_LINE('you scored '||detail|| ' from this ball.');

        elsif score=1 then
            SELECT num,val,details into score, run, detail  FROM rules WHERE num = score;
            DBMS_OUTPUT.PUT_LINE('you scored '||detail|| ' from this ball.');

        elsif score=2 then
            SELECT num,val,details into score, run, detail  FROM rules WHERE num = score;
            DBMS_OUTPUT.PUT_LINE('you scored '||detail|| ' from this ball.');

        elsif score=3 then
            SELECT num,val,details into score, run, detail  FROM rules WHERE num = score;
            DBMS_OUTPUT.PUT_LINE('you scored '||detail|| ' from this ball.');

        elsif score=4 then
            SELECT num,val,details into score, run, detail  FROM rules WHERE num = score;
            DBMS_OUTPUT.PUT_LINE('you scored '||detail|| ' from this ball.');

        elsif score=5 then
            SELECT num,val,details into score, run, detail  FROM rules WHERE num = score;
            DBMS_OUTPUT.PUT_LINE('you scored '||detail|| ' from this ball.');

        elsif score=6 then
            SELECT num,val,details into score, run, detail  FROM rules WHERE num = score;
            DBMS_OUTPUT.PUT_LINE('you scored '||detail|| ' from this ball.');

        elsif score=7 then
            wicket := wicket+1;
            SELECT num,val,details into score, run, detail  FROM rules WHERE num = score;
            DBMS_OUTPUT.PUT_LINE('Opps.... '||detail|| ' from this ball.');
            DBMS_OUTPUT.PUT_LINE(wicket|| ' wicket down.');

        elsif score=8 then
            wicket := wicket+1;
            SELECT num,val,details into score, run, detail  FROM rules WHERE num = score;
            DBMS_OUTPUT.PUT_LINE('Opps.... '||detail|| ' from this ball.');
            DBMS_OUTPUT.PUT_LINE(wicket|| ' wicket down.');

        else
            DBMS_OUTPUT.PUT_LINE('invalid input');
        end if;

        return run;
    END batting;

END mypack;
/





CREATE OR REPLACE PROCEDURE isBat
IS
	A VARCHAR2(256);
    game_id scorecard.gameId%TYPE;
    myTeam_Id scorecard.myTeamId%TYPE;
    oppTeam_Id scorecard.oppTeamId%TYPE;
    player_Id playerList.playerId%TYPE;
    oppPlayerID playerList.playerId%TYPE;
    counts number;
    wickets number;

    flag number := 0;
    i number := 0;
    nextBall number;
    newOppScore number;
    oppTotalRun number;
    myRun varchar2(20);
    myTotalRun number :=0;

    opp_lastGameID number;
    target_Scores number;

    allOut EXCEPTION;
    
    totalWins_p number;
    totalLoses_P number;
    totalTies_P number;
    totalWins_O number;
    totalLoses_O number;
    totalTies_O number;

    
BEGIN

    SELECT count(gameId) into game_id  FROM scorecard;
    FOR R IN (SELECT * FROM player1 WHERE player1ID=game_id) LOOP
            i:=i+1;
            myRun := R.run;
            if myRun = '1' then
                myTotalRun := myTotalRun+1;
            elsif myRun = '2' then
                myTotalRun := myTotalRun+2;
            elsif myRun = '3' then
                myTotalRun := myTotalRun+3;
            elsif myRun = '4' then
                myTotalRun := myTotalRun+4;
            elsif myRun = '5' then
                myTotalRun := myTotalRun+5;
            elsif myRun = '6' then
                myTotalRun := myTotalRun+6;
            end if;
            --DBMS_OUTPUT.PUT_LINE(i||'. ' || myRun||'.'|| R.player1ID);
    END LOOP; 

    SELECT Count(opponentScoreId) into newOppScore FROM opponentScore WHERE opponentScoreId=game_id;

    if newOppScore = 0 then
        oppTotalRun := 0;
        flag := 1;
    else 
        SELECT oppScores into oppTotalRun FROM opponentScore WHERE opponentScoreId=game_id;
    end if;

    if myTotalRun > oppTotalRun and flag =0 then
            DBMS_OUTPUT.PUT_LINE('you won the match......!!!!!!!!!!');

    else
        SELECT COUNT(gameId) INTO game_id FROM scorecard;
        
        SELECT myTeamId,oppTeamId INTO myTeam_Id,oppTeam_Id FROM scorecard WHERE gameId=game_id;
        SELECT COUNT(run) INTO wickets FROM player1 WHERE player1ID=game_id AND run = 'w';
        if wickets=0 then
            counts := 0;
            FOR R IN ( SELECT playerId FROM playerList WHERE countryId=myTeam_Id) LOOP
                player_Id := R.playerId;
                EXIT WHEN counts = 0;  
            END LOOP;
            
        elsif wickets=1 then
            FOR R IN ( SELECT playerId FROM playerList WHERE countryId=myTeam_Id) LOOP
                player_Id := R.playerId; 
            END LOOP;
        else
            raise allOut;

        end if;

        A := mypack.batting;
        -- DBMS_OUTPUT.PUT_LINE(A);

        FOR R IN (  SELECT playerId FROM playerList WHERE countryId=oppTeam_Id) LOOP
                oppPlayerID := R.playerId;
        END LOOP;
        
        insert into player1 values(game_id,A,player_Id,oppPlayerID);


        if A = '1' then
                myTotalRun := myTotalRun+1;
            elsif A = '2' then
                myTotalRun := myTotalRun+2;
            elsif A = '3' then
                myTotalRun := myTotalRun+3;
            elsif A = '4' then
                myTotalRun := myTotalRun+4;
            elsif A = '5' then
                myTotalRun := myTotalRun+5;
            elsif A = '6' then
                myTotalRun := myTotalRun+6;
            end if;

        if myTotalRun > oppTotalRun and flag =0 then
            DBMS_OUTPUT.PUT_LINE('opponent Total Run = '||oppTotalRun);
            DBMS_OUTPUT.PUT_LINE('Your Total Run = '||myTotalRun);
            DBMS_OUTPUT.PUT_LINE('you won the match......!!!!!!!!!!');
        end if;


    end if;


EXCEPTION
	WHEN allOut THEN

		DBMS_OUTPUT.PUT_LINE('You are all out.');
        DBMS_OUTPUT.PUT_LINE('AND ::::::::::::');

    

        if flag =1 then
            target_Scores := myTotalRun+1;
            DBMS_OUTPUT.PUT_LINE('Opponent have to score '|| target_Scores ||' runs to win the match.');

        else
            -- SELECT myTeamId,oppTeamId INTO myTeam_Id,oppTeam_Id FROM scorecard WHERE gameId=game_id;
            -- SELECT totalWin,totalLose,totalTie INTO totalWins_p,totalLoses_P,totalTies_P FROM country2@site1 WHERE countryId=myTeam_Id;
            -- SELECT totalWin,totalLose,totalTie INTO totalWins_O,totalLoses_O,totalTies_O FROM country2@site1 WHERE countryId=oppTeam_Id;
            SELECT oppScores into oppTotalRun FROM opponentScore WHERE opponentScoreId=game_id;
            if myTotalRun = oppTotalRun then
                DBMS_OUTPUT.PUT_LINE('opponent Total Run = '||oppTotalRun);
                DBMS_OUTPUT.PUT_LINE('Your Total Run = '||myTotalRun);
                DBMS_OUTPUT.PUT_LINE('match is tied.');
                
            elsif myTotalRun < oppTotalRun then
                DBMS_OUTPUT.PUT_LINE('opponent Total Run = '||oppTotalRun);
                DBMS_OUTPUT.PUT_LINE('Your Total Run = '||myTotalRun);
                DBMS_OUTPUT.PUT_LINE('you lost the match..');
               
            end if;

        end if;

END isBat;
/

accept x number prompt 'Press enter to face 1st ball. '
-- call the procedure.
BEGIN
	isBat;
	
END;
/

accept x number prompt 'Press enter to face 2nd ball. '
-- call the procedure.
BEGIN
	isBat;
	
END;
/
accept x number prompt 'Press enter to face 3rd ball. '
-- call the procedure.
BEGIN
	isBat;
	
END;
/
accept x number prompt 'Press enter to face 4th ball. '
-- call the procedure.
BEGIN
	isBat;
	
END;
/
accept x number prompt 'Press enter to face 5th ball. '
-- call the procedure.
BEGIN
	isBat;
	
END;
/
accept x number prompt 'Press enter to face 6th ball. '
-- call the procedure.
DECLARE
    game_ids number;
    lastGameID_Opp number;
    myRun varchar2(20);
    myTotalRun number :=0;
    oppTeam varchar2(20);
    i int;
    targetScore int;
    oppScore int;
    oppTeam_Id scorecard.oppTeamId%TYPE;

    totalWins_p number;
    totalLoses_P number;
    totalTies_P number;
    totalWins_O number;
    totalLoses_O number;
    totalTies_O number;
    player1Team_id scorecard.myTeamId%TYPE;
BEGIN
	isBat;

    SELECT COUNT(gameId) INTO game_ids FROM scorecard;
    FOR R IN (SELECT * FROM player1 WHERE player1ID=game_ids) LOOP
                i:=i+1;
                myRun := R.run;
                if myRun = '1' then
                    myTotalRun := myTotalRun+1;
                elsif myRun = '2' then
                    myTotalRun := myTotalRun+2;
                elsif myRun = '3' then
                    myTotalRun := myTotalRun+3;
                elsif myRun = '4' then
                    myTotalRun := myTotalRun+4;
                elsif myRun = '5' then
                    myTotalRun := myTotalRun+5;
                elsif myRun = '6' then
                    myTotalRun := myTotalRun+6;
                end if;

        END LOOP; 
        DBMS_OUTPUT.PUT_LINE('Your score is '||myTotalRun||' runs');

    SELECT count(opponentScoreId)  into lastGameID_Opp FROM opponentScore WHERE opponentScoreId = game_ids;
    if lastGameID_Opp>0 then
        SELECT oppTeamId INTO oppTeam_Id FROM scorecard WHERE gameId=game_ids;
        SELECT countryName INTO oppTeam FROM country WHERE countryId=oppTeam_Id;

        SELECT oppScores  into oppScore FROM opponentScore WHERE opponentScoreId = game_ids;

        DBMS_OUTPUT.PUT_LINE('Opponent '||oppTeam||' team socres: ');   
        DBMS_OUTPUT.PUT_LINE(oppScore || ' runs.');
        DBMS_OUTPUT.PUT_LINE('opponent Total Run = '||oppScore);
        DBMS_OUTPUT.PUT_LINE('Your Total Run = '||myTotalRun);

        SELECT myTeamId INTO player1Team_id FROM scorecard WHERE gameId=game_ids;

        SELECT totalWin,totalLose,totalTie INTO totalWins_p,totalLoses_P,totalTies_P FROM country2@site1 WHERE countryId=player1Team_id;
        SELECT totalWin,totalLose,totalTie INTO totalWins_O,totalLoses_O,totalTies_O FROM country2@site1 WHERE countryId=oppTeam_Id;

        if myTotalRun = oppScore then
            DBMS_OUTPUT.PUT_LINE('match is tied.');
            totalTies_P := totalTies_P+1;
            UPDATE country2@site1
            SET totalTie= totalTies_P
            WHERE countryId = player1Team_id;

            totalTies_O := totalTies_O+1;
            UPDATE country2@site1
            SET totalTie= totalTies_O
            WHERE countryId = oppTeam_Id;
            commit;
        elsif myTotalRun > oppScore then
            DBMS_OUTPUT.PUT_LINE('you won the match......!!!!!!!!!!');
            totalWins_p := totalWins_p+1;
            UPDATE country2@site1
            SET totalWin= totalWins_p
            WHERE countryId = player1Team_id;

            totalLoses_O := totalLoses_O+1;
            UPDATE country2@site1
            SET totalLose= totalLoses_O
            WHERE countryId = oppTeam_Id;
            commit;
        else
            DBMS_OUTPUT.PUT_LINE('you lost the match..');
            totalLoses_P := totalLoses_P+1;
            UPDATE country2@site1
            SET totalLose= totalLoses_P
            WHERE countryId = player1Team_id;

            totalWins_O := totalWins_O+1;
            UPDATE country2@site1 
            SET totalWin= totalWins_O
            WHERE countryId = oppTeam_Id;
            commit;
        end if;
    
    else
        targetScore := myTotalRun+1;
        DBMS_OUTPUT.PUT_LINE('Opponent have to score '|| targetScore ||' runs to win the match.');

    end if;

END;
/

