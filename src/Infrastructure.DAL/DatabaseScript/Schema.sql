USE [Kama.Mefa.Azmoon]
GO

---------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM sys.schemas WHERE [Name] = 'usr')
	DROP SCHEMA usr
GO

CREATE SCHEMA usr
GO

---------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM sys.schemas WHERE [Name] = 'org')
	DROP SCHEMA org
GO

CREATE SCHEMA org
GO

---------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM sys.schemas WHERE [Name] = 'pbl')
	DROP SCHEMA pbl
GO

CREATE SCHEMA pbl
GO
---------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM sys.schemas WHERE [Name] = 'app')
	DROP SCHEMA app
GO

CREATE SCHEMA app
GO
