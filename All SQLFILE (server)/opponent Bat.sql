SET VERIFY OFF;
SET SERVEROUTPUT ON;

DECLARE
    oppSelect pls_integer;
    oppTeam varchar2(20);
    country_id country.countryId%TYPE;
    i int;
    targetScore int;
    oppScore pls_integer;
    game_id scorecard.gameId%TYPE;
    oppTeam_Id scorecard.oppTeamId%TYPE;
    player1Team_id scorecard.myTeamId%TYPE;

    totalWins_p number;
    totalLoses_P number;
    totalTies_P number;
    totalWins_O number;
    totalLoses_O number;
    totalTies_O number;

    flag number;
    who_Bat number;
    totalGame number;
    totalGame_OPP number;

    player_RowCount number;
    Opp_RowCount number;
    lastGameID_Player1 number;
    lastGameID_Opp number;
    lastGameID_check number;
    oppTotalRun number;
    myRun varchar2(20);
    myTotalRun number :=0;
BEGIN

    SELECT COUNT(gameId) INTO game_id FROM scorecard;
    
    SELECT myTeamId INTO player1Team_id FROM scorecard WHERE gameId=game_id;
    SELECT oppTeamId INTO oppTeam_Id FROM scorecard WHERE gameId=game_id;
    
    SELECT countryName INTO oppTeam FROM country WHERE countryId=oppTeam_Id;
    DBMS_OUTPUT.PUT_LINE('Opponent '||oppTeam||' team socres: ');
    oppScore:= dbms_random.value(5,20);
    DBMS_OUTPUT.PUT_LINE(oppScore || ' runs.');

    insert into opponentScore values(game_id,oppScore);

    SELECT count(player1ID)  into lastGameID_Player1 FROM player1 WHERE player1ID = game_id ;

    if lastGameID_Player1>0 then
        lastGameID_check := 1;  -- opp second bat
    else
        lastGameID_check := 0;  -- opp first bat
    end if;
    
    if lastGameID_check = 0 then
        targetScore := oppScore+1;
        DBMS_OUTPUT.PUT_LINE('You have to score '|| targetScore ||' runs to win the match.');
    
    elsif lastGameID_check = 1 then
        FOR R IN (SELECT * FROM player1 WHERE player1ID=game_ID) LOOP
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
        
        DBMS_OUTPUT.PUT_LINE('opponent Total Run = '||oppScore);
        DBMS_OUTPUT.PUT_LINE('Your Total Run = '||myTotalRun);


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
    
    end if;

END;
/