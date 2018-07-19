USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetExamTest'))
	DROP PROCEDURE req.spGetExamTest
GO

CREATE PROCEDURE req.spGetExamTest
	@AID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID
		
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
	FROM req.ExamTest et
	inner join req.Applicant applicant on applicant.ID = et.ExamRequestID
	inner join req.AdmissionRequest admr on admr.ID = et.ExamRequestID
	inner join org.Users applicantUser on applicantUser.ID = admr.ApplicantUserID
	WHERE (et.ID = @ID)

	RETURN @@ROWCOUNT
END