USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spUpdateDemandedTestType_'))
	DROP PROCEDURE req.spUpdateDemandedTestType_
GO

CREATE PROCEDURE req.spUpdateDemandedTestType_
	@AExamRequestID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ExamRequestID UNIQUEIDENTIFIER = @AExamRequestID

	BEGIN TRY
		BEGIN TRAN
			
			UPDATE ExamRequest
			SET DemandedTestType = COALESCE((SELECT SUM([TYPE]) FROM req.ExamTest WHERE [State] = 1 and ExamRequestID = @ExamRequestID), 0)
			FROM req.ExamRequest ExamRequest
			WHERE ID = @ExamRequestID

		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END