USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetAdmissionRequestsByApplicant'))
	DROP PROCEDURE req.spGetAdmissionRequestsByApplicant
GO

CREATE PROCEDURE req.spGetAdmissionRequestsByApplicant
	@AApplicantID UNIQUEIDENTIFIER
	, @APageSize INT
	, @APageIndex INT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ApplicantID UNIQUEIDENTIFIER = @AApplicantID
			, @PageSize INT = COALESCE(@APageSize, 10)
			, @PageIndex INT = COALESCE(@APageIndex, 0)

	IF @AApplicantID = pbl.EmptyGuid()
		return -2    -- شناسه متقاضی معتبر نیست

	IF @PageIndex = 0 
	BEGIN
		SET @pagesize = 10000000
		SET @PageIndex = 1
	END

	SELECT 
		Count(*) OVER() Total 
		, admr.*
		, applicantUser.FirstName ApplicantFirstName
		, applicantUser.LastName ApplicantLastName
		, applicantUser.NationalCode ApplicantNationalCode
	FROM req._AdmissionRequest admr
	LEFT JOIN org.Users applicantUser ON applicantUser.ID = admr.ApplicantUserID
	WHERE admr.ApplicantUserID = @ApplicantID
	ORDER BY AdmissionYear
	OFFSET ((@PageIndex - 1) * @PageSize) ROWS FETCH NEXT @PageSize ROWS ONLY;

	RETURN @@ROWCOUNT
END