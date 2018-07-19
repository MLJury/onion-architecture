USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spDeleteExemptionRequest'))
	DROP PROCEDURE req.spDeleteExemptionRequest
GO

CREATE PROCEDURE req.spDeleteExemptionRequest
	@AID UNIQUEIDENTIFIER,
	@ARemoverID UNIQUEIDENTIFIER,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID,
			@RemoverID UNIQUEIDENTIFIER = @ARemoverID, 
		    @Log NVARCHAR(MAX)

	IF @ID IS NULL
		RETURN -2 -- شناسه نامعتبر است

	BEGIN TRY
		BEGIN TRAN
			
			UPDATE pbl.BaseDocument
			SET RemoverID = @RemoverID, RemoveDate = GETDATE()
			WHERE ID = @ID

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END