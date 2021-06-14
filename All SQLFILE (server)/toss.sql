SET VERIFY OFF;
SET SERVEROUTPUT ON;
accept x number prompt 'select side : (0 = head, 1 = tail)= '

DECLARE
    toss number;
    n int;

BEGIN
    toss := &x;
    IF toss = 0 OR toss = 1 THEN

        n := dbms_random.value(0,10);
        -- DBMS_OUTPUT.PUT_LINE('before n= '|| n);
        if n>=5 then
            n:= 1;
            DBMS_OUTPUT.PUT_LINE('It is tail = '|| n);
        elsif n<5 then
            n:= 0;
            DBMS_OUTPUT.PUT_LINE('It is head = '|| n);
        end if;
        -- DBMS_OUTPUT.PUT_LINE('after n= '|| n);

        if n=toss then
            DBMS_OUTPUT.PUT_LINE('You win the toss.');
            DBMS_OUTPUT.PUT_LINE('You have to choose bat or ball.');
            --function will call for bat or ball
            --@"F:\4.1\(4126) LAB_Distributed Database Systems Lab\project (cricket)\chooseBatOrBall.sql";
            --@"F:\4.1\(4126) LAB_Distributed Database Systems Lab\project (cricket)\executechooseBatOrBall.sql";
            --raise chooseBat;

        else 
            DBMS_OUTPUT.PUT_LINE('You lost the toss. opponent will deceide to bat or ball.');
        end if;
        

    ELSE
        DBMS_OUTPUT.PUT_LINE('invalid input. please press 0 = head, 1 = tail next time.');
    END IF;

-- EXCEPTION
--     WHEN chooseBat THEN
-- 		@"F:\4.1\(4126) LAB_Distributed Database Systems Lab\project (cricket)\functionBatting.sql";
    
    
END;
/