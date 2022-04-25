SELECT hrr.horseID, hrr.raceDate, hrr.finishPosition, hrr.raceFinishTime - r.raceStartTime AS horseRaceInterval
FROM HorseRaceResults hrr, Races r
WHERE hrr.raceFinishTime - r.raceStartTime > TIME 00:02:00
AND hrr.raceDate > DATE 2021-12-14
