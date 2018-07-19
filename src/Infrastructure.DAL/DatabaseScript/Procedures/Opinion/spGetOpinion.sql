USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetOpinion'))
	DROP PROCEDURE req.spGetOpinion
GO

CREATE PROCEDURE req.spGetOpinion
	@AAdmissionRequestID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@AdmissionRequestID UNIQUEIDENTIFIER = @AAdmissionRequestID
		
	SELECT *
	FROM req.Opinion 
	where AdmissionRequestID = @AdmissionRequestID

	RETURN @@ROWCOUNT
END