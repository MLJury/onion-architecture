USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spGetDivisionOfLabor'))
	DROP PROCEDURE adm.spGetDivisionOfLabor
GO

CREATE PROCEDURE adm.spGetDivisionOfLabor
	@AID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID
		
	SELECT
		dl.ID
		, dl.PositionID
		, dl.FromLetterType
		, dl.ToLetterType
		, usr.FirstName
		, usr.LastName
		, pos.[Type] PositionType
	FROM adm.DivisionOfLabor dl 
	INNER JOIN org.Positions pos ON dl.PositionID = pos.ID
	INNER JOIN org.Users usr ON pos.UserID = usr.ID
	WHERE (dl.ID = @ID)

	RETURN @@ROWCOUNT
END