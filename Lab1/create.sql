CREATE TABLE RacingPersons (
    personID INT,
    personName VARCHAR(30),
    registryDate DATE,
    canBeJockey BOOLEAN,
    canBeTrainer BOOLEAN,
    PRIMARY KEY (personID)
);

CREATE TABLE Stables (
    stableID INT,
    stableName VARCHAR(30),
    address VARCHAR(50),
    stableOwnerID INT,
    PRIMARY KEY (stableID),
    FOREIGN KEY (stableOwnerID) REFERENCES RacingPersons
);

CREATE TABLE Horses (
    horseID INT,
    horseName VARCHAR(30),
    horseBreed CHAR(1),
    birthDate DATE,
    stableID INT,
    trainerID INT,
    horseOwnerID INT,
    PRIMARY KEY (horseID),
    FOREIGN KEY (stableID) REFERENCES Stables,
    FOREIGN KEY (trainerID, horseOwnerID) REFERENCES RacingPersons
);

CREATE TABLE Racetracks (
    racetrackID INT,
    trackName VARCHAR(30),
    address VARCHAR(50),
    trackDistance NUMERIC(2,1),
    PRIMARY KEY (racetrackID)
);

CREATE TABLE Races (
    racetrackID INT,
    raceDate DATE,
    raceNum INT,
    raceStartTime TIME,
    winningPrize NUMERIC(5,2),
    PRIMARY KEY (racetrackID, raceDate, raceNum),
    FOREIGN KEY (racetrackID) REFERENCES Racetracks
);

CREATE TABLE HorseRaceResults (
    racetrackID INT,
    raceDate DATE,
    raceNum INT,
    horseID INT,
    jockeyID INT,
    finishPosition INT,
    raceFinishTime TIME,
    PRIMARY KEY (racetrackID, raceDate, raceNum, horseID),
    FOREIGN KEY (racetrackID, raceDate, raceNum) REFERENCES Races,
    FOREIGN KEY (horseID) REFERENCES Horses,
    FOREIGN KEY (jockeyID) REFERENCES RacingPersons
);
