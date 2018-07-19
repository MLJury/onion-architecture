USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifyInterview'))
	DROP PROCEDURE req.spModifyInterview
GO

CREATE PROCEDURE req.spModifyInterview
	@AIsNewRecord BIT,
	@AID UNIQUEIDENTIFIER,
	@AExemptionRequestID UNIQUEIDENTIFIER,
	@AInterviewDate SMALLDATETIME,
	@AInterviewTime INT,
	@AInterviewResult TINYINT,
	@ARecordNumber NVARCHAR(10),
	@AFirstName NVARCHAR(50),
	@ALastName NVARCHAR(50),
	@ANationalCode NVARCHAR(50),
	@AProceedingsNumber NVARCHAR(50),
	@AProceedingsDate SMALLDATETIME,
	@AUserID UNIQUEIDENTIFIER,
	@ALog NVARCHAR(MAX)

WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@IsNewRecord BIT = @AIsNewRecord,
		@ID UNIQUEIDENTIFIER = @AID,
		@ExemptionRequestID UNIQUEIDENTIFIER = @AExemptionRequestID,
		@InterviewDate SMALLDATETIME = @AInterviewDate,
		@InterviewTime INT = @AInterviewTime,
		@InterviewResult TINYINT = COALESCE(@AInterviewResult, 0),
		@RecordNumber NVARCHAR(10) = LTRIM(RTRIM(@ARecordNumber)),
		@FirstName NVARCHAR(50) = LTRIM(RTRIM(@AFirstName)),
		@LastName NVARCHAR(50) = LTRIM(RTRIM(@ALastName)),
		@NationalCode NVARCHAR(50) = LTRIM(RTRIM(@ANationalCode)),
		@ProceedingsNumber NVARCHAR(50) = LTRIM(RTRIM(@AProceedingsNumber)),
		@ProceedingsDate SMALLDATETIME = @AProceedingsDate,
		@UserID UNIQUEIDENTIFIER = @AUserID,
		@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog)),
		@LastFlowToPositionID UNIQUEIDENTIFIER,
		@LastFlowToDocStateID SMALLINT

	BEGIN TRY
		BEGIN TRAN

			IF @IsNewRecord = 1 -- insert
			BEGIN
				
				INSERT INTO req.Interview
					(ID, ExemptionRequestID, InterviewDate, InterviewTime, InterviewResult, RecordNumber, FirstName, LastName, NationalCode, ProceedingsNumber, ProceedingsDate)
				VALUES
					(@ID, @ExemptionRequestID, @InterviewDate, @InterviewTime, @InterviewResult, @RecordNumber, @FirstName, @LastName, @NationalCode, @ProceedingsNumber, @ProceedingsDate)

			END
			ELSE
			BEGIN
				UPDATE req.Interview
				set InterviewDate = @InterviewDate, InterviewTime = @InterviewTime, InterviewResult = @InterviewResult, RecordNumber = @RecordNumber, FirstName = @FirstName, LastName = @LastName, NationalCode = @NationalCode, ProceedingsNumber = @ProceedingsNumber, ProceedingsDate = @ProceedingsDate
				where ID = @ID
			END

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END