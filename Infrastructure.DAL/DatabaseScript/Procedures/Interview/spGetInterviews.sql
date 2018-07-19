USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetInterviews'))
	DROP PROCEDURE req.spGetInterviews
GO

CREATE PROCEDURE req.spGetInterviews
	@AExemptionRequestID UNIQUEIDENTIFIER,
	@AApplicantName nvarchar(100),
	@AApplicantNationalCode varchar(11),
	@ADateFrom SMALLDATETIME,
	@ADateTo SMALLDATETIME,
	@APageSize INT,
	@APageIndex INT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@ExemptionRequestID UNIQUEIDENTIFIER = @AExemptionRequestID,
		@ApplicantName nvarchar(100) = concat('%', ltrim(rtrim(@AApplicantName)), '%'),
		@ApplicantNationalCode varchar(11) = ltrim(rtrim(@AApplicantNationalCode)),
		@DateFrom SMALLDATETIME,
		@DateTo SMALLDATETIME,
		@PageSize INT = COALESCE(@APageSize, 10),
		@PageIndex INT = COALESCE(@APageIndex, 1)
	
	IF @PageIndex = 0 
	BEGIN
		SET @pagesize = 10000000
		SET @PageIndex = 1
	END
		
	SELECT 
		Count(*) OVER() Total, 
		interview.*,
	    applicantUser.FirstName ApplicantFirstName,
		applicantUser.LastName ApplicantLastName,
		applicantUser.NationalCode ApplicantNationalCode,
		applicantUser.CellPhone ApplicantCellPhone,
		apl.FatherName ApplicantFatherName,
		exr.LastDocState
		--, exr.DemandedTestType
	FROM req.Interview interview
	LEFT JOIN req._ExemptionRequest exr on exr.ID = interview.ExemptionRequestID
	LEFT JOIN req.Applicant apl On apl.ID = interview.ExemptionRequestID
	LEFT JOIN org.Users applicantUser ON applicantUser.ID = exr.ApplicantUserID
	WHERE (@ExemptionRequestID IS NULL OR ExemptionRequestID = @ExemptionRequestID)
		AND (@ApplicantName IS NULL OR applicantUser.LastName like @ApplicantName)
		AND (@ApplicantNationalCode IS NULL OR applicantUser.NationalCode = @ApplicantNationalCode)
		AND (@DateFrom IS NULL OR interview.InterviewDate >= @DateFrom)
		AND (@DateTo IS NULL OR interview.InterviewDate < @DateTo)
	ORDER BY InterviewDate
	OFFSET ((@PageIndex - 1) * @PageSize) ROWS FETCH NEXT @PageSize ROWS ONLY;

	RETURN @@ROWCOUNT
END