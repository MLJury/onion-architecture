USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spModifyExamAdmission'))
	DROP PROCEDURE adm.spModifyExamAdmission
GO

CREATE PROCEDURE adm.spModifyExamAdmission
	@AIsNewRecord BIT,
	@AID uniqueidentifier,
	@AType TINYINT = 1,    -- admission type: EXAM
	@AYear SMALLINT,
	@ATitle	NVARCHAR(1000),
	@ARegisterStartDate SMALLDATETIME,
	@ARegisterEndDate SMALLDATETIME,
	@ARegisterExtendDate SMALLDATETIME,
	@AVerifyStartDate SMALLDATETIME,
	@AVerifyEndDate SMALLDATETIME,
	@AVerifyExtendDate smalldatetime,
	@AObjectionStartDate smalldatetime,
	@AObjectionEndDate smalldatetime,
	@AObjectionExtendDate smalldatetime,
	@ACompleteRecordsStartDate smalldatetime,
	@ACompleteRecordsEndDate smalldatetime,
	@ARegistrationFee INT,
	@AFirstChairNumber INT,
	@AExamDate SMALLDATETIME,
	@AResultsAnnouncementDate SMALLDATETIME,
	@AConditionalYears TINYINT,
	@APrintDate SMALLDATETIME,
	@AShowChairNumberButton BIT,
	@ACreatorID UNIQUEIDENTIFIER, 
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @IsNewRecord BIT = ISNULL(@AIsNewRecord, 0),
			@ID UNIQUEIDENTIFIER = @AID,
			@Type tinyint = COALESCE(@AType, 0),
			@Year SMALLINT = COALESCE(@AYear, 0),
			@Title nvarchar(1000) = LTRIM(RTRIM(@ATitle)),
			@RegisterStartDate smalldatetime = @ARegisterStartDate,
			@RegisterEndDate smalldatetime = @ARegisterEndDate,
			@RegisterExtendDate smalldatetime = @ARegisterExtendDate,
			@VerifyStartDate smalldatetime = @AVerifyStartDate,
			@VerifyEndDate smalldatetime = @AVerifyEndDate,
			@VerifyExtendDate smalldatetime = @AVerifyExtendDate,
			@ObjectionStartDate smalldatetime = @AObjectionStartDate,
			@ObjectionEndDate smalldatetime = @AObjectionEndDate,
			@ObjectionExtendDate smalldatetime = @AObjectionExtendDate,
			@CompleteRecordsStartDate smalldatetime = @ACompleteRecordsStartDate,
			@CompleteRecordsEndDate smalldatetime = @ACompleteRecordsEndDate,
			@RegistrationFee INT = @ARegistrationFee,
			@FirstChairNumber INT = @AFirstChairNumber,
			@ExamDate SMALLDATETIME = @AExamDate,
			@ResultsAnnouncementDate SMALLDATETIME = @AResultsAnnouncementDate,
			@ConditionalYears TINYINT = @AConditionalYears,
			@PrintDate SMALLDATETIME = @APrintDate,
			@ShowChairNumberButton BIT = COALESCE(@AShowChairNumberButton, 0),
			@CreatorID UNIQUEIDENTIFIER = @ACreatorID,
			@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog)),
			@LastExamAdmissionID UNIQUEIDENTIFIER

	BEGIN TRY
		BEGIN TRAN
			
			EXECUTE adm.spModifyAdmission_ @IsNewRecord, @ID, @Type, @Year, @Title, @RegisterStartDate, @RegisterEndDate, @RegisterExtendDate, @VerifyStartDate, @VerifyEndDate, @VerifyExtendDate, @ObjectionStartDate, @ObjectionEndDate, @ObjectionExtendDate, @CompleteRecordsStartDate, @CompleteRecordsEndDate, @RegistrationFee, @CreatorID

			IF @IsNewRecord = 1 -- insert
			BEGIN
				
				INSERT INTO [adm].[ExamAdmission]
				([ID], [FirstChairNumber], [ExamDate], [ResultsAnnouncementDate], [ConditionalYears], [PrintDate], [ShowChairNumberButton])
				VALUES
				(@ID, @FirstChairNumber, @ExamDate, @ResultsAnnouncementDate, @ConditionalYears, @PrintDate, @ShowChairNumberButton)

				-- افزودن رکوردها برای نصاب ها
				insert into adm.Quorum 
				VALUES(NEWID(), @ID, 1, null, null, null)
				insert into adm.Quorum 
				VALUES(NEWID(), @ID, 2, null, null, null)
				insert into adm.Quorum 
				VALUES(NEWID(), @ID, 4, null, null, null)
				insert into adm.Quorum 
				VALUES(NEWID(), @ID, 8, null, null, null)

				-- افزودن رکوردها برای نصاب ها
				insert into pbl.SurveyTemplate
				(ID, Title, AdmissionID, CreationDate, CreatorID, IsRemoved, QuestionType)
				select 
					NEWID(),
					surveytmp.Title,
					surveytmp.AdmissionID,
					GETDATE(),
					@CreatorID,
					0,
					null
				from pbl.SurveyTemplate surveytmp
				where AdmissionID = (select top 1 ID from adm.Admission order by CreationDate desc)

				-- افزودن رکوردها برای تنظیم شماره صندلی ها
				SET @LastExamAdmissionID = (select TOP 1 eadm.ID
												from adm.ExamAdmission eadm
												inner join adm.Admission adm on eadm.ID = adm.ID
												WHERE EXISTS (SELECT 1 FROM adm.ChairNumber WHERE AdmissionID = eadm.ID)
												ORDER BY RegisterStartDate DESC
												)
					
				IF @LastExamAdmissionID IS NOT NULL
				BEGIN
					INSERT INTO adm.ChairNumber
					(ID, AdmissionID, TestType, [Order], FromChairNumber, ToChairNumber, CreationDate)
					SELECT NEWID() ID
						, @ID AdmissionID
						, TestType
						, [Order]
						, 0 [FromChairNumber]
						, 0 [ToChairNumber]
						, GETDATE() [CreationDate]
					FROM adm.ChairNumber WHERE AdmissionID = @LastExamAdmissionID
				END
				ELSE
				BEGIN
					;WITH nums AS
					   (SELECT 1 AS value
						UNION ALL
						SELECT value + 1 AS value
						FROM nums
						WHERE nums.value <= 14)
					INSERT INTO adm.ChairNumber
					(ID, AdmissionID, TestType, [Order], FromChairNumber, ToChairNumber, CreationDate)
					SELECT NEWID() ID
						, @ID AdmissionID
						, [value] TestType
						, [value] [Order]
						, 0 FromChairNumber
						, 0 ToChairNumber
						, GETDATE() [CreationDate]
						FROM nums 
				END
			END
			ELSE
			BEGIN
				UPDATE [adm].[ExamAdmission]
				SET [FirstChairNumber] = @FirstChairNumber, [ExamDate] = @ExamDate, [ResultsAnnouncementDate] = @ResultsAnnouncementDate, [ConditionalYears] = @ConditionalYears, [PrintDate] = @PrintDate, [ShowChairNumberButton] = @ShowChairNumberButton
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