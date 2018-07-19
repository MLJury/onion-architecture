USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spModifyExemptionAdmission'))
	DROP PROCEDURE adm.spModifyExemptionAdmission
GO

CREATE PROCEDURE adm.spModifyExemptionAdmission
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
		@Type tinyint = @AType,
		@Year SMALLINT = @AYear,
		@Title	nvarchar(1000) = @ATitle,
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
		@CreatorID UNIQUEIDENTIFIER = @ACreatorID 

	BEGIN TRY
		BEGIN TRAN
			IF @IsNewRecord = 1 -- insert
			BEGIN
			-- 
				EXECUTE adm.spModifyAdmission_ @IsNewRecord, @ID, @Type, @Year, @Title, @RegisterStartDate, @RegisterEndDate, @RegisterExtendDate, @VerifyStartDate, @VerifyEndDate, @VerifyExtendDate, @ObjectionStartDate, @ObjectionEndDate, @ObjectionExtendDate, @CompleteRecordsStartDate, @CompleteRecordsEndDate, @RegistrationFee, @CreatorID

				INSERT INTO adm.ExemptionAdmission
				(ID)
				VALUES
				(@ID)

			END
			ELSE
			BEGIN
				EXECUTE adm.spModifyAdmission_ @IsNewRecord, @ID, @Type, @Year, @Title, @RegisterStartDate, @RegisterEndDate, @RegisterExtendDate, @VerifyStartDate, @VerifyEndDate, @VerifyExtendDate, @ObjectionStartDate, @ObjectionEndDate, @ObjectionExtendDate, @CompleteRecordsStartDate, @CompleteRecordsEndDate, @RegistrationFee, @CreatorID
				--UPDATE adm.ExemptionAdmission
				--SET ID = null
				--WHERE ID = @ID
			END

		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END