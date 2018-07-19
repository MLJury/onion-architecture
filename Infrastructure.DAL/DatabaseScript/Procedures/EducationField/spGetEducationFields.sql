USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spGetEducationFields'))
	DROP PROCEDURE pbl.spGetEducationFields
GO

CREATE PROCEDURE pbl.spGetEducationFields
	@AName NVARCHAR(1000),
	@ACode NVARCHAR(1000),
	@AEnableOrDisable TINYINT,    -- 1: enable, 2: disable, 0: all
	@AEducationFieldType TINYINT, 
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
		@EnableOrDisable TINYINT = COALESCE(@AEnableOrDisable, 0),
		@Enable BIT = CASE @AEnableOrDisable WHEN 1 THEN 1 ELSE 0 END, 
		@EducationFieldType TINYINT = COALESCE(@AEducationFieldType, 0),
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
		ef.ID,
		ef.Code,
		ef.[Name],
		ef.EducationFieldType,
		ef.[Enable],
		ef.[Order]
	FROM pbl.EducationField ef
	WHERE (@Name IS NULL OR ef.[Name] like '%' + @Name + '%')
		  AND (@Code IS NULL OR ef.Code like '%' + @Code + '%')
		  AND (@EnableOrDisable < 1 OR ef.[Enable] = @Enable)
		  AND (@EducationFieldType < 1 OR ef.EducationFieldType = @EducationFieldType)
	ORDER BY ef.[Name]
	OFFSET ((@PageIndex - 1) * @PageSize) ROWS FETCH NEXT @PageSize ROWS ONLY;

	RETURN @@ROWCOUNT
END