USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spGetWorkPlaces'))
	DROP PROCEDURE pbl.spGetWorkPlaces
GO

CREATE PROCEDURE pbl.spGetWorkPlaces
	@AName NVARCHAR(1000),
	@ACode NVARCHAR(1000),
	@AEnableOrDisable TINYINT,    -- 1: enable, 2: disable, 0: all
	@AType TINYINT,
	@APageSize INT,
	@APageIndex INT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@Name NVARCHAR(1000) = LTRIM(RTRIM(@AName)),
		@Code NVARCHAR(1000) = LTRIM(RTRIM(@ACode)),
		@Type TINYINT = COALESCE(@AType, 0),
		@EnableOrDisable TINYINT = COALESCE(@AEnableOrDisable, 0),
		@Enable BIT = CASE @AEnableOrDisable WHEN 1 THEN 1 ELSE 0 END, 
		@PageSize INT = COALESCE(@APageSize,20),
		@PageIndex INT = COALESCE(@APageIndex, 0)
	
	IF @PageIndex = 0 
	BEGIN
		SET @pagesize = 10000000
		SET @PageIndex = 1
	END
	
	IF @PageSize = 0 SET @PageSize=20
		
	SELECT
		count(*) over() Total,
		wp.ID,
		wp.Code,
		wp.[Name],
		wp.[Type],
		wp.NameNeeded,
		wp.[Enable],
		wp.[Order]
	FROM pbl.WorkPlace wp
	WHERE (@Name IS NULL OR wp.[Name] like '%' + @Name + '%')
		  AND (@Code IS NULL OR wp.Code like '%' + @Code + '%')
		  AND (@Type < 1 OR wp.[Type] = @Type)
		  AND (@EnableOrDisable < 1 OR wp.[Enable] = @Enable)
	ORDER BY wp.[Name]
	OFFSET ((@PageIndex - 1) * @PageSize) ROWS FETCH NEXT @PageSize ROWS ONLY;

	RETURN @@ROWCOUNT
END