USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifyAdmissionRequest_'))
	DROP PROCEDURE req.spModifyAdmissionRequest_
GO

CREATE PROCEDURE req.spModifyAdmissionRequest_
	@AIsNewRecord BIT,
	@AID uniqueidentifier,
	@AType TinyINT,
	@AAdmissionID uniqueidentifier,
	@AApplicantUserID uniqueidentifier,
	@AAgreementType TINYINT,
	@AAgreementAccepted BIT,
	@ACreatorID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @IsNewRecord BIT = ISNULL(@AIsNewRecord, 0),
		@ID UNIQUEIDENTIFIER = @AID,
		@Type TinyINT = COALESCE(@AType, 0),
		@AdmissionID uniqueidentifier = @AAdmissionID,
		@ApplicantUserID uniqueidentifier = @AApplicantUserID,
		@AgreementType TINYINT = COALESCE(@AAgreementType, 0),
		@AgreementAccepted BIT = COALESCE(@AAgreementAccepted, 0),
		@CreatorID UNIQUEIDENTIFIER = @ACreatorID,
		@TrackingCode NVARCHAR(50),
		@DocumentNumber NVARCHAR(50),    -- not used
		@CreationDate SMALLDATETIME,
		@LastRequestID UNIQUEIDENTIFIER,
		@LastExemptionRequestID UNIQUEIDENTIFIER,
		@HasPreviousExamRequest BIT = 0,
		@HasPreviousExemptionRequest BIT = 0,
		@HasBeenEligible BIT = 0,
		@HasBeenUnEligible BIT = 0,
		@HasBeenDeprived BIT = 0,
		@ExpertPreviousComment NVARCHAR(1000),
		@ApplicantNationalCode varchar(11)

		SET @ApplicantNationalCode = (select NationalCode from org.Users where ID = @ApplicantUserID)

	BEGIN TRY
		BEGIN TRAN
			
			IF @IsNewRecord = 1 -- insert
			BEGIN
				
				SET @TrackingCode = (SELECT
						REVERSE(SUBSTRING(dbo.fnGetShamsiDate(GETDATE()),3,2)
						+ SUBSTRING(dbo.fnGetShamsiDate(GETDATE()),6,2)
						+ SUBSTRING(dbo.fnGetShamsiDate(GETDATE()),9,2))
						+ RIGHT('0000' + RTRIM(CAST((SELECT
						COUNT(*) + 1
						FROM pbl.BaseDocument doc
						WHERE (DATEPART(YEAR, doc.CreationDate) = DATEPART(YEAR, GETDATE())
						AND DATEPART(MONTH, doc.CreationDate) = DATEPART(MONTH, GETDATE())
						AND DATEPART(DAY, doc.CreationDate) = DATEPART(DAY, GETDATE()))
						AND (@Type IS NULL OR doc.type = @Type))
						AS varchar(10))), 4)
						+ RIGHT('0' + RTRIM(@Type), 2))
				
				-- if @DocumentNumber exists before use it, else generate in format 1396******
				SET @DocumentNumber = (SELECT TOP 1 doc.DocumentNumber 
										FROM pbl.BaseDocument doc
										INNER JOIN req.AdmissionRequest req ON req.ID = doc.ID
										WHERE req.ApplicantUserID = @ApplicantUserID
										AND COALESCE(doc.DocumentNumber, '') <> '')
				
				WHILE (COALESCE(@DocumentNumber, '') = '')
				BEGIN
					SET @DocumentNumber = SUBSTRING(dbo.fnGetShamsiDate(GETDATE()),1,4)  -- 4 digits year
											+ cast((900000* Rand() + 100000) as char(6))     -- 6 digits random
					IF EXISTS (SELECT 1 FROM pbl.BaseDocument WHERE DocumentNumber = @DocumentNumber)
						SET @DocumentNumber = ''
				END


				EXECUTE pbl.spModifyBaseDocument_ @IsNewRecord, @ID, @Type, @CreatorID, @TrackingCode, @DocumentNumber, @CreationDate OUTPUT
				
				SET @LastRequestID = (SELECT TOP 1 req.ID FROM req.AdmissionRequest req 
										      INNER JOIN adm.Admission adm ON req.AdmissionID = adm.ID
										      WHERE req.ApplicantUserID = @ApplicantUserID
										      ORDER BY RegisterStartDate DESC)

				SET @LastExemptionRequestID = (SELECT TOP 1 req.ID FROM req.AdmissionRequest req 
										      INNER JOIN adm.Admission adm ON req.AdmissionID = adm.ID
										      WHERE req.ApplicantUserID = @ApplicantUserID
										      ORDER BY RegisterStartDate DESC)

				IF EXISTS (SELECT 1 FROM req.AdmissionRequest req INNER JOIN adm.Admission admission ON admission.ID = req.AdmissionID WHERE req.ApplicantUserID = @ApplicantUserID AND admission.Type = 1)  -- آزمون
					SET @HasPreviousExamRequest = 1

				IF EXISTS (SELECT 1 FROM req.AdmissionRequest req INNER JOIN adm.Admission admission ON admission.ID = req.AdmissionID WHERE req.ApplicantUserID = @ApplicantUserID AND admission.Type = 2)  -- معافیت از آزمون
					SET @HasPreviousExemptionRequest = 1

				IF EXISTS (SELECT 1 FROM req.AdmissionRequest req INNER JOIN req.Opinion opn ON opn.AdmissionRequestID = req.ID WHERE req.ApplicantUserID = @ApplicantUserID AND opn.SecretaryConfirmType = 1)  -- واجد
					SET @HasBeenEligible = 1

				IF EXISTS (SELECT 1 FROM req.AdmissionRequest req INNER JOIN req.Opinion opn ON opn.AdmissionRequestID = req.ID WHERE req.ApplicantUserID = @ApplicantUserID AND opn.SecretaryConfirmType = 2)  -- غیر واجد
					SET @HasBeenUnEligible = 1

				IF EXISTS (SELECT 1 FROM adm.Deprived WHERE NationalCode = @ApplicantNationalCode )  -- محروم
					SET @HasBeenDeprived = 1

				SET @ExpertPreviousComment = (SELECT TOP 1 opn.ExpertComment FROM req.AdmissionRequest req INNER JOIN req.Opinion opn ON opn.AdmissionRequestID = req.ID INNER JOIN pbl.BaseDocument doc ON doc.Id = req.ID WHERE req.ApplicantUserID = @ApplicantUserID ORDER BY doc.CreationDate DESC)

				INSERT INTO req.AdmissionRequest
				(ID, AdmissionID, ApplicantUserID, AgreementType, AgreementAccepted, HasPreviousExamRequest, HasPreviousExemptionRequest, HasBeenEligible, HasBeenUnEligible, HasBeenDeprived)
				VALUES
				(@ID, @AdmissionID, @ApplicantUserID, @AgreementType, @AgreementAccepted, @HasPreviousExamRequest, @HasPreviousExemptionRequest, @HasBeenEligible, @HasBeenUnEligible, @HasBeenDeprived)

				INSERT INTO req.Opinion
				(ID, AdmissionRequestID, ApplicantVerifyState, EducationDegreeVerifyState, WorkExperienceVerifyState, ProfessionalDegreeVerifyState, ManagementHistoryVerifyState, ExpertConfirmType, EligibleReasonType, ExpertPreviousComment, BossConfirmType, SecretaryConfirmType, ProtectionUnitConfirmType)
				VALUES
				(NEWID(), @ID, 0, 0, 0, 0, 0, 0, 0, @ExpertPreviousComment, 0, 0, 0)

				INSERT INTO req.Applicant
				(ID, Gender, BirthDate, Tel, BCNumber, BCSerial, BCSeries, BCLetter, IssuancePlace, FatherName, Religion, Faith, AddressProvinceID, AddressCountyID, AddressCityID, PostalCode, Address, WorkProvinceID, WorkCountyID, WorkCityID, WorkAddress, WorkPostalCode, WorkTel, MilitaryServiceStartDate, MilitaryServiceEndDate, MilitaryServiceType, [ReadOnly])
				SELECT @ID,
					Applicant.Gender,
					applicant.BirthDate,
					applicant.Tel,
					applicant.BCNumber,
					applicant.BCSerial,
					applicant.BCSeries,
					applicant.BCLetter,
					applicant.IssuancePlace,
					applicant.FatherName,
					applicant.Religion,
					applicant.Faith,
					applicant.AddressProvinceID,
					applicant.AddressCountyID,
					applicant.AddressCityID,
					applicant.PostalCode,
					applicant.Address,
					applicant.WorkProvinceID,
					applicant.WorkCountyID,
					applicant.WorkCityID,
					applicant.WorkAddress,
					applicant.WorkPostalCode,
					applicant.WorkTel,
					applicant.MilitaryServiceStartDate,
					applicant.MilitaryServiceEndDate,
					applicant.MilitaryServiceType,
					@HasBeenEligible [ReadOnly] 
				FROM req.Applicant applicant
				INNER JOIN req.AdmissionRequest req ON req.ID = Applicant.ID
				WHERE req.ID = @LastRequestID

				INSERT INTO req.EducationDegree
				(ID, RequestID, Grade, IssuanceCountryType, UniversityID, UniversityName, UniversityUnitName, EducationFieldID, EducationFieldName, GraduateDate, RelatedCurricula, [ReadOnly])
				SELECT
					NEWID() ID,
					@ID RequestID,
					ed.Grade,
					IssuanceCountryType,
					ed.UniversityID,
					ed.UniversityName UniversityName,
					UniversityUnitName,
					ed.EducationFieldID,
					ed.EducationFieldName,
					ed.GraduateDate,
					ed.RelatedCurricula,
					@HasBeenEligible [ReadOnly]
				FROM req.EducationDegree ed
				INNER JOIN req.AdmissionRequest req ON req.ID = ed.RequestID
				WHERE req.ID = @LastRequestID

				insert into req.ProfessionalDegree
				(ID, RequestID, DegreeType, DegreeTypeName, CountryID, [Date], Number, [ReadOnly])
				SELECT
					NEWID() ID,
					@ID RequestID,
					degree.DegreeType,
					degree.DegreeTypeName,
					degree.CountryID,
					degree.[Date],
					degree.Number,
					@HasBeenEligible [ReadOnly]
				FROM req.ProfessionalDegree degree
				INNER JOIN req.AdmissionRequest req ON req.ID = degree.RequestID
				WHERE req.ID = @LastRequestID

				INSERT INTO req.WorkExperience
				(ID, RequestID, WorkExperienceType, CountryType, WorkPlaceID, WorkPlaceName, WorkPlaceGovernmentalType, JobTitle, FromDate, ToDate, InsuranceNumber, InsuranceWorkCode, TaxScopeCode, WorkActivityType, TotalWorkExperience, InCountryWorkExperience, RelatedWorkExperience, IrrelevantWorkExperience, [ReadOnly])
				SELECT
					NEWID() ID,
					@ID RequestID,
					we.WorkExperienceType,
					we.CountryType,
					we.WorkPlaceID,
					we.WorkPlaceName,
					we.WorkPlaceGovernmentalType,
					we.JobTitle,
					we.FromDate,
					we.ToDate,
					we.InsuranceNumber,
					we.InsuranceWorkCode,
					we.TaxScopeCode,
					we.WorkActivityType,
					we.TotalWorkExperience,
					we.InCountryWorkExperience,
					we.RelatedWorkExperience,
					we.IrrelevantWorkExperience,
					@HasBeenEligible [ReadOnly]
				FROM req.WorkExperience we
				INNER JOIN req.AdmissionRequest req ON req.ID = we.RequestID
				WHERE (req.ID = @LastRequestID)

				IF @Type = 2
				BEGIN 
					INSERT INTO req.ManagementHistory
					(ID, RequestID, OrganizationName, [Type], JobTitle, FromDate, ToDate, [ReadOnly])
					SELECT
						NEWID() ID,
						@ID RequestID,
						mh.OrganizationName,
						mh.[Type],
						mh.JobTitle,
						mh.FromDate,
						mh.ToDate,
						@HasBeenEligible [ReadOnly]
					FROM req.ManagementHistory mh
					INNER JOIN req.AdmissionRequest req ON req.ID = mh.RequestID
					WHERE (req.ID = @LastRequestID)
				END

				--   request attachments
				INSERT INTO pbl.Attachment 
				(ID, ParentID, [Type], [FileName], Comment, [Data])
				SELECT 
					NEWID() ID, 
					@ID ParentID, 
					[Type], 
					[FileName], 
					Comment, 
					[Data]
				FROM pbl.Attachment
				WHERE ParentID = @LastRequestID

				--   EducationDegree attachments
				INSERT INTO pbl.Attachment 
				(ID, ParentID, [Type], [FileName], Comment, [Data])
				SELECT 
					NEWID() ID, 
					EducationDegree.ID ParentID, 
					attch.[Type], 
					attch.[FileName], 
					attch.Comment, 
					attch.[Data]
				FROM pbl.Attachment attch
				INNER JOIN req.EducationDegree EducationDegree_old ON EducationDegree_old.ID = attch.ParentID AND EducationDegree_old.RequestID = @LastRequestID
				INNER JOIN req.EducationDegree EducationDegree ON EducationDegree.GraduateDate = EducationDegree_old.GraduateDate AND EducationDegree.RequestID = @ID

				--   ProfessionalDegree attachments
				INSERT INTO pbl.Attachment 
				(ID, ParentID, [Type], [FileName], Comment, [Data])
				SELECT 
					NEWID() ID, 
					ProfessionalDegree.ID ParentID, 
					attch.[Type], 
					attch.[FileName], 
					attch.Comment, 
					attch.[Data]
				FROM pbl.Attachment attch
				INNER JOIN req.ProfessionalDegree ProfessionalDegree_old ON ProfessionalDegree_old.ID = attch.ParentID AND ProfessionalDegree_old.RequestID = @LastRequestID
				INNER JOIN req.ProfessionalDegree ProfessionalDegree ON ProfessionalDegree.[Date] = ProfessionalDegree_old.[Date] AND ProfessionalDegree.RequestID = @ID

				--   WorkExperience attachments
				INSERT INTO pbl.Attachment 
				(ID, ParentID, [Type], [FileName], Comment, [Data])
				SELECT 
					NEWID() ID, 
					WorkExperience.ID ParentID, 
					attch.[Type], 
					attch.[FileName], 
					attch.Comment, 
					attch.[Data]
				FROM pbl.Attachment attch
				INNER JOIN req.WorkExperience WorkExperience_old ON WorkExperience_old.ID = attch.ParentID AND WorkExperience_old.RequestID = @LastRequestID
				INNER JOIN req.WorkExperience WorkExperience ON WorkExperience.FromDate = WorkExperience_old.FromDate AND WorkExperience.RequestID = @ID

				--   ManagementHistory attachments
				IF @Type = 2
				BEGIN
					INSERT INTO pbl.Attachment 
					(ID, ParentID, [Type], [FileName], Comment, [Data])
					SELECT 
						NEWID() ID, 
						ManagementHistory.ID ParentID, 
						attch.[Type], 
						attch.[FileName], 
						attch.Comment, 
						attch.[Data]
					FROM pbl.Attachment attch
					INNER JOIN req.ManagementHistory ManagementHistory_old ON ManagementHistory_old.ID = attch.ParentID AND ManagementHistory_old.RequestID = @LastRequestID
					INNER JOIN req.ManagementHistory ManagementHistory ON ManagementHistory.FromDate = ManagementHistory_old.FromDate AND ManagementHistory.RequestID = @ID
				END

				IF NOT EXISTS (SELECT TOP 1 1 FROM req.Applicant applicant
					INNER JOIN req.AdmissionRequest req ON req.ID = Applicant.ID
					WHERE req.ID = @ID)
					EXEC req.spCopyDataFromMemaran_ @ID, @ApplicantNationalCode, @Type

			END
			ELSE -- update
				UPDATE req.AdmissionRequest
				SET AgreementType = @AgreementType, AgreementAccepted = @AgreementAccepted
				WHERE ID = @ID

		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END