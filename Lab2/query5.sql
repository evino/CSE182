
SELECT Distinct hrr.horseID AS theHorseID, h.horseName AS theHorseName,
rp.personName AS theOwnerName, s.stableName AS theStableName,
rp.personName AS theStableOwnerName
FROM HorseRaceResults hrr, Horses h, RacingPersons rp, Stables s
WHERE hrr.finishPositions = 1
AND hrr.horseID = h.horseID
AND rp.personID = h.horseOwnerID
AND s.stableOwnerID = h.horseOwnerID
