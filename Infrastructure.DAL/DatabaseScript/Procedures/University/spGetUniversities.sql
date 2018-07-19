USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spGetUniversities'))
	DROP PROCEDURE pbl.spGetUniversities
GO

CREATE PROCEDURE pbl.spGetUniversities
	@ACode NVARCHAR(1000),
	@AName NVARCHAR(1000),
	@AType TINYINT,
	@AEnableOrDisable TINYINT,    -- 1: enable, 2: disable, 0: all
	@APageSize INT,
	@APageIndex INT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@Code NVARCHAR(1000) = LTRIM(RTRIM(@ACode)),
		@Name NVARCHAR(1000) = LTRIM(RTRIM(@AName)),
		@Type TINYINT = COALESCE(@AType, 0),
		@EnableOrDisable TINYINT = COALESCE(@AEnableOrDisable, 0),
		@Enable BIT = CASE @AEnableOrDisable WHEN 1 THEN 1 ELSE 0 END, 
		@PageSize INT = COALESCE(@APageSize,10),
		@PageIndex INT = COALESCE(@APageIndex, 0)
		
	IF @PageIndex = 0 
	BEGIN
		SET @pagesize = 10000000
		SET @PageIndex = 1
	END

	SELECT
		count(*) over() Total,
		univ.ID,
		univ.Code,
		univ.[Name],
		univ.[Type],
		univ.[Enable],
		univ.[Order],
		univ.IsInternal
	FROM pbl.University univ
	WHERE (@Name IS NULL OR univ.[Name] like '%' + @Name + '%')
		AND (@Code IS NULL OR univ.Code like '%' + @Code + '%')
		AND (@Type < 1 OR univ.[Type] = @Type)
		AND (@EnableOrDisable < 1 OR univ.[Enable] = @Enable)
	ORDER BY univ.[Name]
	OFFSET ((@PageIndex - 1) * @PageSize) ROWS FETCH NEXT @PageSize ROWS ONLY;

	RETURN @@ROWCOUNT
END