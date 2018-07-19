USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spSetInterviewConfirmerID'))
	DROP PROCEDURE req.spSetInterviewConfirmerID
GO

CREATE PROCEDURE req.spSetInterviewConfirmerID
	@AID UNIQUEIDENTIFIER,
	@AUserID UNIQUEIDENTIFIER,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE  @ID UNIQUEIDENTIFIER = @AID,
		@UserID UNIQUEIDENTIFIER = @AUserID,
		@Log NVARCHAR(MAX) = @ALog

	BEGIN TRY
		BEGIN TRAN

			update req.Interview 
			set ConfirmerID= @UserID
				, ConfirmDate = GETDATE()
			where ID = @ID

			EXEC pbl.spAddLog @Log

		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END