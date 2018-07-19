USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetPayment'))
	DROP PROCEDURE req.spGetPayment
GO

CREATE PROCEDURE req.spGetPayment
	@AID UNIQUEIDENTIFIER,
	@AOrderID BIGINT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@ID UNIQUEIDENTIFIER = @AID,
		@OrderID BIGINT = @AOrderID 

	SELECT 
		payment.ID,
		payment.AdmissionRequestID,
		adm.ID AdmissionID,
		adm.[Title] AdmissionTitle,
		adm.[Year] AdmissionYear,
		usr.FirstName ApplicantFirstName,
		usr.LastName ApplicantLastName,
		usr.NationalCode ApplicantNationalCode,
		payment.OrderID,
		payment.Amount,
		payment.CreationDate,
		payment.TransactionDate,
		payment.TransactionResult,
		payment.RefID, 
		payment.SaleReferenceID, 
		doc.DocumentNumber,
		doc.TrackingCode
	FROM req.Payment payment
		INNER JOIN req.AdmissionRequest adr ON adr.ID = payment.AdmissionRequestID
		INNER JOIN pbl.BaseDocument as doc on doc.ID = adr.ID
		INNER JOIN adm.Admission adm ON adm.ID = adr.AdmissionID
		INNER JOIN org.[Users] usr ON usr.ID = adr.[ApplicantUserID]
	WHERE (@ID IS NULL OR payment.ID = @ID)
		AND (@OrderID IS NULL OR payment.OrderID = @OrderID)

	RETURN @@ROWCOUNT
END