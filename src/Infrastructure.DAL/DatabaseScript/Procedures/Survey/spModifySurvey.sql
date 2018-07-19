USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE object_id = OBJECT_ID('pbl.spModifySurvey'))
	DROP PROCEDURE pbl.spModifySurvey
GO

CREATE PROCEDURE pbl.spModifySurvey
	@AIsNewRecord BIT,
	@AUserOpinions NVARCHAR(MAX),
	@AAdmissionID UNIQUEIDENTIFIER,
	@AUserID UNIQUEIDENTIFIER,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @IsNewRecord BIT = ISNULL(@AIsNewRecord, 0),
		@UserOpinions NVARCHAR(MAX) = @AUserOpinions,
		@AdmissionID UNIQUEIDENTIFIER = @AAdmissionID,
		@UserID UNIQUEIDENTIFIER = @AUserID,
		@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog))

	BEGIN TRY
		BEGIN TRAN
			IF @IsNewRecord = 1 -- insert
			BEGIN
				INSERT INTO pbl.Survey
				SELECT 
					NEWID(),
					opinions.SurveyTemplateID,
					opinions.TestType,
					opinions.AnswerType,
					@UserID,
					0,
					QuestionType
				FROM OPENJSON(@UserOpinions)
				WITH (
					SurveyTemplateID UNIQUEIDENTIFIER,
					TestType TINYINT,
					AnswerType TINYINT,
					QuestionType TINYINT
				) as opinions
			END
			ELSE
			BEGIN
				delete survey from pbl.Survey survey
				inner join pbl.SurveyTemplate surveyTemplate on surveyTemplate.ID = survey.SurveyTemplateID
				where survey.CreatorID = @UserID and surveyTemplate.AdmissionID = @AdmissionID
				INSERT INTO Survey
				SELECT 
					NEWID(),
					opinions.SurveyTemplateID,
					opinions.TestType,
					opinions.AnswerType,
					@UserID,
					0,
					QuestionType
				FROM OPENJSON(@UserOpinions)
				WITH (
					SurveyTemplateID UNIQUEIDENTIFIER,
					TestType TINYINT,
					AnswerType TINYINT,
					QuestionType TINYINT
				) as opinions
			END

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END