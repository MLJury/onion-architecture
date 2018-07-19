USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spGetEducationField'))
	DROP PROCEDURE pbl.spGetEducationField
GO

CREATE PROCEDURE pbl.spGetEducationField
	@AID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID
		
	SELECT
		ef.ID,
		ef.Code,
		ef.[Name],
		ef.EducationFieldType,
		ef.[Enable],
		ef.[Order]
	FROM pbl.EducationField ef
	WHERE ef.ID = @ID

	RETURN @@ROWCOUNT
END