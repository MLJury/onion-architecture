USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spDeleteSurveyTemplate'))
	DROP PROCEDURE pbl.spDeleteSurveyTemplate
GO

CREATE PROCEDURE pbl.spDeleteSurveyTemplate
	@AID UNIQUEIDENTIFIER,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE   
		@ID UNIQUEIDENTIFIER = @AID,
		@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog)),
		@Result NVARCHAR(MAX)

	BEGIN TRY
		BEGIN TRAN

			update pbl.SurveyTemplate
			set IsRemoved = 1
			where ID = @ID

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END