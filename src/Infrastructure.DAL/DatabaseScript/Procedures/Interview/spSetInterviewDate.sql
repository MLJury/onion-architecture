USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spSetInterviewDate'))
	DROP PROCEDURE req.spSetInterviewDate
GO

CREATE PROCEDURE req.spSetInterviewDate
	@AID UNIQUEIDENTIFIER,
	@AInterviewDate SMALLDATETIME,
	@AInterviewTime INT,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE  @ID UNIQUEIDENTIFIER = @AID,
		@InterviewDate SMALLDATETIME = @AInterviewDate,
		@InterviewTime INT = COALESCE(@AInterviewTime, 0),
		@Log NVARCHAR(MAX) = @ALog

	BEGIN TRY
		BEGIN TRAN

			update req.Interview 
			set InterviewDate = @InterviewDate
				, InterviewTime = @InterviewTime
			where ID = @ID

			EXEC pbl.spAddLog @Log

		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END