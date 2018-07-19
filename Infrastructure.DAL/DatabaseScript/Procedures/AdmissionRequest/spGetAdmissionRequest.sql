USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetAdmissionRequest'))
	DROP PROCEDURE req.spGetAdmissionRequest
GO

CREATE PROCEDURE req.spGetAdmissionRequest
	@AID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@ID UNIQUEIDENTIFIER = @AID
		
	SELECT admr.*
		, applicantUser.FirstName ApplicantFirstName
		, applicantUser.LastName ApplicantLastName
		, applicantUser.NationalCode ApplicantNationalCode
	FROM req._AdmissionRequest admr
	LEFT JOIN org.Users applicantUser ON applicantUser.ID = admr.ApplicantUserID
	where admr.ID = @ID

	RETURN @@ROWCOUNT
END