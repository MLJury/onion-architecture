USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifyExpertOpinion'))
	DROP PROCEDURE req.spModifyExpertOpinion
GO

CREATE PROCEDURE req.spModifyExpertOpinion
	@AAdmissionRequestID UNIQUEIDENTIFIER,
	@AExpertConfirmType TINYINT,
	@AEligibleReasonType TINYINT,
	@AExpertComment NVARCHAR(1000),
	@AApplicantVerifyState TINYINT,
	@AApplicantVerifyComment NVARCHAR(1000),
	@AEducationDegreeVerifyState TINYINT,
	@AEducationDegreeVerifyComment NVARCHAR(1000),
	@AWorkExperienceVerifyState TINYINT,
	@AWorkExperienceVerifyComment NVARCHAR(1000),
	@AProfessionalDegreeVerifyState TINYINT,
	@AProfessionalDegreeVerifyComment NVARCHAR(1000),
	@AManagementHistoryVerifyState TINYINT,
	@AManagementHistoryVerifyComment NVARCHAR(1000),
	@AReasons VARCHAR(4000),
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @AdmissionRequestID UNIQUEIDENTIFIER = @AAdmissionRequestID,
		@ExpertConfirmType TINYINT = coalesce(@AExpertConfirmType, 0),
		@EligibleReasonType TINYINT = COALESCE(@AEligibleReasonType, 0),
		@ExpertComment NVARCHAR(1000) = LTRIM(RTRIM(@AExpertComment)),
		@ApplicantVerifyState TINYINT = COALESCE(@AApplicantVerifyState, 0),
		@ApplicantVerifyComment NVARCHAR(1000) = LTRIM(RTRIM(@AApplicantVerifyComment)),
		@EducationDegreeVerifyState TINYINT = COALESCE(@AEducationDegreeVerifyState, 0),
		@EducationDegreeVerifyComment NVARCHAR(1000) = LTRIM(RTRIM(@AEducationDegreeVerifyComment)),
		@WorkExperienceVerifyState TINYINT = COALESCE(@AWorkExperienceVerifyState, 0),
		@WorkExperienceVerifyComment NVARCHAR(1000) = LTRIM(RTRIM(@AWorkExperienceVerifyComment)),
		@ProfessionalDegreeVerifyState TINYINT = COALESCE(@AProfessionalDegreeVerifyState, 0),
		@ProfessionalDegreeVerifyComment NVARCHAR(1000) = LTRIM(RTRIM(@AProfessionalDegreeVerifyComment)),
		@ManagementHistoryVerifyState TINYINT = COALESCE(@AManagementHistoryVerifyState, 0),
		@ManagementHistoryVerifyComment NVARCHAR(1000) = LTRIM(RTRIM(@AManagementHistoryVerifyComment)),
		@Reasons VARCHAR(4000) = @AReasons,
		@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog))

	BEGIN TRY
		BEGIN TRAN
			
		update req.Opinion 
		set ApplicantVerifyState = @ApplicantVerifyState 
			, ApplicantVerifyComment = @ApplicantVerifyComment 
			, EducationDegreeVerifyState = @EducationDegreeVerifyState 
			, EducationDegreeVerifyComment = @EducationDegreeVerifyComment 
			, WorkExperienceVerifyState = @WorkExperienceVerifyState 
			, WorkExperienceVerifyComment = @WorkExperienceVerifyComment 
			, ProfessionalDegreeVerifyState = @ProfessionalDegreeVerifyState 
			, ProfessionalDegreeVerifyComment = @ProfessionalDegreeVerifyComment
			, ManagementHistoryVerifyState  = @ManagementHistoryVerifyState 
			, ManagementHistoryVerifyComment = @ManagementHistoryVerifyComment
			, ExpertConfirmType = @ExpertConfirmType
			, EligibleReasonType = @EligibleReasonType
			, ExpertComment = @ExpertComment
		where AdmissionRequestID = @AdmissionRequestID

		DELETE FROM req.Reason WHERE AdmissionRequestID = @AdmissionRequestID
		INSERT INTO req.Reason
		(ID, AdmissionRequestID, ExpertConfirmType, ReasonType)
		SELECT
			NEWID() ID 
			, @AAdmissionRequestID AdmissionRequestID
			, @ExpertConfirmType ExpertConfirmType
			, value ReasonType
		FROM OPENJSON(@Reasons)

		EXEC pbl.spAddLog @Log

		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END