USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifySecretaryOpinion'))
	DROP PROCEDURE req.spModifySecretaryOpinion
GO

CREATE PROCEDURE req.spModifySecretaryOpinion
	@AAdmissionRequestID UNIQUEIDENTIFIER,
	@ASecretaryConfirmType TINYINT,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE  @AdmissionRequestID UNIQUEIDENTIFIER = @AAdmissionRequestID,
		@SecretaryConfirmType TINYINT = coalesce(@ASecretaryConfirmType, 0) ,
		@Log NVARCHAR(MAX) = @ALog

	BEGIN TRY
		BEGIN TRAN

			update req.Opinion set SecretaryConfirmType = @SecretaryConfirmType
			where AdmissionRequestID = @AdmissionRequestID

		EXEC pbl.spAddLog @Log

		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END