USE tp4d5
GO

-- Fonction pour voir la dernière sortie à une date précise
CREATE OR ALTER FUNCTION nine_inch_nails.ufn_ObtenirPistesPourParution
( @Annee int, @Mois int, @Jour int )
RETURNS nvarchar(50)
AS
BEGIN
	DECLARE @JourMoisAnneeComparateur int;
	SELECT @JourMoisAnneeComparateur = @Jour + (@Mois * 31) + (@Annee * 366)

	RETURN (
	SELECT TOP(1) Nom
	FROM nine_inch_nails.Parution
	WHERE DAY(DateSortie) + (Month(DateSortie) * 31) + (YEAR(DateSortie) * 366) <= @JourMoisAnneeComparateur
	ORDER BY DateSortie DESC
	)
END
GO

-- Voir c'était quoi la dernière sortie de Nine Inch Nails le jour de ma naissance
SELECT nine_inch_nails.ufn_ObtenirPistesPourParution(2005, 02, 10) AS [Dernière sortie de Nine Inch Nails le 10 février 2005]