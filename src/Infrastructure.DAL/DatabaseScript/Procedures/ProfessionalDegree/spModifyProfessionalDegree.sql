USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifyProfessionalDegree'))
	DROP PROCEDURE req.spModifyProfessionalDegree
GO

CREATE PROCEDURE req.spModifyProfessionalDegree
	@AIsNewRecord BIT,
	@AID UNIQUEIDENTIFIER,
	@ARequestID UNIQUEIDENTIFIER,
	@ADegreeType TINYINT,
	@ADegreeTypeName NVARCHAR(1000),
	@ACountryID UNIQUEIDENTIFIER,
	@ADate SMALLDATETIME,
	@ANumber VARCHAR(50),
	@ALog NVARCHAR(MAX)

WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @IsNewRecord BIT = ISNULL(@AIsNewRecord, 0),
		@ID UNIQUEIDENTIFIER = @AID,
		@RequestID UNIQUEIDENTIFIER = @ARequestID,
		@DegreeType TINYINT = @ADegreeType,
		@DegreeTypeName NVARCHAR(1000) = LTRIM(RTRIM(@ADegreeTypeName)),
		@CountryID UNIQUEIDENTIFIER = @ACountryID,
		@Date SMALLDATETIME = @ADate,
		@Number VARCHAR(50) = LTRIM(RTRIM(@ANumber)),
		@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog))

		IF EXISTS(SELECT 1 FROM req.ProfessionalDegree WHERE ID <> @ID AND RequestID = @RequestID AND DegreeType = @DegreeType AND DegreeTypeName = @DegreeTypeName AND CountryID = @CountryID)
		RETURN -2 -- نام تکراری می باشد

	BEGIN TRY
		BEGIN TRAN
			
			IF @IsNewRecord = 1 -- insert
			BEGIN
				INSERT INTO req.ProfessionalDegree
					(ID, RequestID, DegreeType, DegreeTypeName, CountryID, Date, Number, [ReadOnly])
				VALUES
					(@ID, @RequestID, @DegreeType, @DegreeTypeName, @CountryID, @Date, @Number, 0)
			END
			ELSE
			BEGIN
				UPDATE req.ProfessionalDegree
				SET RequestID = @RequestID, DegreeType = @DegreeType, DegreeTypeName = @DegreeTypeName, CountryID = @CountryID, Date = @Date, Number = @Number
				WHERE ID = @ID
			END

			EXEC req.spUpdateExamTestState_ @AExamRequestID = @RequestID     -- جهت مشخص کردن وضعیت مشروطین و معافین (از آزمون حسابداری و حسابرسی)

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END