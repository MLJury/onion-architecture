USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spGetExemptionAdmissions'))
	DROP PROCEDURE adm.spGetExemptionAdmissions
GO

CREATE PROCEDURE adm.spGetExemptionAdmissions
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	SELECT  
		ea.ID	
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
	FROM adm.ExemptionAdmission ea 
	INNER JOIN adm.Admission adm ON adm.ID = ea.ID
	Order BY adm.[Year]

	RETURN @@ROWCOUNT
END