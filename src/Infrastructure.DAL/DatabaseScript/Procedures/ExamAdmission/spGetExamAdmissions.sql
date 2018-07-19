USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spGetExamAdmissions'))
	DROP PROCEDURE adm.spGetExamAdmissions
GO

CREATE PROCEDURE adm.spGetExamAdmissions
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	SELECT 
		Count(*) OVER() Total,
		eadm.ID,
		eadm.ExamDate,
		eadm.ResultsAnnouncementDate,
		eadm.ConditionalYears,
		eadm.PrintDate,
		adm.[Type],
		adm.[Year],
		adm.Title,
		adm.RegisterStartDate,
		adm.RegisterEndDate,
		adm.RegisterExtendDate,
		adm.VerifyStartDate,
		adm.VerifyEndDate,
		adm.VerifyExtendDate,
		adm.ObjectionStartDate,
		adm.ObjectionEndDate,
		adm.ObjectionExtendDate,
		adm.CompleteRecordsStartDate,
		adm.CompleteRecordsEndDate,
		adm.RegistrationFee,
		adm.CreatorID,
		usr.FirstName + ' ' + usr.LastName CreatorName,
		adm.CreationDate
	FROM adm.ExamAdmission eadm 
	INNER JOIN adm.Admission adm ON adm.ID = eadm.ID
	INNER JOIN org.Users usr ON usr.ID = adm.CreatorID
	ORDER BY adm.[Year]

	RETURN @@ROWCOUNT
END