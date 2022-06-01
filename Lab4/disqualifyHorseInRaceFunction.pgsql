CREATE OR REPLACE FUNCTION
disqualifyHorseInRaceFunction(theHorseID INTEGER, theRacetrackID INTEGER, theRaceDate DATE, theRaceNum INTEGER)
RETURNS INTEGER AS $$

	DECLARE
		numDisqualified INTEGER;
		numImproved INTEGER;
		finish_position INTEGER;

	BEGIN

	PERFORM FROM HorseRaceResults
	WHERE horseID = theHorseID
	AND racetrackID = theRacetrackID
	AND raceDate = theRaceDate
	AND raceNum = theRaceNum;

	GET DIAGNOSTICS numDisqualified = ROW_COUNT;

	IF numDisqualified = 0 THEN
		return -1;
	END IF;

	SELECT finishPosition INTO finish_position
	FROM HorseRaceResults
	WHERE horseID = theHorseID
	AND racetrackID = theRacetrackID
	AND raceDate = theRaceDate
	AND raceNum = theRaceNum;

	IF finish_position is NULL THEN
		return -2;
	END IF;

	
	UPDATE HorseRaceResults
	SET finishPosition = NULL
	WHERE horseID = theHorseID
	AND racetrackID = theRacetrackID
	AND raceDate = theRaceDate
	AND raceNum = theRaceNum;

	UPDATE HorseRaceResults
	SET finishPosition = finishPosition - 1
	WHERE horseID = theHorseID
	AND racetrackID = theRacetrackID
	AND raceDate = theRaceDate
	AND raceNum = theRaceNum
	AND finish_position < finishPosition;

	GET DIAGNOSTICS numImproved = ROW_COUNT;

	return numImproved;


	END

$$ LANGUAGE plpgsql;


