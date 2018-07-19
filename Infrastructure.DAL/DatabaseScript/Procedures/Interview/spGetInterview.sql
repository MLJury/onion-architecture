USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetInterview'))
	DROP PROCEDURE req.spGetInterview
GO

CREATE PROCEDURE req.spGetInterview
	@AID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@ID UNIQUEIDENTIFIER = @AID
		
	SELECT interview.*
	    , applicantUser.FirstName ApplicantFirstName
		, applicantUser.LastName ApplicantLastName
		, applicantUser.NationalCode ApplicantNationalCode
		, apl.Gender ApplicantGender
		, apl.FatherName ApplicantFatherName
		, apl.BCNumber ApplicantBCNumber
		, exr.DocumentNumber
		--, exr.DemandedTestType
	FROM req.Interview interview
	LEFT JOIN req._ExemptionRequest exr on exr.ID = interview.ExemptionRequestID
	LEFT JOIN req.Applicant apl On apl.ID = interview.ExemptionRequestID
	LEFT JOIN org.Users applicantUser ON applicantUser.ID = exr.ApplicantUserID
	WHERE (@ID IS NULL OR interview.ID = @ID)
	ORDER BY InterviewDate

	RETURN @@ROWCOUNT
END