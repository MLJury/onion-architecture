USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetExamRequests'))
	DROP PROCEDURE req.spGetExamRequests
GO

CREATE PROCEDURE req.spGetExamRequests
	@AAdmissionID UNIQUEIDENTIFIER
	, @ALastDocState TINYINT
	, @AApplicantUserID UNIQUEIDENTIFIER
	, @APageSize INT
	, @APageIndex INT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @AdmissionID UNIQUEIDENTIFIER = @AAdmissionID,
			@LastDocState TINYINT = COALESCE(@ALastDocState, 0),
			@ApplicantUserID UNIQUEIDENTIFIER = @AApplicantUserID,
			@PageSize INT = @APageSize,
			@PageIndex INT = @APageIndex

	IF @AdmissionID = pbl.EmptyGuid() SET @AdmissionID = NULL
	IF @ApplicantUserID = pbl.EmptyGuid() SET @ApplicantUserID = NULL

	IF @PageIndex = 0 
	BEGIN
		SET @pagesize = 10000000
		SET @PageIndex = 1
	END

	SELECT exr.*
		, applicantUser.NationalCode ApplicantNationalCode
		, applicantUser.FirstName ApplicantFirstName
		, applicantUser.LastName ApplicantLastName
		, lastFromUser.FirstName + ' ' + lastFromUser.LastName LastFromUserName
		, lastToUser.FirstName + ' ' + lastToUser.LastName LastToUserName
		, apl.Gender ApplicantGender
		, apl.BCNumber ApplicantBCNumber
		, apl.FatherName ApplicantFatherName
	FROM req._ExamRequest exr
	LEFT JOIN org.Users applicantUser ON applicantUser.ID = exr.ApplicantUserID
	LEFT JOIN req.Applicant apl On apl.ID = exr.ID
	LEFT JOIN org.Users lastFromUser ON lastFromUser.ID = exr.lastFromUserID
	LEFT JOIN org.Positions lastToPosition ON lastToPosition.ID = exr.LastToPositionID
	LEFT JOIN org.Users lastToUser ON lastToUser.ID = lastToPosition.UserID
	WHERE
		(@AdmissionID IS NULL OR exr.AdmissionID = @AdmissionID)
		AND (@ApplicantUserID IS NULL OR exr.ApplicantUserID = @ApplicantUserID)
		AND (@LastDocState < 1 OR exr.LastDocState = @LastDocState)
	Order By exr.CreationDate
	OFFSET ((@PageIndex - 1) * @PageSize) ROWS FETCH NEXT @PageSize ROWS ONLY;
	RETURN @@ROWCOUNT
END