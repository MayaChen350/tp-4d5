USE tp4d5;
GO

-- Q1
SELECT COUNT(VideoClipId) AS [Nombre de chansons avec un clip vidéo] 
FROM nine_inch_nails.Videoclip;
GO

-- Q2
SELECT P.Nom, COUNT(P.Nom) AS [Total des albums où la piste figure] 
FROM nine_inch_nails.PisteParution Pa
INNER JOIN nine_inch_nails.Piste P
ON P.PisteId = Pa.PisteId
GROUP BY P.Nom
HAVING COUNT(P.Nom) > 1;
GO

-- Q3
SELECT TOP(5) Nom, DateSortie, NbVente 
FROM nine_inch_nails.Parution
WHERE DateSortie > '1999-12-31'
ORDER BY NbVente DESC, DateSortie DESC;
GO

-- Q4
SELECT COUNT(PisteID) AS [Nombre de pistes instrumentales] 
FROM nine_inch_nails.Piste
WHERE EstInstrumentale = 1;
GO

-- Q5
WITH
ChansonsSelectiones AS ( SELECT PisteId
                        FROM nine_inch_nails.PisteParution
                        WHERE ParutionId IN ( SELECT ParutionId
                                      FROM nine_inch_nails.Parution
                                      WHERE TypeParution = 'album' AND NbVente < (SELECT AVG(NbVente) FROM nine_inch_nails.Parution)))
SELECT Nom, COUNT(Tp.PisteId) AS [Nombre de tournées]
FROM nine_inch_nails.Piste P
LEFT JOIN ChansonsSelectiones C
ON C.PisteId = P.PisteId
INNER JOIN nine_inch_nails.PisteTournee Tp
ON P.PisteId = Tp.PisteId
WHERE P.PisteId = C.PisteId
GROUP BY Nom
ORDER BY COUNT(Tp.PisteId);
GO
