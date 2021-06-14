create or replace view myview(view_cntry_ID, view_cntry_Name, view_tot_Win, view_tot_Lose, view_tot_Tie) as
SELECT C.countryId , C.countryName, D.totalWin, D.totalLose, D.totalTie FROM country@server1 C, country2 D WHERE C.countryId = D.countryId;


select * from myview;
-- BEGIN 

--     FOR R IN (SELECT * FROM myview) LOOP
--         DBMS_OUTPUT.PUT_LINE(R.view_A || ' ' || R.view_B || ' ' || R.view_C || ' ' || R.view_D || ' ' || R.view_E);
--     END LOOP;
-- END;
-- /