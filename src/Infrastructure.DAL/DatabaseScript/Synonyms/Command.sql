USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.synonyms WHERE [object_id] = OBJECT_ID('org.Command'))
	DROP SYNONYM org.Command

CREATE SYNONYM org.Command
	FOR [Kama.Mefa.Organization].org.Command
GO