USE tp4d5;
GO

-- Vue affichant toutes les pistes avec chacune leur album et d'autres informations telles que:
-- le type de parution, le type de piste, combien de tournée elle a figuré dedans et si elle a un vidéoclip
CREATE VIEW nine_inch_nails.vw_AlbumsPistes
AS
	SELECT A.Nom AS [Parution], A.TypeParution, P.Nom AS [Piste], P.TypePiste, P.DureeSec, 
	IIF(COUNT(V.VideoclipId) >= 1, 1, 0) AS [AUnVideoClip], COUNT(Pt.PisteTourneeId) AS [NbTournee],
	P.EstInstrumentale, P.AGagneGrammy, A.ParutionId, P.PisteId
	FROM nine_inch_nails.Piste P
	LEFT JOIN nine_inch_nails.Videoclip V
	ON P.PisteId = V.PisteId
	LEFT JOIN nine_inch_nails.PisteTournee Pt
	ON P.PisteId = Pt.PisteId
	INNER JOIN nine_inch_nails.PisteParution PA
	ON PA.PisteId = P.PisteId
	INNER JOIN nine_inch_nails.Parution A
	ON PA.ParutionId = A.ParutionId
	GROUP BY P.PisteId, A.ParutionId, A.Nom, P.Nom, A.TypeParution, P.DureeSec, P.EstInstrumentale, P.AGagneGrammy, P.TypePiste
GO

-- Cherche toutes les pistes avec un vidéoclip et montre de quel sortie elle vient,
-- combien de temps elle dure et le nombre de fois qu'elle est dans une tournée
-- Classé par albun
SELECT Piste AS [Nom], Parution, RIGHT(CONVERT(CHAR(8),DATEADD(second,DureeSec,0),108),5) AS [Durée], NbTournee AS [Nombre de fois dans une tournée]
FROM nine_inch_nails.vw_AlbumsPistes
WHERE AUnVideoClip = 1
ORDER BY Parution ASC

-- Pour la conversion de temps:
-- SELECT RIGHT(CONVERT(CHAR(8),DATEADD(second,90,0),108),5)

-- Source - https://stackoverflow.com/a/2316347
-- Posted by Carlos Gutiérrez, modified by community. See post 'Timeline' for change history
-- Retrieved 2026-02-26, License - CC BY-SA 2.5