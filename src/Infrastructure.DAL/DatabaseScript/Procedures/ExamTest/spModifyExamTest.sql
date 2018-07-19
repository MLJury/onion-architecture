USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifyExamTest'))
	DROP PROCEDURE req.spModifyExamTest
GO

CREATE PROCEDURE req.spModifyExamTest
	@AID Uniqueidentifier,
	@AExamRequestID Uniqueidentifier,
	@AType tinyint,
	@AState tinyint,
	@AQualifiedExamTestID uniqueidentifier,
	@ATestRawScore int,
	@ATestScore float,
	@ADescriptiveScore float,
	@ATotalScore float,
	@ATestResult tinyint,
	@ATotalResult tinyint,
	@AConditionalAdmissionYear smallint,
	@ALog NVARCHAR(MAX)

WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@ID Uniqueidentifier = @AID,
		@ExamRequestID Uniqueidentifier = @AExamRequestID,
		@Type tinyint = coalesce(@AType, 0),
		@State tinyint = coalesce(@AState, 0),
		@QualifiedExamTestID uniqueidentifier = @AQualifiedExamTestID,
		@TestRawScore int = coalesce(@ATestRawScore, 0),
		@TestScore float = coalesce(@ATestScore, 0) ,
		@DescriptiveScore float = coalesce(@ADescriptiveScore, 0),
		@TotalScore float = coalesce(@ATotalScore, 0),
		@TestResult tinyint = coalesce(@ATestResult, 0),
		@TotalResult tinyint = coalesce(@ATotalResult, 0),
		@ConditionalAdmissionYear smallint = coalesce(@AConditionalAdmissionYear, 0),
		@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog))

	BEGIN TRY
		BEGIN TRAN

			UPDATE req.ExamTest
			set ExamRequestID = @ExamRequestID, [Type] = @Type, [State] = @State, [QualifiedExamTestID] = @QualifiedExamTestID, [TestRawScore] = @TestRawScore, [TestScore] = @TestScore, [DescriptiveScore] = @DescriptiveScore, [TotalScore] = @TotalScore, [TestResult] = @TestResult, [TotalResult] = @TotalResult, [ConditionalAdmissionYear] = @ConditionalAdmissionYear
			where ID = @ID

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