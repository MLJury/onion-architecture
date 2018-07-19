USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifyBossOpinion'))
	DROP PROCEDURE req.spModifyBossOpinion
GO

CREATE PROCEDURE req.spModifyBossOpinion
	@AAdmissionRequestID UNIQUEIDENTIFIER,
	@ABossConfirmType TINYINT,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE  @AdmissionRequestID UNIQUEIDENTIFIER = @AAdmissionRequestID,
		@BossConfirmType TINYINT = coalesce(@ABossConfirmType, 0) ,
		@Log NVARCHAR(MAX) = @ALog

	BEGIN TRY
		BEGIN TRAN

			update req.Opinion set BossConfirmType = @BossConfirmType
			where AdmissionRequestID = @AdmissionRequestID

		EXEC pbl.spAddLog @Log

		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END