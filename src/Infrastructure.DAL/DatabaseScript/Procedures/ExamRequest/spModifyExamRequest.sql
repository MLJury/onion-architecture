USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifyExamRequest'))
	DROP PROCEDURE req.spModifyExamRequest
GO

CREATE PROCEDURE req.spModifyExamRequest
	@AIsNewRecord BIT,
	@AID uniqueidentifier,
	@AAdmissionID uniqueidentifier,
	@AApplicantUserID uniqueidentifier,
	@AAgreementType TINYINT,
	@AAgreementAccepted BIT,
	@ADemandedTestType tinyint,
	@ACreatorID UNIQUEIDENTIFIER,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @IsNewRecord BIT = ISNULL(@AIsNewRecord, 0),
		@ID UNIQUEIDENTIFIER = @AID,
		@AdmissionID uniqueidentifier = @AAdmissionID,
		@ApplicantUserID uniqueidentifier = @AApplicantUserID,
		@AgreementType TINYINT = COALESCE(@AAgreementType, 0),
		@AgreementAccepted BIT = COALESCE(@AAgreementAccepted, 0),
		@DemandedTestType tinyint = COALESCE(@ADemandedTestType, 0),
		@CreatorID UNIQUEIDENTIFIER = @ACreatorID,
		@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog)),
		@Type TinyINT = 1,     -- Exam Request
		@TrackingCode NVARCHAR(50),
		@DocumentNumber NVARCHAR(1),    -- not used
		@CreationDate SMALLDATETIME

	BEGIN TRY
		BEGIN TRAN
			
			EXECUTE req.spModifyAdmissionRequest_ @IsNewRecord, @ID, @Type, @AdmissionID, @ApplicantUserID, @AgreementType, @AgreementAccepted, @CreatorID

			IF @IsNewRecord = 1 -- insert
			BEGIN
				
				INSERT INTO req.ExamRequest
				(ID, DemandedTestType, ChairNumber)
				VALUES
				(@ID, 0, NULL)

				INSERT INTO req.ExamTest (ID, ExamRequestID, [Type], [State], ConditionalAdmissionYear, TestRawScore, TestScore, DescriptiveScore, TotalScore, TestResult, TotalResult)
				VALUES (NEWID(), @ID, 1, 0, NULL, NULL, NULL, NULL, NULL, 0, 0)

				INSERT INTO req.ExamTest (ID, ExamRequestID, [Type], [State], ConditionalAdmissionYear, TestRawScore, TestScore, DescriptiveScore, TotalScore, TestResult, TotalResult)
				VALUES (NEWID(), @ID, 2, 0, NULL, NULL, NULL, NULL, NULL, 0, 0)

				INSERT INTO req.ExamTest (ID, ExamRequestID, [Type], [State], ConditionalAdmissionYear, TestRawScore, TestScore, DescriptiveScore, TotalScore, TestResult, TotalResult)
				VALUES (NEWID(), @ID, 4, 0, NULL, NULL, NULL, NULL, NULL, 0, 0)

				INSERT INTO req.ExamTest (ID, ExamRequestID, [Type], [State], ConditionalAdmissionYear, TestRawScore, TestScore, DescriptiveScore, TotalScore, TestResult, TotalResult)
				VALUES (NEWID(), @ID, 8, 0, NULL, NULL, NULL, NULL, NULL, 0, 0)

				EXEC req.spUpdateExamTestState_ @AExamRequestID = @ID   -- جهت مشخص کردن وضعیت مشروطین
			END
			ELSE
			BEGIN
				UPDATE req.ExamRequest
				SET DemandedTestType = @DemandedTestType
				WHERE ID = @ID
			END

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END