-- Evin Odisho
-- edodisho
-- Lab 3
-- creatview.sql

CREATE VIEW LastPlaceHorsesView AS
	SELECT DISTINCT horseID, racetrackID, raceDate, raceNum, finishPosition
	FROM HorseRaceResults
	WHERE finishPosition >= (SELECT MAX(res.finishPosition)
							FROM HorseRaceResults res
                            WHERE racetrackID = res.racetrackID, raceDate = res.raceDate, raceNum = res.raceNum, finishPosition = res.finishPosition);
