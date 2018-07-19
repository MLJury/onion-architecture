USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spSetInterviewResult'))
	DROP PROCEDURE req.spSetInterviewResult
GO

CREATE PROCEDURE req.spSetInterviewResult
	@AID UNIQUEIDENTIFIER,
	@AInterviewResult TINYINT,
	@ARecordNumber NVARCHAR(10),
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE  @ID UNIQUEIDENTIFIER = @AID,
		@InterviewResult TINYINT = COALESCE(@AInterviewResult, 0),
		@RecordNumber NVARCHAR(10) = LTRIM(RTRIM(@ARecordNumber)),
		@Log NVARCHAR(MAX) = @ALog

	BEGIN TRY
		BEGIN TRAN

			update req.Interview 
			set InterviewResult= @InterviewResult
				, RecordNumber = @RecordNumber
			where ID = @ID

			EXEC pbl.spAddLog @Log

		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END