-- Evin Odisho
-- edodisho
-- Lab 3
-- creatview.sql

CREATE VIEW LastPlaceHorsesView AS
	SELECT DISTINCT hrr.horseID, hrr.racetrackID, hrr.raceDate, hrr.raceNum, hrr.finishPosition
	FROM HorseRaceResults hrr
	WHERE hrr.finishPosition >= (SELECT MAX(res.finishPosition)
							FROM HorseRaceResults res
                            WHERE hrr.racetrackID = res.racetrackID,
                            hrr.raceDate = res.raceDate,
                            hrr.raceNum = res.raceNum,
                            hrr.finishPosition = res.finishPosition);
