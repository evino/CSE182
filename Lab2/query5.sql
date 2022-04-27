-- Evin Odisho
-- edodisho

SELECT Distinct hrr.horseID AS theHorseID, h.horseName AS theHorseName,
rp1.personName AS theOwnerName, s.stableName AS theStableName,
rp2.personName AS theStableOwnerName
FROM HorseRaceResults hrr, Horses h, RacingPersons rp1, RacingPersons rp2, Stables s
WHERE
hrr.finishPosition = 1
AND hrr.horseID = h.horseID
AND rp1.personID = h.horseOwnerID
AND s.stableID = h.stableID
AND s.stableOwnerID = rp2.personID
