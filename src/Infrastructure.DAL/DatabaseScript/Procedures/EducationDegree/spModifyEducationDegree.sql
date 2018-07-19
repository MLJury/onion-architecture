USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE object_id = OBJECT_ID('req.spModifyEducationDegree'))
	DROP PROCEDURE req.spModifyEducationDegree
GO

CREATE PROCEDURE req.spModifyEducationDegree
	@AIsNewRecord BIT,
	@AID UNIQUEIDENTIFIER,
	@ARequestID UNIQUEIDENTIFIER,
	@AGrade TINYINT,
	@AIssuanceCountryType TINYINT,
	@AUniversityID UNIQUEIDENTIFIER,
	@AUniversityName NVARCHAR(1000),
	@AUniversityUnitName NVARCHAR(200),
	@AEducationFieldID UNIQUEIDENTIFIER,
	@AGraduateDate SMALLDATETIME,
	@AEducationFieldName NVARCHAR(1000),
	@ARelatedCurricula INT,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @IsNewRecord BIT = ISNULL(@AIsNewRecord, 0),
		@ID UNIQUEIDENTIFIER = @AID,
		@RequestID UNIQUEIDENTIFIER = @ARequestID,
		@Grade TINYINT = COALESCE(@AGrade, 0),
		@IssuanceCountryType TINYINT = COALESCE(@AIssuanceCountryType, 0),
		@UniversityID UNIQUEIDENTIFIER = @AUniversityID,
		@UniversityName NVARCHAR(1000) = LTRIM(RTRIM(@AUniversityName)),
		@UniversityUnitName NVARCHAR(200) = LTRIM(RTRIM(@AUniversityUnitName)),
		@EducationFieldID UNIQUEIDENTIFIER = @AEducationFieldID,
		@GraduateDate SMALLDATETIME = @AGraduateDate,
		@EducationFieldName NVARCHAR(1000) = LTRIM(RTRIM(@AEducationFieldName)),
		@RelatedCurricula INT = @ARelatedCurricula,
		@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog))

	IF EXISTS(SELECT 1 FROM req.EducationDegree WHERE ID <> @ID AND RequestID = @RequestID AND Grade = @Grade AND UniversityID = @UniversityID AND COALESCE(UniversityName, '') = COALESCE(@UniversityName, '') AND EducationFieldID = @EducationFieldID AND COALESCE(EducationFieldName, '') = COALESCE(@EducationFieldName, ''))
		THROW 50000, 'مدرک وارد شده تکراری است', 1

	BEGIN TRY
		BEGIN TRAN
			IF @IsNewRecord = 1 -- insert
			BEGIN
				INSERT INTO req.EducationDegree
					(ID, RequestID, Grade, IssuanceCountryType, UniversityID, UniversityName, UniversityUnitName, EducationFieldID, GraduateDate, EducationFieldName, RelatedCurricula, [ReadOnly])
				VALUES
					(@ID, @RequestID, @Grade, @IssuanceCountryType, @UniversityID, @UniversityName, @UniversityUnitName, @EducationFieldID, @GraduateDate, @EducationFieldName, @RelatedCurricula, 0)
			END
			ELSE
			BEGIN
				UPDATE req.EducationDegree
				SET RequestID = @RequestID, Grade = @Grade, IssuanceCountryType = @IssuanceCountryType, UniversityID = @UniversityID, UniversityName = @UniversityName, UniversityUnitName = @UniversityUnitName, EducationFieldID = @EducationFieldID, GraduateDate = @GraduateDate, EducationFieldName = @EducationFieldName, RelatedCurricula = @RelatedCurricula
				WHERE ID = @ID
			END

			EXEC req.spUpdateExamTestState_ @RequestID   -- جهت مشخص کردن وضعیت مشروطین و معافین (از آزمون حسابداری و حسابرسی)

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END