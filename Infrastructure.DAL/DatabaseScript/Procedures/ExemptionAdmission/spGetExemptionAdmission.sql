USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spGetExemptionAdmission'))
	DROP PROCEDURE adm.spGetExemptionAdmission
GO

CREATE PROCEDURE adm.spGetExemptionAdmission
	@AID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID
		
	SELECT 
		COUNT(*) OVER() Total,
		ea.ID,
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
		adm.CreatorID
	FROM adm.ExemptionAdmission ea 
	INNER JOIN adm.Admission adm ON adm.ID = ea.ID
	WHERE ea.ID = @ID

	RETURN @@ROWCOUNT
END