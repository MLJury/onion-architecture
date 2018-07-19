USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE object_id = OBJECT_ID('adm.spEnableDeprived'))
	DROP PROCEDURE adm.spEnableDeprived
GO

CREATE PROCEDURE adm.spEnableDeprived
	@AID UNIQUEIDENTIFIER,
	@AEnable BIT,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@ID UNIQUEIDENTIFIER = @AID,
		@Enable BIT = @AEnable,
		@Log NVARCHAR(MAX) = @ALog

	BEGIN TRY
		BEGIN TRAN

			UPDATE adm.Deprived
			SET [Enabled] = @Enable
			WHERE ID = @ID

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END