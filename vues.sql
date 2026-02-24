USE tp4d5;
GO

CREATE VIEW nine_inch_nails.vw_AlbumsPistes
AS
	SELECT A.Nom AS [Parution], A.TypeParution, P.Nom AS [Piste], P.DureeSec, 
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
	GROUP BY P.PisteId, A.ParutionId, A.Nom, P.Nom, A.TypeParution, P.DureeSec, P.EstInstrumentale, P.AGagneGrammy
GO