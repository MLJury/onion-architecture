USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spModifySurveyTemplate'))
	DROP PROCEDURE pbl.spModifySurveyTemplate
GO

CREATE PROCEDURE pbl.spModifySurveyTemplate
	@AIsNewRecord BIT,
	@AID uniqueidentifier,
	@AAdmissionID uniqueidentifier,
	@AQuestionType tinyint,
	@ATitle nvarchar(200),
	@AUserID UNIQUEIDENTIFIER,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @IsNewRecord BIT = ISNULL(@AIsNewRecord, 0),
			@ID UNIQUEIDENTIFIER = @AID,
			@AdmissionID uniqueidentifier = @AAdmissionID,
			@QuestionType tinyint = @AQuestionType,
			@Title nvarchar(200) = Ltrim(Rtrim(@ATitle)),
			@UserID UNIQUEIDENTIFIER = @AUserID,
			@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog))

	BEGIN TRY
		BEGIN TRAN
			IF @IsNewRecord = 1 -- insert
			BEGIN
				INSERT INTO pbl.SurveyTemplate
				(ID, Title, AdmissionID, QuestionType, CreatorID, CreationDate)
				VALUES
				(@ID, @Title, @AdmissionID, @QuestionType, @UserID, GETDATE())

			END
			ELSE
			BEGIN
				UPDATE pbl.SurveyTemplate
				SET [Title] = @Title, QuestionType = @QuestionType
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