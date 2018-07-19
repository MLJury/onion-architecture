USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spGetAdmissions'))
	DROP PROCEDURE adm.spGetAdmissions
GO

CREATE PROCEDURE adm.spGetAdmissions
	@AType TINYINT,
	@ATitle NVARCHAR(1000),
	@APageIndex int,
	@APageSize int
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@Type TINYINT = COALESCE(@AType, 0),
		@Title NVARCHAR(1000) = LTRIM(RTRIM(@ATitle)),
		@PageIndex int = coalesce(@APageIndex, 0),
		@PageSize int = coalesce(@APageSize, 0)

	IF @PageIndex = 0 
	BEGIN
		SET @pagesize = 10000000
		SET @PageIndex = 1
	END

	SELECT 
		Count(*) OVER() Total,
		adm.ID	
		, adm.[Type]
		, adm.[Year]
		, adm.Title
		, adm.RegisterStartDate
		, adm.RegisterEndDate
		, adm.RegisterExtendDate
		, adm.RegistrationFee
	FROM adm.Admission adm 
	WHERE (@Type < 1 OR adm.[Type] = @Type)
		AND (@Title IS NULL OR adm.Title LIKE '%' + @Title + '%')
	Order By adm.[Year]
	OFFSET ((@PageIndex - 1) * @PageSize) ROWS FETCH NEXT @PageSize ROWS ONLY;

	RETURN @@ROWCOUNT
END