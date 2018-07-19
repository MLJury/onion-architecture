USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spGetUniversity'))
	DROP PROCEDURE pbl.spGetUniversity
GO

CREATE PROCEDURE pbl.spGetUniversity
	@AID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID
		
	SELECT
		univ.ID,
		univ.Code,
		univ.[Name],
		univ.[Type],
		univ.[Enable],
		univ.[Order],
		univ.IsInternal
	FROM pbl.University univ
	WHERE univ.ID = @ID

	RETURN @@ROWCOUNT
END