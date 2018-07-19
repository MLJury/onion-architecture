USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spGetDeprivedsByNationalCode'))
	DROP PROCEDURE adm.spGetDeprivedsByNationalCode
GO

CREATE PROCEDURE adm.spGetDeprivedsByNationalCode
	@ANationalCode nvarchar(11)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @NationalCode nvarchar(11) = @ANationalCode

	SELECT
		deprived.*,
		[user].FirstName,
		[user].LastName,
		[user].Email
	FROM adm.Deprived deprived
	inner join org.Users [user] on [user].NationalCode = deprived.NationalCode
	WHERE (deprived.NationalCode = @NationalCode)
	Order By deprived.CreationDate

	RETURN @@ROWCOUNT
END