USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetConditionals'))
	DROP PROCEDURE req.spGetConditionals
GO

CREATE PROCEDURE req.spGetConditionals
	@AAdmissionID Uniqueidentifier,
	@AFirstName nvarchar(50),
	@ALastName nvarchar(50),
	@ANationalCode varchar(11),
	@APageSize INT,
	@APageIndex INT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @AdmissionID Uniqueidentifier = @AAdmissionID
			, @FirstName nvarchar(50) = ltrim(rtrim(@AFirstName))
			, @LastName nvarchar(50) = ltrim(rtrim(@ALastName))
			, @NationalCode varchar(11) = ltrim(rtrim(@ANationalCode))
			, @PageSize INT = COALESCE(@APageSize,20)
		    , @PageIndex INT = COALESCE(@APageIndex, 0)

	IF @PageIndex = 0 
	BEGIN
		SET @pagesize = 10000000
		SET @PageIndex = 1
	END

	SELECT 
		Count(*) Over() Total,
		cnd.ID,
		cnd.FirstName,
		cnd.LastName,
		cnd.FatherName,
		cnd.NationalCode,
		cnd.TestType1,
		cnd.TestType2,
		cnd.TestType4,
		cnd.TestType8,
		admission.[Year] [Year],
		cnd.ExamYear
	FROM req.Conditional cnd
	inner join adm.Admission admission on admission.ID = cnd.AdmissionID
	where (@AdmissionID is null or AdmissionID = @AdmissionID)
			AND (@FirstName is null or FirstName like N'%' + @FirstName + N'%')
			AND (@LastName is null or LastName like N'%' + @LastName + N'%')
			AND (@NationalCode is null or NationalCode = @NationalCode)
	ORDER BY cnd.LastName
	OFFSET ((@PageIndex - 1) * @PageSize) ROWS FETCH NEXT @PageSize ROWS ONLY;

	RETURN @@ROWCOUNT
END