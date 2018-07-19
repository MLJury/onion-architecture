USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spDeleteManagementHistory'))
	DROP PROCEDURE req.spDeleteManagementHistory
GO

CREATE PROCEDURE req.spDeleteManagementHistory
	@AID UNIQUEIDENTIFIER,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID,
		    @Log NVARCHAR(MAX)

				
	IF @ID IS NULL
		RETURN -2 -- شناسه نامعتبر است

	BEGIN TRY
		BEGIN TRAN
			
			DELETE FROM req.ManagementHistory
			WHERE ID = @ID

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END