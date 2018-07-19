USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetAdmissionRequests'))
	DROP PROCEDURE req.spGetAdmissionRequests
GO

CREATE PROCEDURE req.spGetAdmissionRequests
	@ALastDocState SMALLINT,
	@APageSize INT,
	@APageIndex INT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @LastDocState SMALLINT = COALESCE(@ALastDocState, 0)
			, @PageSize INT = COALESCE(@APageSize, 10)
			, @PageIndex INT = COALESCE(@APageIndex, 0)


	IF @PageIndex = 0 
	BEGIN
		SET @pagesize = 10000000
		SET @PageIndex = 1
	END

	SELECT admr.*
		, applicantUser.FirstName ApplicantFirstName
		, applicantUser.LastName ApplicantLastName
		, applicantUser.NationalCode ApplicantNationalCode
	FROM req._AdmissionRequest admr
	LEFT JOIN org.Users applicantUser ON applicantUser.ID = admr.ApplicantUserID
	WHERE admr.LastDocState = @LastDocState
	Order BY admr.AdmissionYear
	OFFSET ((@PageIndex - 1) * @PageSize) ROWS FETCH NEXT @PageSize ROWS ONLY;

	RETURN @@ROWCOUNT
END