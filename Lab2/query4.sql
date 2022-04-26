-- Evin Odisho
-- edodisho
-- Query4.sql
-- Lab 2

SELECT rt.racetrackID, rt.trackName, rt.trackDistance
FROM Racetracks rt
WHERE rt.trackDistance < 20 AND rt.address LIKE '_e%' AND
rt.trackName LIKE '%Park' AND rt.racetrackID NOT IN
    (SELECT r2.racetrackID
        FROM Races r2
        --From Racetracks r2
    );
