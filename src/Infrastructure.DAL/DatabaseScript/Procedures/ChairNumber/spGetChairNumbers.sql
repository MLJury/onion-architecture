USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spGetChairNumbers'))
	DROP PROCEDURE adm.spGetChairNumbers
GO

CREATE PROCEDURE adm.spGetChairNumbers
	@AAdmissionID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @AdmissionID UNIQUEIDENTIFIER = @AAdmissionID
		
	SELECT
		chairNumber.ID,
		chairNumber.AdmissionID,
		chairNumber.TestType,
		chairNumber.[Order],
		chairNumber.FromChairNumber,
		chairNumber.ToChairNumber,
		chairNumber.CreationDate
	FROM adm.ChairNumber chairNumber	
	WHERE chairNumber.AdmissionID = @AdmissionID
	Order By chairNumber.[Order]

	RETURN @@ROWCOUNT
END