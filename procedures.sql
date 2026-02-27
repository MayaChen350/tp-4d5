USE tp4d5;
GO

-- Procédure stockée pour ajouter une parution
CREATE OR ALTER PROCEDURE nine_inch_nails.usp_AjouterParution
(   @Nom nvarchar(50), 
    @TypeParution nvarchar(6),
    @DateSortie date,
    @NbVente int
)
AS
BEGIN
    INSERT INTO nine_inch_nails.Parution 
    (Nom, TypeParution, DateSortie, NbVente, NbPiste)
    VALUES (@Nom, @TypeParution, @DateSortie, @NbVente, 0);
    
    SELECT *
    FROM nine_inch_nails.Parution
    WHERE ParutionId = SCOPE_IDENTITY();
END
GO

-- Procédure stockée pour ajouter une piste
CREATE OR ALTER PROCEDURE nine_inch_nails.usp_AjouterPiste
(   @Nom nvarchar(50), 
    @NomParution nvarchar(50),
    @TypePiste nvarchar(9),
	@DureeSec smallint,
    @EstInstrumentale bit,
	@AGagneGrammy bit
)
AS
BEGIN
    DECLARE @ParutionId int;
    DECLARE @PisteId int;

    SELECT @ParutionId = ParutionId FROM nine_inch_nails.Parution WHERE Nom = @NomParution;

    INSERT INTO nine_inch_nails.Piste
    (Nom, TypePiste, DureeSec, EstInstrumentale, AGagneGrammy)
    VALUES (@Nom, @TypePiste, @DureeSec, @EstInstrumentale, @AGagneGrammy);
    
    SELECT @PisteId = SCOPE_IDENTITY();

    INSERT INTO nine_inch_nails.PisteParution
    (PisteId, ParutionId)
    VALUES (@PisteId, @ParutionId);

    UPDATE nine_inch_nails.Parution
    SET NbPiste = NbPiste + 1
    WHERE ParutionId = @ParutionId;
    
    SELECT * FROM nine_inch_nails.Piste WHERE PisteId = @PisteId 
END
GO

-- Exécutions:

EXEC nine_inch_nails.usp_AjouterParution @Nom=N'TRON: ARES', @TypeParution=N'album', @DateSortie='2025-09-19', @NbVente=200000
EXEC nine_inch_nails.usp_AjouterPiste @Nom=N'As Alive As You Need Me To Be', @TypePiste=N'originale', @NomParution=N'TRON: ARES', @DureeSec=237, @EstInstrumentale=0, @AGagneGrammy=1
