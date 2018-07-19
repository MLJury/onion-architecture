USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifyExamTests'))
	DROP PROCEDURE req.spModifyExamTests
GO

CREATE PROCEDURE req.spModifyExamTests
	@AExamRequestID UNIQUEIDENTIFIER,
	@AExamTests NVARCHAR(MAX),
	@ALog NVARCHAR(MAX)

WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@ExamRequestID UNIQUEIDENTIFIER = @AExamRequestID,
		@ExamTests NVARCHAR(MAX) = LTRIM(RTRIM(@AExamTests)),
		@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog))

	BEGIN TRY
		BEGIN TRAN

			UPDATE ExamTest
			SET ExamTest.State = et.State
			FROM req.ExamTest ExamTest 
			INNER JOIN OPENJSON(@ExamTests)
				WITH(
					ID UNIQUEIDENTIFIER,
					ExamRequestID UNIQUEIDENTIFIER,
					[State] TINYINT
				) et ON et.ID = ExamTest.ID

			-- update demanded test type in req.ExamRequest
			EXEC req.spUpdateDemandedTestType_ @AExamRequestID = @ExamRequestID

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END