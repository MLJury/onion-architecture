USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spCopyDataFromMemaran_'))
	DROP PROCEDURE req.spCopyDataFromMemaran_
GO

CREATE PROCEDURE req.spCopyDataFromMemaran_
	@ARequestID uniqueidentifier,
	@ANationalCode VARCHAR(10),
	@ARequestType TINYINT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	SET ANSI_WARNINGS OFF;    -- allow truncation

	DECLARE 
		@RequestID UNIQUEIDENTIFIER = @ARequestID,
		@NationalCode VARCHAR(10) = LTRIM(RTRIM(@ANationalCode)),
		@RequestType TINYINT = COALESCE(@ARequestType, 0),
		@PersonRequestID UNIQUEIDENTIFIER

	SET @PersonRequestID = (SELECT Top 1 Code FROM [MEFA_Azmoon].dbo.PersonRequest WHERE LTRIM(RTRIM(NationalCode)) = @NationalCode ORDER BY CreateTime DESC)
	
	IF @PersonRequestID IS NULL  -- اگر مشخصات فرد در سیستم معماران وجود ندارد
		RETURN 0
	
	INSERT INTO req.Applicant
	(ID, Gender, BirthDate, Tel, BCNumber, BCSerial, BCSeries, BCLetter, IssuancePlace, FatherName, Religion, Faith, AddressProvinceID, AddressCountyID, AddressCityID, PostalCode, Address, WorkProvinceID, WorkCountyID, WorkCityID, WorkAddress, WorkPostalCode, WorkTel, MilitaryServiceStartDate, MilitaryServiceEndDate, MilitaryServiceType, [ReadOnly])
	SELECT @ARequestID ID,
		COALESCE(PersonRequest.HCGenderTypeCode, 0) Gender,
		COALESCE(PersonRequest.BirthDate, GETDATE()) BirthDate,
		COALESCE(PersonRequest.HomeTel, '') Tel,
		COALESCE(PersonRequest.IDNumber, '') BCNumber,
		COALESCE(PersonRequest.Serial, '') BCSerial,
		PersonRequest.SerialUnder BCSeries,
		HCBirthCertificateSerialAlphabeticTypes.[Name] BCLetter,
		COALESCE(PersonRequest.BirthCertificatePlaceName, '') IssuancePlace,
		COALESCE(PersonRequest.FatherName, '') FatherName,
		COALESCE(PersonRequest.HCReligionTypeCode, 0) Religion,
		COALESCE(PersonRequest.HCFaithTypeCode, 0) Faith,
		COALESCE(County.ParentCode, pbl.EmptyGuid())AddressProvinceID,
		COALESCE(County.Code, pbl.EmptyGuid()) AddressCountyID,
		COALESCE(City.Code, pbl.EmptyGuid()) AddressCityID,
		COALESCE(PersonRequest.HomePostCode, '') PostalCode,
		COALESCE(PersonRequest.HomeAddress, '') [Address],
		COALESCE(WorkCounty.ParentCode, pbl.EmptyGuid()) WorkProvinceID,
		COALESCE(WorkCounty.Code, pbl.EmptyGuid()) WorkCountyID,
		COALESCE(WorkCity.Code, pbl.EmptyGuid()) WorkCityID,
		COALESCE(PersonRequest.OfficeAddress, '') WorkAddress,
		COALESCE(PersonRequest.OfficePostCode, '') WorkPostalCode,
		COALESCE(PersonRequest.WorkTel, ''),
		PersonRequest.MilitaryServiceStartDate,
		PersonRequest.MilitaryServiceEndDate,
		COALESCE(PersonRequest.HCMilitaryServiceStatusTypeCode, 0) MilitaryServiceType,
		0 [ReadOnly] 
	FROM [MEFA_Azmoon].dbo.PersonRequest
	LEFT JOIN [MEFA_Azmoon].dbo.HCBirthCertificateSerialAlphabeticTypes ON HCBirthCertificateSerialAlphabeticTypes.Code = PersonRequest.HCBirthCertificateSerialAlphabeticTypeCode
	LEFT JOIN  [MEFA_Azmoon].dbo.Zones City ON City.Code = PersonRequest.HomeZoneCode
	LEFT JOIN  [MEFA_Azmoon].dbo.Zones County ON County.Code = City.ParentCode
	LEFT JOIN  [MEFA_Azmoon].dbo.Zones WorkCity ON WorkCity.Code = PersonRequest.OfficeZoneCode
	LEFT JOIN  [MEFA_Azmoon].dbo.Zones WorkCounty ON WorkCounty.Code = WorkCity.ParentCode
	WHERE PersonRequest.Code = @PersonRequestID

	INSERT INTO req.EducationDegree
	(ID, RequestID, Grade, IssuanceCountryType, UniversityID, UniversityName, UniversityUnitName, EducationFieldID, EducationFieldName, GraduateDate, RelatedCurricula, [ReadOnly])
	SELECT
		ed.code ID,
		@ARequestID RequestID,
		COALESCE(ed.HCAcademicDegreeTypeCode, 0) Grade,
		COALESCE(ed.HCCertificateCountryTypeCode, 0) IssuanceCountryType,
		COALESCE((select ID from [kama.mefa.azmoon].pbl.university WHERE code = ed.HCUniversityTypeCode), pbl.EmptyGuid()) UniversityID,
		ed.UniversityName UniversityName,
		ed.UniversityNameAzad UniversityUnitName,
		COALESCE((select ID from [kama.mefa.azmoon].pbl.EducationField WHERE Code = ed.hcprofile_FieldOFStudyTypeCode), pbl.EmptyGuid()) EducationFieldID,
		ed.FieldOFStudy EducationFieldName,
		COALESCE(ed.CertificateDate, GETDATE()) GraduateDate,
		ed.UnitCount RelatedCurricula,
		0 [ReadOnly]
	FROM [Mefa_Azmoon].[dbo].[PersonRequestEducationalRecords] ed
	WHERE ed.PersonRequestCode = @PersonRequestID

	insert into req.ProfessionalDegree
	(ID, RequestID, DegreeType, DegreeTypeName, CountryID, [Date], Number, [ReadOnly])
	SELECT
		degree.Code ID,
		@ARequestID RequestID,
		COALESCE(degree.HCCertificateTypeCode, 0) DegreeType,
		degree.CertificateTypeDescription DegreeTypeName,
		COALESCE(degree.CountryZoneCode, pbl.EmptyGuid()) CountryID,
		COALESCE(degree.CertificateDate, GETDATE()) [Date],
		COALESCE(degree.AnjomanAccountNumber, '') Number,
		0 [ReadOnly]
	FROM [Mefa_Azmoon].[dbo].[PersonRequestProfessionalCertificates] degree
	WHERE degree.PersonRequestCode = @PersonRequestID

	INSERT INTO req.WorkExperience
	(ID, RequestID, WorkExperienceType, CountryType, WorkPlaceID, WorkPlaceName, WorkPlaceGovernmentalType, JobTitle, FromDate, ToDate, InsuranceNumber, InsuranceWorkCode, TaxScopeCode, WorkActivityType, TotalWorkExperience, InCountryWorkExperience, RelatedWorkExperience, IrrelevantWorkExperience, [ReadOnly])
	SELECT
		we.Code ID,
		@ARequestID RequestID,
		COALESCE(we.HCWorkExperienceTypeCode, 0) WorkExperienceType,
		COALESCE(we.HCCountryTypeCode, 0) CountryType,
		COALESCE((select ID from [kama.mefa.azmoon].pbl.WorkPLace WHERE Code = we.HCWorkPlaceTypeCode), pbl.EmptyGuid()) WorkPlaceID,
		we.CompanyName WorkPlaceName,
		0 WorkPlaceGovernmentalType,
		COALESCE(we.Post, '') JobTitle,
		COALESCE(we.InsuranceActivitiesStartDate, GETDATE()) FromDate,
		COALESCE(we.InsuranceActivitiesEndDate, GETDATE()) ToDate,
		we.InsuranceNo InsuranceNumber,
		we.CompanyInsuranceCode InsuranceWorkCode,
		we.InsuranceBranchNo TaxScopeCode,
		we.hcWorkActivityTypeCode WorkActivityType,
		0 TotalWorkExperience,
		0 InCountryWorkExperience,
		0 RelatedWorkExperience,
		0 IrrelevantWorkExperience,
		0 [ReadOnly]
	FROM [Mefa_Azmoon].[dbo].[PersonRequestWorkExperiences] we
	WHERE (we.PersonRequestCode = @PersonRequestID)

	IF @RequestType = 2
	BEGIN
		INSERT INTO req.ManagementHistory
		(ID, RequestID, OrganizationName, [Type], JobTitle, FromDate, ToDate, [ReadOnly])
		SELECT
			mh.Code ID,
			@ARequestID RequestID,
			COALESCE(mh.OrganizationName, ''),
			COALESCE(mh.HCWorkExperienceTypeCode, 0) [Type],
			COALESCE(mh.Post, '') JobTitle,
			COALESCE(mh.StartDate, GETDATE()) FromDate,
			COALESCE(mh.EndDate, GETDATE()) ToDate,
			0 [ReadOnly]
		FROM [Mefa_Azmoon].[dbo].[PersonRequestWorkOrganization] mh
		WHERE (mh.PersonRequestCode = @PersonRequestID)
	END
				
	----   request attachments
	INSERT INTO pbl.Attachment 
	(ID, ParentID, [Type], [FileName], Comment, [Data])
	SELECT 
		NEWID() ID, 
		@RequestID ParentID, 
		1,                          -- تصویر شخص
		[FileName], 
		NULL Comment, 
		[Data]
	FROM [OldAzmoonAttachments].[dbo].[Attachment]
	WHERE [FileName] = (SELECT TOP 1 PictureFileName FROM [Mefa_Azmoon].[dbo].[PersonRequest] where Code = @PersonRequestID) COLLATE SQL_Latin1_General_CP1256_CI_AS

	INSERT INTO pbl.Attachment 
	(ID, ParentID, [Type], [FileName], Comment, [Data])
	SELECT 
		NEWID() ID, 
		@RequestID ParentID, 
		3,                          -- صفحه اول شناسنامه
		[FileName], 
		NULL Comment, 
		[Data]
	FROM [OldAzmoonAttachments].[dbo].[Attachment]
	WHERE [FileName] = (SELECT TOP 1 IDCardPicFileName FROM [Mefa_Azmoon].[dbo].[PersonRequest] where Code = @PersonRequestID) COLLATE SQL_Latin1_General_CP1256_CI_AS

	INSERT INTO pbl.Attachment 
	(ID, ParentID, [Type], [FileName], Comment, [Data])
	SELECT 
		NEWID() ID, 
		@RequestID ParentID, 
		28,                          -- صفحه دوم شناسنامه
		[FileName], 
		NULL Comment, 
		[Data]
	FROM [OldAzmoonAttachments].[dbo].[Attachment]
	WHERE [FileName] = (SELECT TOP 1 IDCardPicFileName FROM [Mefa_Azmoon].[dbo].[PersonRequest] where Code = @PersonRequestID) COLLATE SQL_Latin1_General_CP1256_CI_AS

	INSERT INTO pbl.Attachment 
	(ID, ParentID, [Type], [FileName], Comment, [Data])
	SELECT 
		NEWID() ID, 
		@RequestID ParentID, 
		29,                          -- صفحه توضیحات شناسنامه
		[FileName], 
		NULL Comment, 
		[Data]
	FROM [OldAzmoonAttachments].[dbo].[Attachment]
	WHERE [FileName] = (SELECT TOP 1 IDCardPicFileName FROM [Mefa_Azmoon].[dbo].[PersonRequest] where Code = @PersonRequestID) COLLATE SQL_Latin1_General_CP1256_CI_AS

	INSERT INTO pbl.Attachment 
	(ID, ParentID, [Type], [FileName], Comment, [Data])
	SELECT 
		NEWID() ID, 
		@RequestID ParentID, 
		4,                          -- صفحه روی کارت ملی
		[FileName], 
		NULL Comment, 
		[Data]
	FROM [OldAzmoonAttachments].[dbo].[Attachment]
	WHERE [FileName] = (SELECT TOP 1 NationalCardPicFileName FROM [Mefa_Azmoon].[dbo].[PersonRequest] where Code = @PersonRequestID) COLLATE SQL_Latin1_General_CP1256_CI_AS

	INSERT INTO pbl.Attachment 
	(ID, ParentID, [Type], [FileName], Comment, [Data])
	SELECT 
		NEWID() ID, 
		@RequestID ParentID, 
		26,                          -- صفحه پشت کارت ملی
		[FileName], 
		NULL Comment, 
		[Data]
	FROM [OldAzmoonAttachments].[dbo].[Attachment]
	WHERE [FileName] = (SELECT TOP 1 NationalCardPicFileName FROM [Mefa_Azmoon].[dbo].[PersonRequest] where Code = @PersonRequestID) COLLATE SQL_Latin1_General_CP1256_CI_AS

	INSERT INTO pbl.Attachment 
	(ID, ParentID, [Type], [FileName], Comment, [Data])
	SELECT 
		NEWID() ID, 
		@RequestID ParentID, 
		2,                          -- صفحه روی پایان خدمت
		[FileName], 
		NULL Comment, 
		[Data]
	FROM [OldAzmoonAttachments].[dbo].[Attachment]
	WHERE [FileName] = (SELECT TOP 1 MilitaryServiceStatusFileName FROM [Mefa_Azmoon].[dbo].[PersonRequest] where Code = @PersonRequestID) COLLATE SQL_Latin1_General_CP1256_CI_AS

	INSERT INTO pbl.Attachment 
	(ID, ParentID, [Type], [FileName], Comment, [Data])
	SELECT 
		NEWID() ID, 
		@RequestID ParentID, 
		27,                          -- صفحه پشت پایان خدمت
		[FileName], 
		NULL Comment, 
		[Data]
	FROM [OldAzmoonAttachments].[dbo].[Attachment]
	WHERE [FileName] = (SELECT TOP 1 MilitaryServiceStatusFileName FROM [Mefa_Azmoon].[dbo].[PersonRequest] where Code = @PersonRequestID) COLLATE SQL_Latin1_General_CP1256_CI_AS

	
	
	----   EducationDegree attachments
	INSERT INTO pbl.Attachment 
	(ID, ParentID, [Type], [FileName], Comment, [Data])
	SELECT 
		NEWID() ID, 
		ed.Code ParentID, 
		5,                          -- تصویر مدرک تحصیلی
		attch.[FileName], 
		NULL Comment, 
		attch.[Data]
	FROM [OldAzmoonAttachments].[dbo].[Attachment] attch
	INNER JOIN [Mefa_Azmoon].[dbo].[PersonRequestEducationalRecords] ed ON ed.CertificateFileName = attch.[FileName] COLLATE SQL_Latin1_General_CP1256_CI_AS
	WHERE  ed.PersonRequestCode = @PersonRequestID 

	INSERT INTO pbl.Attachment 
	(ID, ParentID, [Type], [FileName], Comment, [Data])
	SELECT 
		NEWID() ID, 
		ed.Code ParentID, 
		7,                          -- تصویر ترجمه مدرک تحصیلی
		attch.[FileName], 
		NULL Comment, 
		attch.[Data]
	FROM [OldAzmoonAttachments].[dbo].[Attachment] attch
	INNER JOIN [Mefa_Azmoon].[dbo].[PersonRequestEducationalRecords] ed ON ed.CertificateTranslationFileName = attch.[FileName] COLLATE SQL_Latin1_General_CP1256_CI_AS
	WHERE  ed.PersonRequestCode = @PersonRequestID 

	INSERT INTO pbl.Attachment 
	(ID, ParentID, [Type], [FileName], Comment, [Data])
	SELECT 
		NEWID() ID, 
		ed.Code ParentID, 
		8,                          -- تصویر ارزشیابی مدرک تحصیلی
		attch.[FileName], 
		NULL Comment, 
		attch.[Data]
	FROM [OldAzmoonAttachments].[dbo].[Attachment] attch
	INNER JOIN [Mefa_Azmoon].[dbo].[PersonRequestEducationalRecords] ed ON ed.ArzeshyabiFileName = attch.[FileName] COLLATE SQL_Latin1_General_CP1256_CI_AS
	WHERE  ed.PersonRequestCode = @PersonRequestID 

	INSERT INTO pbl.Attachment 
	(ID, ParentID, [Type], [FileName], Comment, [Data])
	SELECT 
		NEWID() ID, 
		ed.Code ParentID, 
		6,                          -- ریزنمرات
		attch.[FileName], 
		NULL Comment, 
		attch.[Data]
	FROM [OldAzmoonAttachments].[dbo].[Attachment] attch
	INNER JOIN [Mefa_Azmoon].[dbo].[PersonRequestEducationalRecords] ed ON ed.NumbersFileName = attch.[FileName] COLLATE SQL_Latin1_General_CP1256_CI_AS
	WHERE  ed.PersonRequestCode = @PersonRequestID 


	
	
	
	
	
	
	
	
	----   ProfessionalDegree attachments
	INSERT INTO pbl.Attachment 
	(ID, ParentID, [Type], [FileName], Comment, [Data])
	SELECT 
		NEWID() ID, 
		degree.Code ParentID, 
		11,                          -- تصویر مدرک حرفه ای
		attch.[FileName], 
		NULL Comment, 
		attch.[Data]
	FROM [OldAzmoonAttachments].[dbo].[Attachment] attch
	INNER JOIN [Mefa_Azmoon].[dbo].[PersonRequestProfessionalCertificates] degree ON degree.[FileName] = attch.[FileName] COLLATE SQL_Latin1_General_CP1256_CI_AS
	WHERE  degree.PersonRequestCode = @PersonRequestID 

	INSERT INTO pbl.Attachment 
	(ID, ParentID, [Type], [FileName], Comment, [Data])
	SELECT 
		NEWID() ID, 
		degree.Code ParentID, 
		12,                          -- تصویر ترجمه مدرک حرفه ای
		attch.[FileName], 
		NULL Comment, 
		attch.[Data]
	FROM [OldAzmoonAttachments].[dbo].[Attachment] attch
	INNER JOIN [Mefa_Azmoon].[dbo].[PersonRequestProfessionalCertificates] degree ON degree.CertificateTranslationFileName = attch.[FileName] COLLATE SQL_Latin1_General_CP1256_CI_AS
	WHERE  degree.PersonRequestCode = @PersonRequestID

	
	
	
	
	
	
	
	
	
	----   WorkExperience attachments
	INSERT INTO pbl.Attachment 
	(ID, ParentID, [Type], [FileName], Comment, [Data])
	SELECT 
		NEWID() ID, 
		we.Code ParentID, 
		10,                          -- سوابق بیمه ای
		attch.[FileName], 
		NULL Comment, 
		attch.[Data]
	FROM [OldAzmoonAttachments].[dbo].[Attachment] attch
	INNER JOIN [Mefa_Azmoon].[dbo].[PersonRequestWorkExperiences] we ON we.SavabeghFileName = attch.[FileName] COLLATE SQL_Latin1_General_CP1256_CI_AS
	WHERE we.PersonRequestCode = @PersonRequestID

	INSERT INTO pbl.Attachment 
	(ID, ParentID, [Type], [FileName], Comment, [Data])
	SELECT 
		NEWID() ID, 
		we.Code ParentID, 
		9,                          -- گواهی سابقه کار
		attch.[FileName], 
		NULL Comment, 
		attch.[Data]
	FROM [OldAzmoonAttachments].[dbo].[Attachment] attch
	INNER JOIN [Mefa_Azmoon].[dbo].[PersonRequestWorkExperiences] we ON we.GovahiFileName = attch.[FileName] COLLATE SQL_Latin1_General_CP1256_CI_AS
	WHERE we.PersonRequestCode = @PersonRequestID










	----   ManagementHistory attachments
	IF @RequestType = 2
	BEGIN
		INSERT INTO pbl.Attachment 
		(ID, ParentID, [Type], [FileName], Comment, [Data])
		SELECT 
			NEWID() ID, 
			mh.Code ParentID, 
			13,                          -- گواهی سابقه کار در دستگاه اجرایی
			attch.[FileName], 
			NULL Comment, 
			attch.[Data]
		FROM [OldAzmoonAttachments].[dbo].[Attachment] attch
		INNER JOIN [Mefa_Azmoon].[dbo].[PersonRequestWorkOrganization] mh ON mh.GovahiFileName = attch.[FileName] COLLATE SQL_Latin1_General_CP1256_CI_AS
		WHERE mh.PersonRequestCode = @PersonRequestID

		INSERT INTO pbl.Attachment 
		(ID, ParentID, [Type], [FileName], Comment, [Data])
		SELECT 
			NEWID() ID, 
			mh.Code ParentID, 
			14,                          -- آخرین حکم صادر شده
			attch.[FileName], 
			NULL Comment, 
			attch.[Data]
		FROM [OldAzmoonAttachments].[dbo].[Attachment] attch
		INNER JOIN [Mefa_Azmoon].[dbo].[PersonRequestWorkOrganization] mh ON mh.HokmFileName = attch.[FileName] COLLATE SQL_Latin1_General_CP1256_CI_AS
		WHERE mh.PersonRequestCode = @PersonRequestID

		INSERT INTO pbl.Attachment 
		(ID, ParentID, [Type], [FileName], Comment, [Data])
		SELECT 
			NEWID() ID, 
			mh.Code ParentID, 
			15,                          -- چارت سازمانی
			attch.[FileName], 
			NULL Comment, 
			attch.[Data]
		FROM [OldAzmoonAttachments].[dbo].[Attachment] attch
		INNER JOIN [Mefa_Azmoon].[dbo].[PersonRequestWorkOrganization] mh ON mh.ChartFileName = attch.[FileName] COLLATE SQL_Latin1_General_CP1256_CI_AS
		WHERE mh.PersonRequestCode = @PersonRequestID


		INSERT INTO pbl.Attachment 
		(ID, ParentID, [Type], [FileName], Comment, [Data])
		SELECT 
			NEWID() ID, 
			mh.Code ParentID, 
			15,                          -- گواهی ضمن خدمت
			attch.[FileName], 
			NULL Comment, 
			attch.[Data]
		FROM [OldAzmoonAttachments].[dbo].[Attachment] attch
		INNER JOIN [Mefa_Azmoon].[dbo].[PersonRequestWorkOrganization] mh ON mh.ZemnKhedmatFileName = attch.[FileName] COLLATE SQL_Latin1_General_CP1256_CI_AS
		WHERE mh.PersonRequestCode = @PersonRequestID
	END

RETURN 1
 
END