SET VERIFY OFF;
SET SERVEROUTPUT ON;

DECLARE
    game_id number;
    player_name_bat varchar2(20);
    player_name_bowl varchar2(20);
    ball int := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Game_no   ' ||'Ball_no   ' || 'Runs    '  || 'Batsman_Name    '||'Bowler_Name' );
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------');

    SELECT count(gameId) into game_id  FROM scorecard;
    FOR R IN (SELECT * FROM player1 WHERE player1ID = game_id) LOOP
        ball := ball+1;
        SELECT playerName into player_name_bat from playerList WHERE playerId = R.batsmanPlayerId;
        SELECT playerName into player_name_bowl from playerList WHERE playerId = R.bowlerPlayerId;
        DBMS_OUTPUT.PUT_LINE(R.player1ID ||'        '|| ball ||'          '|| R.run || '     ' || player_name_bat || '   ' || player_name_bowl);
        
    END LOOP;

END;
/
