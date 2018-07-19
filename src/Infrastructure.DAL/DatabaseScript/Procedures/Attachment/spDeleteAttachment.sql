USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spDeleteAttachment'))
	DROP PROCEDURE pbl.spDeleteAttachment
GO

CREATE PROCEDURE pbl.spDeleteAttachment
	@AID UNIQUEIDENTIFIER,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID,
		    @Log NVARCHAR(MAX)

				
	---- Begin Validation
	IF @ID IS NULL
		RETURN -2 -- شناسه اپلیکیشن نامعتبر است
	---- End Validation

	BEGIN TRY
		BEGIN TRAN
			DELETE FROM pbl.Attachment
			WHERE ID = @ID

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END