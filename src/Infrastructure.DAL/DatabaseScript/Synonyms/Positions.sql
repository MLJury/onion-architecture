USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.synonyms WHERE [object_id] = OBJECT_ID('org.Positions'))
	DROP SYNONYM org.Positions

CREATE SYNONYM org.Positions
	FOR [Kama.Mefa.Organization].[org].[Position]
GO