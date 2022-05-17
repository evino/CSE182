SELECT DISTINCT horseID, horseName, lastCount, maxLastPlaceFinish
FROM LastPlaceHorsesView
WHERE (maxLastPlaceFinish >= 3);
