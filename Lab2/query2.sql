SELECT DISTINCT p.personID, p.personName, p.registryDate
FROM RacingPersons p, HorseRaceResults r
WHERE p.canBeJockey = FALSE AND r.jockeyID = p.personID
ORDER BY p.personName ASC, p.registryDate DESC;


