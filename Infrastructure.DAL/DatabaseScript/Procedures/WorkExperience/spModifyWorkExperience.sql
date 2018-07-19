USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifyWorkExperience'))
	DROP PROCEDURE req.spModifyWorkExperience
GO

CREATE PROCEDURE req.spModifyWorkExperience
	@AIsNewRecord BIT,
	@AID UNIQUEIDENTIFIER,
	@ARequestID UNIQUEIDENTIFIER,
	@AWorkExperienceType TINYINT,
	@ACountryType TINYINT,
	@AWorkPlaceID UNIQUEIDENTIFIER,
	@AWorkPlaceName NVARCHAR(1000),
	@AJobTitle NVARCHAR(200),
	@AFromDate SMALLDATETIME,
	@AToDate SMALLDATETIME,
	@AInsuranceNumber NVARCHAR(50),
	@AInsuranceWorkCode VARCHAR(50),
	@ATaxScopeCode NVARCHAR(50),
	@AWorkActivityType TINYINT,
	@ATotalWorkExperience INT,
	@AInCountryWorkExperience INT,
	@ARelatedWorkExperience INT,
	@AIrrelevantWorkExperience INT,
	@AWorkPlaceGovernmentalType TINYINT,
	@AWorkPlaceGovernmental NVARCHAR(50),
	@ALog NVARCHAR(MAX)

WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @IsNewRecord BIT = ISNULL(@AIsNewRecord, 0),
			@ID UNIQUEIDENTIFIER = @AID,
			@RequestID UNIQUEIDENTIFIER = @ARequestID,
			@WorkExperienceType TINYINT = COALESCE(@AWorkExperienceType, 0),
			@CountryType TINYINT = COALESCE(@ACountryType, 0),
			@WorkPlaceID UNIQUEIDENTIFIER = @AWorkPlaceID,
			@WorkPlaceName NVARCHAR(1000) = LTRIM(RTRIM(@AWorkPlaceName)),
			@JobTitle NVARCHAR(200) = LTRIM(RTRIM(@AJobTitle)),
			@FromDate SMALLDATETIME = @AFromDate,
			@ToDate SMALLDATETIME = @AToDate,
			@InsuranceNumber NVARCHAR(50) = LTRIM(RTRIM(@AInsuranceNumber)),
			@InsuranceWorkCode VARCHAR(50) = LTRIM(RTRIM(@AInsuranceWorkCode)),
			@TaxScopeCode NVARCHAR(50) = LTRIM(RTRIM(@ATaxScopeCode)),
			@WorkActivityType TINYINT = @AWorkActivityType,
			@TotalWorkExperience INT = @ATotalWorkExperience,
			@InCountryWorkExperience INT = @AInCountryWorkExperience,
			@RelatedWorkExperience INT = @ARelatedWorkExperience,
			@IrrelevantWorkExperience INT = @AIrrelevantWorkExperience,
			@WorkPlaceGovernmentalType TINYINT = COALESCE(@AWorkPlaceGovernmentalType, 0),
			@WorkPlaceGovernmental NVARCHAR(50) = ltrim(rtrim(@AWorkPlaceGovernmental)),
			@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog))

	BEGIN TRY
		BEGIN TRAN
			
			IF @IsNewRecord = 1 -- insert
			BEGIN
				INSERT INTO req.WorkExperience
					(ID, RequestID, WorkExperienceType, CountryType, WorkPlaceID, WorkPlaceName, JobTitle, FromDate, ToDate, InsuranceNumber, InsuranceWorkCode, TaxScopeCode, WorkActivityType, TotalWorkExperience, InCountryWorkExperience, RelatedWorkExperience, IrrelevantWorkExperience, WorkPlaceGovernmentalType, [ReadOnly], WorkPlaceGovernmental)
				VALUES
					(@ID, @RequestID, @WorkExperienceType, @CountryType, @WorkPlaceID, @WorkPlaceName, @JobTitle, @FromDate, @ToDate, @InsuranceNumber, @InsuranceWorkCode, @TaxScopeCode, @WorkActivityType, @TotalWorkExperience, @InCountryWorkExperience, @RelatedWorkExperience, @IrrelevantWorkExperience, @WorkPlaceGovernmentalType, 0, @WorkPlaceGovernmental)
			END
			ELSE
			BEGIN
				UPDATE req.WorkExperience
				SET RequestID = @RequestID, WorkExperienceType = @WorkExperienceType, CountryType = @CountryType, WorkPlaceID = @WorkPlaceID, WorkPlaceName = @WorkPlaceName, JobTitle = @JobTitle, FromDate = @FromDate, ToDate = @ToDate, InsuranceNumber = @InsuranceNumber, InsuranceWorkCode = @InsuranceWorkCode, TaxScopeCode = @TaxScopeCode, WorkActivityType = @WorkActivityType, TotalWorkExperience = @TotalWorkExperience, InCountryWorkExperience = @InCountryWorkExperience, RelatedWorkExperience = @RelatedWorkExperience, IrrelevantWorkExperience = @IrrelevantWorkExperience, WorkPlaceGovernmentalType= @WorkPlaceGovernmentalType, WorkPlaceGovernmental = @WorkPlaceGovernmental
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