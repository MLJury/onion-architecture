USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifyExemptionRequest'))
	DROP PROCEDURE req.spModifyExemptionRequest
GO

CREATE PROCEDURE req.spModifyExemptionRequest
	@AIsNewRecord BIT,
	@AID uniqueidentifier,
	@AAdmissionID uniqueidentifier,
	@AApplicantUserID uniqueidentifier,
	@AAgreementType TINYINT,
	@AAgreementAccepted BIT,
	@APanelProceedingsNumber NVARCHAR(50),
	@APanelProceedingsDate SMALLDATETIME,
	@ACreatorID UNIQUEIDENTIFIER,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @IsNewRecord BIT = ISNULL(@AIsNewRecord, 0),
			@ID UNIQUEIDENTIFIER = @AID,
			@AdmissionID uniqueidentifier = @AAdmissionID,
			@ApplicantUserID uniqueidentifier = @AApplicantUserID,
			@AgreementType TINYINT = COALESCE(@AAgreementType, 0),
			@AgreementAccepted BIT = COALESCE(@AAgreementAccepted, 0),
			@PanelProceedingsNumber NVARCHAR(50) = @APanelProceedingsNumber,
			@PanelProceedingsDate SMALLDATETIME = @APanelProceedingsDate,
			@CreatorID UNIQUEIDENTIFIER = @ACreatorID,
			@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog)),
			@Type TinyINT = 2,     -- Exemption Request
			@TrackingCode NVARCHAR(50),
			@DocumentNumber NVARCHAR(1),    -- not used
			@CreationDate SMALLDATETIME

	BEGIN TRY
		BEGIN TRAN
			
			EXECUTE req.spModifyAdmissionRequest_ @IsNewRecord, @ID, @Type, @AdmissionID, @ApplicantUserID, @AgreementType, @AgreementAccepted, @CreatorID

			IF @IsNewRecord = 1 -- insert
			BEGIN
				INSERT INTO req.ExemptionRequest
				(ID, InterviewDate, PanelProceedingsNumber, PanelProceedingsDate)
				VALUES
				(@ID, NULL, @PanelProceedingsNumber, @PanelProceedingsDate)

			END
			--ELSE
			--BEGIN
			--	UPDATE req.ExemptionRequest
			--	SET DemandedTestType = @DemandedTestType
			--	WHERE ID = @ID
			--END

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END