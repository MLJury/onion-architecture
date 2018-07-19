USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.synonyms WHERE [object_id] = OBJECT_ID('org.Users'))
	DROP SYNONYM org.Users

CREATE SYNONYM org.Users
	FOR [Kama.Mefa.Organization].[org].[User]
GO