USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetObjections'))
	DROP PROCEDURE req.spGetObjections
GO

CREATE PROCEDURE req.spGetObjections
	@AAdmissionID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @AdmissionID UNIQUEIDENTIFIER = @AAdmissionID

	IF @AdmissionID = pbl.EmptyGuid() SET @AdmissionID = NULL

	SELECT obj.*
		, applicantUser.FirstName ApplicantFirstName
		, applicantUser.LastName ApplicantLastName
		, applicantUser.NationalCode ApplicantNationalCode
		, lastFromUser.FirstName + ' ' + lastFromUser.LastName LastFromUserName
		, lastToUser.FirstName + ' ' + lastToUser.LastName LastToUserName
	FROM req._Objection obj
	LEFT JOIN org.Users applicantUser ON applicantUser.ID = obj.ApplicantUserID
	LEFT JOIN org.Users lastFromUser ON lastFromUser.ID = obj.lastFromUserID
	LEFT JOIN org.Positions lastToPosition ON lastToPosition.ID = obj.LastToPositionID
	LEFT JOIN org.Users lastToUser ON lastToUser.ID = lastToPosition.UserID
	where obj.RemoveDate is null
	ORDER BY CreationDate

	RETURN @@ROWCOUNT
END