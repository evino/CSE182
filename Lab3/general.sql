-- Evin Odisho
-- edodisho
-- general.sql

ALTER TABLE Racetracks
ADD CONSTRAINT positiveTrackDistance
CHECK(trackDistance > 0 AND trackDistance IS NOT NULL);
--CHECK(trackDistance > 0);

ALTER TABLE Horses
ADD CONSTRAINT notBothOwnerTrainer
CHECK(trainerID <> horseOwnerID);


ALTER TABLE Races
ADD CONSTRAINT bigChristmasPrize
CHECK(raceDate != DATE '2021-12-25' OR (raceDate = DATE '2021-12-25' AND winningPrize > 1200)); --If p then q is logically equivalent to: NOT p OR q
