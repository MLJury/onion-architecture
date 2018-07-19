USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetReasons'))
	DROP PROCEDURE req.spGetReasons
GO

CREATE PROCEDURE req.spGetReasons
	@AAdmissionRequestID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@AdmissionRequestID UNIQUEIDENTIFIER = @AAdmissionRequestID
		
	SELECT 
		ID,
		AdmissionRequestID,
		ReasonType
	FROM req.Reason 
	where AdmissionRequestID = @AdmissionRequestID

	RETURN @@ROWCOUNT
END