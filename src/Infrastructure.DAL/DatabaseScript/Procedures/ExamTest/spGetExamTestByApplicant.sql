USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetExamTestByApplicant'))
	DROP PROCEDURE req.spGetExamTestByApplicant
GO

CREATE PROCEDURE req.spGetExamTestByApplicant
	@AApplicantID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ApplicantID UNIQUEIDENTIFIER = @AApplicantID
		
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
		, applicant.FatherName ApplicantFatherName
		, applicant.BCNumber ApplicantBCNumber
		, applicant.FatherName ApplicantFatherName
		, baseDocument.DocumentNumber
	FROM req.ExamTest et
	inner join req.Applicant applicant on applicant.ID = et.ExamRequestID
	inner join req.AdmissionRequest admr on admr.ID = et.ExamRequestID
	inner join org.Users applicantUser on applicantUser.ID = admr.ApplicantUserID
	inner join pbl.BaseDocument baseDocument on baseDocument.ID = admr.ID
	WHERE (applicant.ID = @ApplicantID)

	RETURN @@ROWCOUNT
END