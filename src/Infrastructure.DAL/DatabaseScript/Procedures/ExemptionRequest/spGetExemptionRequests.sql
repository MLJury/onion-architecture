USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetExemptionRequests'))
	DROP PROCEDURE req.spGetExemptionRequests
GO

CREATE PROCEDURE req.spGetExemptionRequests
	@AAdmissionID UNIQUEIDENTIFIER
	, @AApplicantUserID UNIQUEIDENTIFIER
	, @APageSize INT
	, @APageIndex INT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @AdmissionID UNIQUEIDENTIFIER = @AAdmissionID 
			, @ApplicantUserID UNIQUEIDENTIFIER = @AApplicantUserID 
			, @PageSize INT = @APageSize
			, @PageIndex INT = @APageIndex

	IF @AdmissionID = pbl.EmptyGuid() SET @AdmissionID = NULL
	IF @ApplicantUserID = pbl.EmptyGuid() SET @ApplicantUserID = NULL

	IF @PageIndex = 0 
	BEGIN
		SET @pagesize = 10000000
		SET @PageIndex = 1
	END

	SELECT exmpr.*
		, applicantUser.FirstName ApplicantFirstName
		, applicantUser.LastName ApplicantLastName
		, applicantUser.NationalCode ApplicantNationalCode
		, lastFromUser.FirstName + ' ' + lastFromUser.LastName LastFromUserName
		, lastToUser.FirstName + ' ' + lastToUser.LastName LastToUserName
	FROM req._ExemptionRequest exmpr
	LEFT JOIN org.Users applicantUser ON applicantUser.ID = exmpr.ApplicantUserID
	LEFT JOIN org.Users lastFromUser ON lastFromUser.ID = exmpr.lastFromUserID
	LEFT JOIN org.Positions lastToPosition ON lastToPosition.ID = exmpr.LastToPositionID
	LEFT JOIN org.Users lastToUser ON lastToUser.ID = lastToPosition.UserID
	WHERE (@AdmissionID IS NULL OR exmpr.AdmissionID = @AdmissionID)
		AND (@ApplicantUserID IS NULL OR exmpr.ApplicantUserID = @ApplicantUserID)
	Order By exmpr.CreationDate
	OFFSET ((@PageIndex - 1) * @PageSize) ROWS FETCH NEXT @PageSize ROWS ONLY;

	RETURN @@ROWCOUNT
END