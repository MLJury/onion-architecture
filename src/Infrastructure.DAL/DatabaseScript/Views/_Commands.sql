USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.synonyms WHERE [object_id] = OBJECT_ID('org._Command'))
	DROP SYNONYM org._Command

CREATE SYNONYM org._Command
	FOR [Kama.Mefa.Organization].[org].[_Commands]
GO