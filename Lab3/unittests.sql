

--fk Unit tests

INSERT INTO Horses
VALUES (553, 'Night Rider', 'A', DATE '2019-05-13', 15, 6008, 6007);

INSERT INTO Horses
VALUES (555, 'Essential Quality', 'M', DATE '2018-03-26', 1001, 16, 6008);

INSERT INTO Horses
VALUES (530, 'Easy Rider', 'M', DATE '2017-02-28', 1003, 6011, 11);


--general Unit tests

-- meets constraint for first positveTrackDistance Constraint
UPDATE Racetracks
SET trackDistance = trackDistance
WHERE (trackDistance > 0);

-- violates constraint for first positveTrackDistance Constraint
UPDATE Racetracks
SET trackDistance = -1
WHERE (trackDistance < 0);



-- meets constraint for notBothOwnerTrainer
UPDATE Horses
SET trainerID = trainerID
WHERE (trainerID != horseOwnerID);

-- violates constraint for notBothOwner Trainer
UPDATE Horses
SET trainerID = horseOwnerID;
WHERE (trainerID = 6011);



-- meets constraint for bigChristmasPrize Constraint
UPDATE Races
SET winningPrize = winningPrize, raceDate = raceDate
WHERE (winningPrize > 1200 and raceDate = DATE '2021-12-25');

--violates constraint for bigChristmasPrize constraint
UPDATE Races
SET winningPrize = 100, raceDate = DATE '2022-1-10';
WHERE (winningPrize <= 1200 AND raceDate != DATE '2021-12-25');


