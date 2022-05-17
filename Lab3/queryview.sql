SELECT DISTINCT h.horseID, h.horseName, COUNT(hv.raceNum) AS lastCount, MAX(hv.finishPosition) AS maxLastPlaceFinish
FROM LastPlaceHorsesView hv, Horses h
WHERE h.horseID = hv.horseID
GROUP BY h.horseID
HAVING MAX(hv.finishPosition) >= 3;

--  OUTPUT
--  horseid |     horsename     | lastcount | maxlastplacefinish 
-- ---------+-------------------+-----------+--------------------
--      530 | Easy Rider        |         1 |                  5
--      550 | Tiz the Law       |         2 |                  3
--      551 |                   |         4 |                  5
--      555 | Essential Quality |         4 |                  7
--      575 |                   |         2 |                  3
-- (5 rows)

