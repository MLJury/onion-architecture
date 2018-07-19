USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spGetExamAdmission'))
	DROP PROCEDURE adm.spGetExamAdmission
GO

CREATE PROCEDURE adm.spGetExamAdmission
	@AID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID

		
	SELECT 
		eadm.ID	
		, eadm.ExamDate
		, eadm.ResultsAnnouncementDate
		, eadm.ConditionalYears
		, eadm.PrintDate
		, eadm.ShowChairNumberButton
		, eadm.LastChairNumberAllocationDate
		, LastChairNumberAllocationUser.FirstName + ' ' + LastChairNumberAllocationUser.LastName  LastChairNumberAllocationUserName
		, eadm.ExamDate
		, eadm.ResultsAnnouncementDate
		, eadm.ConditionalYears
		, eadm.PrintDate
		, eadm.ShowChairNumberButton
		, eadm.LastChairNumberAllocationDate
		, eadm.LastChairNumberAllocationUserID
		, adm.[Type]
		, adm.[Year]
		, adm.Title
		, adm.RegisterStartDate
		, adm.RegisterEndDate	
		, adm.RegisterExtendDate	
		, adm.VerifyStartDate	
		, adm.VerifyEndDate	
		, adm.VerifyExtendDate
		, adm.ObjectionStartDate
		, adm.ObjectionEndDate
		, adm.ObjectionExtendDate
		, adm.CompleteRecordsStartDate
		, adm.CompleteRecordsEndDate
		, adm.RegistrationFee
		, adm.CreatorID	
		, usr.FirstName + ' ' + usr.LastName CreatorName
		, adm.CreationDate
	FROM adm.ExamAdmission eadm 
	INNER JOIN adm.Admission adm ON adm.ID = eadm.ID
	INNER JOIN org.Users usr ON usr.ID = adm.CreatorID
	LEFT JOIN org.Users LastChairNumberAllocationUser ON LastChairNumberAllocationUser.ID = eadm.LastChairNumberAllocationUserID
	WHERE eadm.ID = @ID

	RETURN @@ROWCOUNT
END