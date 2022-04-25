-- Evin Odisho --
-- edodisho --
-- Query 1 --
SELECT DISTINCT horseID, horseName, personName AS horseOwnerTrainerName
FROM RacingPersons, Horses
WHERE horseName IS NOT NULL AND horseOwnerID = trainerID AND horseOwnerID = personID;