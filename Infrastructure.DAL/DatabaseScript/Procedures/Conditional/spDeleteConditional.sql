USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spDeleteConditional'))
	DROP PROCEDURE req.spDeleteConditional
GO

CREATE PROCEDURE req.spDeleteConditional
	@AID uniqueidentifier,
	@ALog NVARCHAR(MAX)

WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID uniqueidentifier = @AID,
			@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog))
	BEGIN TRY
		BEGIN TRAN

			DELETE 
			FROM req.Conditional
			WHERE ID = @ID

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END