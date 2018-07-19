USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetApplicants'))
	DROP PROCEDURE req.spGetApplicants
GO

CREATE PROCEDURE req.spGetApplicants
	@AType TINYINT,
	@AAdmissionID Uniqueidentifier,
	@ANationalCode varchar(11),
	@AFirstName nvarchar(50),
	@ALastName nvarchar(50),
	@AEmail nvarchar(50),
	@ATel nvarchar(50),
	@ABCNumber nvarchar(50),
	@AFatherName nvarchar(50),
	@APageSize INT,
	@APageIndex INT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @Type TINYINT = coalesce(@AType, 0) 
			, @AdmissionID Uniqueidentifier = @AAdmissionID
			, @NationalCode varchar(11) = ltrim(rtrim(@ANationalCode))
			, @FirstName nvarchar(50) = ltrim(rtrim(@AFirstName))
			, @LastName nvarchar(50) = ltrim(rtrim(@ALastName))
			, @Email nvarchar(50) = ltrim(rtrim(@AEmail))
			, @Tel nvarchar(50) = ltrim(rtrim(@ATel))
			, @BCNumber nvarchar(50) = ltrim(rtrim(@ABCNumber))
			, @FatherName nvarchar(50) = ltrim(rtrim(@AFatherName))
			, @PageSize INT = COALESCE(@APageSize, 10)
			, @PageIndex INT = COALESCE(@APageIndex, 0)
		

	IF @PageIndex = 0 
	BEGIN
		SET @pagesize = 10000000
		SET @PageIndex = 1
	END

	SELECT 
		Count(*) OVER() Total,
		applicant.ID,
		usr.NationalCode,
		usr.FirstName,
		usr.LastName,
		usr.CellPhone,
		usr.CellPhoneVerified,
		usr.Email,
		usr.EmailVerified,
		usr.Username,
		applicant.Gender,
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
		AddressProvince.[Name] AddressProvinceName,
		applicant.AddressCountyID,
		AddressCounty.[Name] AddressCountyName,
		applicant.AddressCityID,
		AddressCity.[Name] AddressCityName,
		applicant.PostalCode,
		applicant.[Address],
		applicant.WorkProvinceID,
		WorkProvince.[Name] WorkProvinceName,
		applicant.WorkCountyID,
		WorkCounty.[Name] WorkCountyName,
		applicant.WorkCityID,
		WorkCity.[Name] WorkCityName,
		applicant.WorkAddress,
		applicant.WorkPostalCode,
		applicant.WorkTel,
		applicant.MilitaryServiceType,
		applicant.MilitaryServiceStartDate,
		applicant.MilitaryServiceEndDate
	FROM req.Applicant applicant
	INNER JOIN req.AdmissionRequest req ON req.ID = applicant.ID
	INNER JOIN org.Users usr ON usr.ID = req.ApplicantUserID
	INNER JOIN pbl.Places AddressProvince ON AddressProvince.ID = applicant.AddressProvinceID
	INNER JOIN pbl.Places AddressCounty ON AddressCounty.ID = applicant.AddressCountyID
	INNER JOIN pbl.Places AddressCity ON AddressCity.ID = applicant.AddressCityID
	INNER JOIN pbl.Places WorkProvince ON WorkProvince.ID = applicant.WorkProvinceID
	INNER JOIN pbl.Places WorkCounty ON WorkCounty.ID = applicant.WorkCountyID
	INNER JOIN pbl.Places WorkCity ON WorkCity.ID = applicant.WorkCityID
	LEFT JOIN req.ExamRequest exr ON exr.ID = req.ID
	LEFT JOIN req.ExemptionRequest exmr ON exmr.ID = req.ID
	LEFT JOIN pbl.BaseDocument examBaseDocument ON examBaseDocument.ID = exr.ID
	WHERE (req.AdmissionID = @AdmissionID) 
		AND (@NationalCode is null or usr.NationalCode = @NationalCode) 
		AND (@FirstName is null or usr.FirstName like concat(N'%', @FirstName, N'%'))
		AND (@LastName is null or usr.NationalCode like concat(N'%', @NationalCode, N'%'))
		AND (@FatherName is null or applicant.FatherName like  CONCAT(N'%', @FatherName, N'%'))
		AND (@Type < 1 
				or @Type = 1 and exr.ID is not null 
				or @Type = 2 and exmr.ID is not null 
				or (@Type = 3 and exists(select * from pbl.DocumentFlow where DocumentID = examBaseDocument.ID and ToDocState = 100 and ActionDate is null))
				or (@Type = 4 and exists(select * from pbl.DocumentFlow where DocumentID = examBaseDocument.ID and ToDocState = 210 and ActionDate is null))
				or (@Type = 5 and exists(select * from req.ExamTest ext where ext.ExamRequestID = exr.ID and ext.State = 3))
				or (@Type = 6 and exists(select * from pbl.DocumentFlow where DocumentID = examBaseDocument.ID and ToDocState = 5 and ActionDate is null))
				or (@Type = 7 and exists(select * from pbl.DocumentFlow where DocumentID = examBaseDocument.ID and ToDocState = 40 and ActionDate is null))
				or (@Type = 8 and exists(select * from req.ExamTest ext where ext.ExamRequestID = exr.ID and ext.TotalResult = 1))
				or (@Type = 9 and exists(select * from req.ExamTest ext where ext.ExamRequestID = exr.ID and ext.TotalResult = 2)))
		ORDER BY usr.LastName, usr.FirstName
		OFFSET ((@PageIndex - 1) * @PageSize) ROWS FETCH NEXT @PageSize ROWS ONLY;
	RETURN @@ROWCOUNT
END