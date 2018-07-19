USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spGetWorkPlace'))
	DROP PROCEDURE pbl.spGetWorkPlace
GO

CREATE PROCEDURE pbl.spGetWorkPlace
	@AID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID
		
	SELECT
		wp.ID,
		wp.Code,
		wp.[Name],
		wp.[Type],
		wp.NameNeeded,
		wp.[Enable],
		wp.[Order]
	FROM pbl.WorkPlace wp
	WHERE wp.ID = @ID

	RETURN @@ROWCOUNT
END