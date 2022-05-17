-- Evin Odisho
-- edodisho
-- Lab 3
-- creatview.sql

CREATE VIEW LastPlaceHorsesView AS
	SELECT DISTINCT hrr.horseID, hrr.racetrackID, hrr.raceDate, hrr.raceNum, hrr.finishPosition
	FROM HorseRaceResults hrr, HorseRaceResults res
	WHERE hrr.racetrackID = res.racetrackID
    AND hrr.raceDate = res.raceDate
    AND hrr.raceNum = res.raceNUm
    AND hrr.finishPosition >= (SELECT DISTINCT MAX(res.finishPosition)
							FROM HorseRaceResults res
                            WHERE
                            hrr.racetrackID = res.racetrackID AND
                            hrr.raceDate = res.raceDate AND
                            hrr.raceNum = res.raceNum);
