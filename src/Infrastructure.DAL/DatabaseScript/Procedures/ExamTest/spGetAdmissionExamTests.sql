USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetAdmissionExamTests'))
	DROP PROCEDURE req.spGetAdmissionExamTests
GO

CREATE PROCEDURE req.spGetAdmissionExamTests
	@AAdmissionID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @AdmissionID UNIQUEIDENTIFIER = @AAdmissionID

	IF @AdmissionID = pbl.EmptyGuid() SET @AdmissionID = NULL
	--IF @ApplicantUserID = pbl.EmptyGuid() SET @ApplicantUserID = NULL

	SELECT exr.*
		, examTests.*
		, applicantUser.NationalCode ApplicantNationalCode
		, applicantUser.FirstName ApplicantFirstName
		, applicantUser.LastName ApplicantLastName
		, lastFromUser.FirstName + ' ' + lastFromUser.LastName LastFromUserName
		, lastToUser.FirstName + ' ' + lastToUser.LastName LastToUserName
		, apl.Gender ApplicantGender
		, apl.BCNumber ApplicantBCNumber
		, apl.FatherName ApplicantFatherName
	FROM req._ExamRequest exr
	inner join req.ExamTest examTests ON examTests.ExamRequestID = exr.ID
	LEFT JOIN org.Users applicantUser ON applicantUser.ID = exr.ApplicantUserID
	LEFT JOIN req.Applicant apl On apl.ID = exr.ID
	LEFT JOIN org.Users lastFromUser ON lastFromUser.ID = exr.lastFromUserID
	LEFT JOIN org.Positions lastToPosition ON lastToPosition.ID = exr.LastToPositionID
	LEFT JOIN org.Users lastToUser ON lastToUser.ID = lastToPosition.UserID
	INNER JOIN pbl.DocumentFlow flow ON flow.DocumentID = exr.ID AND flow.ID <> exr.LastFlowID
	WHERE
		(@AdmissionID IS NULL OR exr.AdmissionID = @AdmissionID)

	RETURN @@ROWCOUNT
END