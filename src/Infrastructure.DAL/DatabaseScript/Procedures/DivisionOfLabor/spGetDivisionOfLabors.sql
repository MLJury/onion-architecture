USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spGetDivisionOfLabors'))
	DROP PROCEDURE adm.spGetDivisionOfLabors
GO

CREATE PROCEDURE adm.spGetDivisionOfLabors
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

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
	ORDER BY pos.[Type], dl.FromLetterType

	RETURN @@ROWCOUNT
END