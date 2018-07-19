USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetApplicantFromMemaran'))
	DROP PROCEDURE req.spGetApplicantFromMemaran
GO

CREATE PROCEDURE req.spGetApplicantFromMemaran
	@ANationalCode VARCHAR(10)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @NationalCode VARCHAR(10) = @ANationalCode
		, @ID UNIQUEIDENTIFIER

	SET @ID = (SELECT Top 1 Code FROM [MEFA_Azmoon].dbo.PersonRequest WHERE LTRIM(RTRIM(NationalCode)) = @NationalCode ORDER BY CreateTime DESC)

	SELECT 
		NationalCode,
		Name FirstName,
		Family LastName,
		Mobile CellPhone,
		Email
	FROM [MEFA_Azmoon].dbo.PersonRequest
	WHERE Code = @ID

	RETURN @@ROWCOUNT
END