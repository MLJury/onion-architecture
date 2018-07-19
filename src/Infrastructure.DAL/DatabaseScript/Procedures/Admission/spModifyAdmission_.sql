USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spModifyAdmission_'))
	DROP PROCEDURE adm.spModifyAdmission_
GO

CREATE PROCEDURE adm.spModifyAdmission_
	@AIsNewRecord BIT,
	@AID uniqueidentifier,
	@AType tinyint,
	@AYear SMALLINT,
	@ATitle	nvarchar(1000),
	@ARegisterStartDate smalldatetime,
	@ARegisterEndDate smalldatetime,
	@ARegisterExtendDate smalldatetime,
	@AVerifyStartDate smalldatetime,
	@AVerifyEndDate smalldatetime,
	@AVerifyExtendDate smalldatetime,
	@AObjectionStartDate smalldatetime,
	@AObjectionEndDate smalldatetime,
	@AObjectionExtendDate smalldatetime,
	@ACompleteRecordsStartDate smalldatetime,
	@ACompleteRecordsEndDate smalldatetime,
	@ARegistrationFee INT,
	@ACreatorID UNIQUEIDENTIFIER 
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
			@ObjectionStartDate smalldatetime = @AObjectionStartDate ,
			@ObjectionEndDate smalldatetime = @AObjectionEndDate,
			@ObjectionExtendDate smalldatetime = @AObjectionExtendDate,
			@CompleteRecordsStartDate smalldatetime = @ACompleteRecordsStartDate,
			@CompleteRecordsEndDate smalldatetime = @ACompleteRecordsEndDate,
			@RegistrationFee INT = @ARegistrationFee,
			@CreatorID UNIQUEIDENTIFIER = @ACreatorID,
			@LastExamAdmissionID UNIQUEIDENTIFIER 

	BEGIN TRY
		BEGIN TRAN
			IF @IsNewRecord = 1 -- insert
			BEGIN

				INSERT INTO adm.Admission
				(ID, [Type], [Year], Title,RegisterStartDate, RegisterEndDate, RegisterExtendDate, VerifyStartDate, VerifyEndDate, VerifyExtendDate, ObjectionStartDate, ObjectionEndDate, ObjectionExtendDate, CompleteRecordsStartDate, CompleteRecordsEndDate, RegistrationFee, CreatorID, CreationDate)
				VALUES
				(@ID, @Type, @Year, @Title, @RegisterStartDate, @RegisterEndDate, @RegisterExtendDate, @VerifyStartDate, @VerifyEndDate, @VerifyExtendDate, @ObjectionStartDate, @ObjectionEndDate, @ObjectionExtendDate, @CompleteRecordsStartDate, @CompleteRecordsEndDate, @RegistrationFee, @CreatorID, GETDATE())

			END
			ELSE
			BEGIN
			--
				UPDATE adm.Admission
				SET [Year] = @Year, Title = @Title,RegisterStartDate = @RegisterStartDate, RegisterEndDate = @RegisterEndDate, RegisterExtendDate = @RegisterExtendDate, VerifyStartDate = @VerifyStartDate, ObjectionStartDate = @ObjectionStartDate, ObjectionEndDate = @ObjectionEndDate, ObjectionExtendDate = @ObjectionExtendDate, CompleteRecordsStartDate = @CompleteRecordsStartDate, CompleteRecordsEndDate = @CompleteRecordsEndDate, RegistrationFee = @RegistrationFee, VerifyEndDate = @VerifyEndDate, VerifyExtendDate = @VerifyExtendDate
				WHERE ID = @ID
			END

		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END