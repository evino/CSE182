-- Evin Odisho
--edodisho
-- Lab 3
--queryview.sql

SELECT DISTINCT h.horseID, h.horseName, COUNT(hv.raceNum) AS lastCount, MAX(hv.finishPosition) AS maxLastPlaceFinish
FROM LastPlaceHorsesView hv, Horses h
WHERE h.horseID = hv.horseID
GROUP BY h.horseID
HAVING MAX(hv.finishPosition) >= 3;

--  OUTPUT of CountLastPlaces Query before deletes
--  horseid |     horsename     | lastcount | maxlastplacefinish 
-- ---------+-------------------+-----------+--------------------
--      530 | Easy Rider        |         1 |                  5
--      550 | Tiz the Law       |         2 |                  3
--      551 |                   |         4 |                  5
--      555 | Essential Quality |         4 |                  7
--      575 |                   |         2 |                  3
-- (5 rows)


-- Deleting from the HorseRaceResults tuple whose Primary Key is (3008, DATE ‘2022-02-26’, 2 ,555)
DELETE FROM HorseRaceResults
WHERE
racetrackID = 3008
AND raceDate = DATE '2022-02-26'
AND raceNum = 2
AND horseID = 555;

-- Deleting from the HorseRaceResults tuple whose Primary Key is (3001, DATE ‘2021-08-11’, 1, 551)
DELETE FROM HorseRaceResults
WHERE
raceTrackID = 3001
AND raceDate = DATE '2021-08-11'
AND raceNum = 1
AND horseID = 551;


-- OUTPUT of CountLastPlaces Query after deletes

--   horseid |     horsename     | lastcount | maxlastplacefinish 
--  ---------+-------------------+-----------+--------------------
--   530 | Easy Rider        |         1 |                  5
--   550 | Tiz the Law       |         2 |                  3
--   553 | Night Rider       |         1 |                  6
--   555 | Essential Quality |         3 |                  5
--   575 |                   |         2 |                  3
--   589 |                   |         2 |                  4
-- (6 rows)
