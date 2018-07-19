USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetExamTests'))
	DROP PROCEDURE req.spGetExamTests
GO

CREATE PROCEDURE req.spGetExamTests
	@AExamRequestID UNIQUEIDENTIFIER
	, @AAdmissionID UNIQUEIDENTIFIER
	, @ANationalCode varchar(11)
	, @AYear INT
    , @APageSize INT
	, @APageIndex INT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ExamRequestID UNIQUEIDENTIFIER = @AExamRequestID 
			, @AdmissionID UNIQUEIDENTIFIER = @AAdmissionID
			, @NationalCode varchar(11) = @ANationalCode
			, @Year INT = @AYear
		    , @PageSize INT = COALESCE(@APageSize,20)
		    , @PageIndex INT = COALESCE(@APageIndex, 0)


	IF @PageIndex = 0 
	BEGIN
		SET @pagesize = 10000000
		SET @PageIndex = 1
	END

	IF @PageSize = 0 SET @PageSize=20

	SELECT
		et.ID
		, et.ExamRequestID
		, et.[Type]
		, et.[State]
		, et.ConditionalAdmissionYear
		, et.TestRawScore
		, et.TestScore
		, et.DescriptiveScore
		, et.TotalScore
		, et.TestResult
		, et.TotalResult
		, applicantUser.FirstName ApplicantFirstName
		, applicantUser.LastName ApplicantLastName
		, applicantUser.NationalCode ApplicantNationalCode
		, apl.Gender ApplicantGender
		, apl.FatherName ApplicantFatherName
		, apl.BCNumber ApplicantBCNumber
		, exr.DocumentNumber
		, exr.DemandedTestType
	FROM req.ExamTest et
	inner join req._ExamRequest exr on exr.ID = et.ExamRequestID
	LEFT JOIN org.Users applicantUser ON applicantUser.ID = exr.ApplicantUserID
	LEFT JOIN req.Applicant apl On apl.ID = exr.ID
	WHERE (@ExamRequestID is null or et.ExamRequestID = @ExamRequestID)
		  AND (@AdmissionID is null or exr.AdmissionID = @AdmissionID)
		  AND (@NationalCode is null or applicantUser.NationalCode = @NationalCode)
		  AND (@Year is null or exr.AdmissionYear = @Year)
	ORDER BY applicantUser.LastName, et.[Type]
	OFFSET ((@PageIndex - 1) * @PageSize) ROWS FETCH NEXT @PageSize ROWS ONLY;
	RETURN @@ROWCOUNT
END