USE tp4d5;
GO

CREATE TRIGGER nine_inch_nails.trg_iNouvellePisteParution
ON nine_inch_nails.PisteParution
AFTER INSERT
AS
BEGIN
    DECLARE @ParutionId int;

    SELECT @ParutionId=ParutionId FROM inserted;
    
    UPDATE nine_inch_nails.Parution
    SET NbPiste = NbPiste + 1
    WHERE ParutionId = @ParutionId;
END
GO

-- Ici on a besoin que le fichier de procédures a bien été actioné avant

SELECT 0 AS [AVANT INSERT], NbPiste 
FROM nine_inch_nails.Parution
WHERE Nom = N'TRON: ARES';
GO

EXEC nine_inch_nails.usp_AjouterPiste @Nom=N'Shadow Over Me', @TypePiste=N'originale', @NomParution=N'TRON: ARES', @DureeSec=237, @EstInstrumentale=0, @AGagneGrammy=1
GO

SELECT 0 AS [APRES INSERT], NbPiste 
FROM nine_inch_nails.Parution
WHERE Nom = N'TRON: ARES';
GO
