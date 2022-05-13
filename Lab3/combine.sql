-- CSE 182 Spring 2022
-- Evin Odisho
-- edodisho
-- Lab 3 Combine file

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

UPDATE RacingPersons
SET registryDate = c.registryDate, personName = c.personName, canBeTrainer = TRUE
FROM ChangeRacingPersons c
WHERE RacingPersons.personID = c.personID;


INSERT INTO RacingPersons(personID, personName, registryDate, canBeJockey, canBeTrainer)
SELECT personID, personName, registryDate, TRUE, TRUE
FROM ChangeRacingPersons c
WHERE c.personID NOT IN (SELECT personID
                        FROM RacingPersons
                        );


--INSERT INTO RacingPersons(personID, personName, registryDate, canBeJockey, canBeTrainer)
--SELECT personID, personName, registryDate, TRUE, TRUE
--FROM RacingPersons
--WHERE personID NOT IN (SELECT c.personID
--						FROM ChangeRacingPersons c
--						);


COMMIT TRANSACTION;
