USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spGetDepriveds'))
	DROP PROCEDURE adm.spGetDepriveds
GO

CREATE PROCEDURE adm.spGetDepriveds
	@AType tinyint,
	@AFirstName nvarchar(50),
	@ALastName nvarchar(50),
	@ANationalCode nvarchar(50),
	@APageIndex int,
	@APageSize int
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @Type tinyint = coalesce(@AType, 0),
			@FirstName nvarchar(50) = ltrim(rtrim(@AFirstName)),
			@LastName nvarchar(50) = ltrim(rtrim(@ALastName)),
			@NationalCode nvarchar(50) = ltrim(rtrim(@ANationalCode)),
			@PageIndex int = coalesce(@APageIndex, 0),
			@PageSize int = coalesce(@APageSize, 0)

	IF @PageIndex = 0 
	BEGIN
		SET @pagesize = 10000000
		SET @PageIndex = 1
	END

	SELECT deprived.*
	FROM adm.Deprived deprived
	WHERE (@Type < 1 or Type = @Type)
		AND (@FirstName is null or deprived.FirstName like CONCAT(N'%', @FirstName, N'%'))
		AND (@LastName is null or deprived.LastName like CONCAT(N'%', @LastName, N'%'))
		AND (@NationalCode is null or deprived.NationalCode like CONCAT(N'%', @NationalCode, N'%'))
	Order By deprived.CreationDate
	OFFSET ((@PageIndex - 1) * @PageSize) ROWS FETCH NEXT @PageSize ROWS ONLY;

	RETURN @@ROWCOUNT
END