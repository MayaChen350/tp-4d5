CREATE DATABASE tp4d5;
GO

USE tp4d5;
GO

CREATE SCHEMA nine_inch_nails;
GO

CREATE TABLE nine_inch_nails.Parution(
	ParutionId int IDENTITY (1,1) NOT NULL,
	Nom nvarchar(50) NOT NULL,
	TypeParution nvarchar(6) NOT NULL,
	DateSortie date NOT NULL,
	NbVente int NOT NULL,
	NbPiste smallint NOT NULL,
	CONSTRAINT PK_Parution_ParutionId PRIMARY KEY (ParutionId),
);
GO

ALTER TABLE nine_inch_nails.Parution
ADD CONSTRAINT UC_Parution_Nom UNIQUE (Nom);
GO

ALTER TABLE nine_inch_nails.Parution
ADD CONSTRAINT CK_Parution_TypeParution
CHECK (TypeParution in ('album', 'single', 'ep'));
GO

CREATE TABLE nine_inch_nails.Piste(
	PisteId int IDENTITY (1,1) NOT NULL,
	Nom nvarchar(50) NOT NULL,
	TypePiste nvarchar(9) NOT NULL,
	DureeSec smallint NOT NULL,
	AGagneGrammy bit NOT NULL,
	CONSTRAINT PK_Piste_PisteId PRIMARY KEY (PisteId),
);
GO

ALTER TABLE nine_inch_nails.Piste
ADD CONSTRAINT CK_Piste_TypePiste
CHECK (TypePiste in ('originale', 'remix', 'live', 'demo'));
GO

ALTER TABLE nine_inch_nails.Piste
ADD CONSTRAINT DF_Piste_AGagneGrammy DEFAULT 0 FOR AGagneGrammy
GO

CREATE TABLE nine_inch_nails.PisteParution(
	PisteParutionId int IDENTITY (1,1) NOT NULL,
	PisteId int NOT NULL,
	ParutionId int NOT NULL,
	CONSTRAINT PK_PisteParution_PisteParutionId PRIMARY KEY (PisteParutionId)
);
GO

ALTER TABLE nine_inch_nails.PisteParution
ADD CONSTRAINT FK_PisteParution_PisteId
FOREIGN KEY (PisteId)
REFERENCES nine_inch_nails.Piste (PisteId)
ON DELETE CASCADE;
GO

ALTER TABLE nine_inch_nails.PisteParution
ADD CONSTRAINT FK_PisteParution_ParutionId
FOREIGN KEY (ParutionId)
REFERENCES nine_inch_nails.Parution (ParutionId)
ON DELETE CASCADE;
GO

CREATE TABLE nine_inch_nails.Videoclip(
	VideoclipId int IDENTITY (1,1) NOT NULL,
	NomOfficiel nvarchar(50) NOT NULL,
	DateSortie date NOT NULL,
	PisteId int NOT NULL,
	CONSTRAINT PK_Videoclip_VideoclipId PRIMARY KEY (VideoclipId)
);
GO

ALTER TABLE nine_inch_nails.Videoclip
ADD CONSTRAINT FK_Videoclip_PisteId
FOREIGN KEY (PisteId)
REFERENCES nine_inch_nails.Piste (PisteId)
ON DELETE CASCADE;
GO

ALTER TABLE nine_inch_nails.Videoclip
ADD CONSTRAINT UC_Videoclip_NomOfficiel UNIQUE (NomOfficiel);
GO

CREATE TABLE nine_inch_nails.Tournee(
	TourneeId int IDENTITY (1,1) NOT NULL,
	NomOfficiel nvarchar(50) NOT NULL,
	AnneeDebut smallint NOT NULL,
	AnneeFin smallint NULL,
	CONSTRAINT PK_Tournee_TourneeId PRIMARY KEY (TourneeId)
);
GO

ALTER TABLE nine_inch_nails.Tournee
ADD CONSTRAINT UC_Tournee_NomOfficiel UNIQUE (NomOfficiel);
GO

CREATE TABLE nine_inch_nails.PisteTournee(
	PisteTourneeId int IDENTITY (1,1) NOT NULL,
	PisteId int,
	TourneeId int,
	CONSTRAINT PK_PisteTournee_PisteTourneeId PRIMARY KEY (PisteTourneeId)
);
GO

ALTER TABLE nine_inch_nails.PisteTournee
ADD CONSTRAINT FK_PisteTournee_PisteId
FOREIGN KEY (PisteId)
REFERENCES nine_inch_nails.Piste (PisteId)
ON DELETE CASCADE;
GO

ALTER TABLE nine_inch_nails.PisteTournee
ADD CONSTRAINT FK_PisteTournee_TourneeId
FOREIGN KEY (TourneeId)
REFERENCES nine_inch_nails.Tournee (TourneeId)
ON DELETE CASCADE;
GO