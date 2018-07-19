USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spGetActiveAdmissions'))
	DROP PROCEDURE adm.spGetActiveAdmissions
GO

CREATE PROCEDURE adm.spGetActiveAdmissions
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @CurrentDate DATE = GETDATE()   --must be date
	
	SELECT 
		adm.ID	
		, adm.[Type]
		, adm.[Year]
		, adm.Title
		, adm.RegisterStartDate
		, adm.RegisterEndDate
		, adm.RegisterExtendDate
		, adm.RegistrationFee
	FROM adm.Admission adm 
	WHERE @CurrentDate >=  CAST(adm.RegisterStartDate AS DATE)
	AND @CurrentDate <= CAST(adm.RegisterEndDate AS DATE)
	Order BY adm.RegisterStartDate

	RETURN @@ROWCOUNT
END