USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.synonyms WHERE [object_id] = OBJECT_ID('pbl.Places'))
	DROP SYNONYM pbl.Places

CREATE SYNONYM pbl.Places
	FOR [Kama.Mefa.Organization].pbl.Place
GO