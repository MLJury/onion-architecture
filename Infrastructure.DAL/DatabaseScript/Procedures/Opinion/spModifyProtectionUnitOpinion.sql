USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifyProtectionUnitOpinion'))
	DROP PROCEDURE req.spModifyProtectionUnitOpinion
GO

CREATE PROCEDURE req.spModifyProtectionUnitOpinion
	@AAdmissionRequestID UNIQUEIDENTIFIER,
	@AProtectionUnitConfirmType TINYINT,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE  @AdmissionRequestID UNIQUEIDENTIFIER = @AAdmissionRequestID,
		@ProtectionUnitConfirmType TINYINT = coalesce(@AProtectionUnitConfirmType, 0) ,
		@Log NVARCHAR(MAX) = @ALog

	BEGIN TRY
		BEGIN TRAN

			update req.Opinion set ProtectionUnitConfirmType = @ProtectionUnitConfirmType
			where AdmissionRequestID = @AdmissionRequestID

		EXEC pbl.spAddLog @Log

		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END