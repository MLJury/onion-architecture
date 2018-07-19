USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifyObjection'))
	DROP PROCEDURE req.spModifyObjection
GO

CREATE PROCEDURE req.spModifyObjection
	@AIsNewRecord BIT,
	@AID uniqueidentifier,
	@AAdmissionRequestID uniqueidentifier,
	@AType TINYINT,
	@AApplicantComment NVARCHAR(4000),
	@AExpertComment NVARCHAR(4000),
	@ASecretaryComment NVARCHAR(4000),
	@AResult TINYINT,
	@ASecretaryConfirmType tinyint,
	@AUserID UNIQUEIDENTIFIER,
	@ATests NVARCHAR(MAX),
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @IsNewRecord BIT = ISNULL(@AIsNewRecord, 0),
		@ID UNIQUEIDENTIFIER = @AID,
		@AdmissionRequestID uniqueidentifier = @AAdmissionRequestID,
		@Type TINYINT = coalesce(@AType, 0),
		@ApplicantComment NVARCHAR(4000) = ltrim(ltrim(@AApplicantComment)),
		@ExpertComment NVARCHAR(4000) = ltrim(ltrim(@AExpertComment)),
		@SecretaryComment NVARCHAR(4000) = ltrim(ltrim(@ASecretaryComment)),
		@Result TINYINT = @AResult,
		@SecretaryConfirmType tinyint = @ASecretaryConfirmType,
		@UserID UNIQUEIDENTIFIER = @AUserID,
		@Tests NVARCHAR(MAX) = @ATests,
		@TrackingCode NVARCHAR(50),
		@CreationDate SMALLDATETIME,
		@DocumentNumber NVARCHAR(50), 
		@DocumentType TINYINT = 5,
		@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog))

	BEGIN TRY
		BEGIN TRAN
			
			IF @IsNewRecord = 1 -- insert
			BEGIN

				--SET @TrackingCode = 1
				--(SELECT
				--REVERSE(SUBSTRING(dbo.fnGetShamsiDate(GETDATE()),3,2)
				--+ SUBSTRING(dbo.fnGetShamsiDate(GETDATE()),6,2)
				--+ SUBSTRING(dbo.fnGetShamsiDate(GETDATE()),9,2))
				--+ RIGHT('0000' + RTRIM(CAST((SELECT
				--COUNT(*) + 1
				--FROM pbl.BaseDocument doc
				--WHERE (DATEPART(YEAR, doc.CreationDate) = DATEPART(YEAR, GETDATE())
				--AND DATEPART(MONTH, doc.CreationDate) = DATEPART(MONTH, GETDATE())
				--AND DATEPART(DAY, doc.CreationDate) = DATEPART(DAY, GETDATE()))
				--AND (@Type IS NULL OR doc.type = @Type))
				--AS varchar(10))), 4)
				--+ RIGHT('0' + RTRIM(@Type), 2))

				EXECUTE pbl.spModifyBaseDocument_ @IsNewRecord, @ID, @DocumentType, @UserID, @TrackingCode, @DocumentNumber, @CreationDate OUTPUT

				INSERT INTO req.Objection
				(ID, AdmissionRequestID, [Type], ApplicantComment, ExpertComment, SecretaryComment, Result, secretaryConfirmtype)
				VALUES
				(@ID, @AdmissionRequestID, @Type, @ApplicantComment, @ExpertComment, @SecretaryComment, @Result, @SecretaryConfirmtype)

			END
			ELSE
			BEGIN
				UPDATE req.Objection
				SET AdmissionRequestID = @AdmissionRequestID, [Type] = @Type, ApplicantComment = @ApplicantComment, ExpertComment = @ExpertComment, SecretaryComment = @SecretaryComment, Result = @Result, secretaryConfirmtype = @SecretaryConfirmtype
				WHERE ID = @ID
			END

			IF @ID is not null
			BEGIN
				Delete from req.ObjectionTest where ObjectionID = @ID
				insert into req.ObjectionTest(ID, ObjectionID, ExamTestID, ApplicantComment, ExpertComment, SecretaryComment, Result, NewTestRawScore, NewDescriptiveScore, IsObjected)
				select 
				NewID()
				, @ID 
				, detail.ExamTestID
				, detail.ApplicantComment
				, detail.ExpertComment
				, detail.SecretaryComment
				, detail.Result
				, detail.NewTestRawScore
				, detail.NewDescriptiveScore
				, detail.IsObjected
				from OPENJSON(@Tests)
				with(
					ExamTestID uniqueidentifier,
					ApplicantComment nvarchar(4000),
					ExpertComment nvarchar(4000),
					SecretaryComment nvarchar(4000),
					Result tinyint,
					NewTestRawScore int,
					NewDescriptiveScore numeric(5, 2),
					IsObjected bit
				) as detail
			END
			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END