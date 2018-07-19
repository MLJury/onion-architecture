USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetApplicant'))
	DROP PROCEDURE req.spGetApplicant
GO

CREATE PROCEDURE req.spGetApplicant
	@AID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID
		
	SELECT applicant.ID,
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
		AddressProvince.Name AddressProvinceName,
		applicant.AddressCountyID,
		AddressCounty.Name AddressCountyName,
		applicant.AddressCityID,
		AddressCity.Name AddressCityName,
		applicant.PostalCode,
		applicant.Address,
		applicant.WorkProvinceID,
		WorkProvince.Name WorkProvinceName,
		applicant.WorkCountyID,
		WorkCounty.Name WorkCountyName,
		applicant.WorkCityID,
		WorkCity.Name WorkCityName,
		applicant.WorkAddress,
		applicant.WorkPostalCode,
		applicant.WorkTel,
		applicant.MilitaryServiceType,
		applicant.MilitaryServiceStartDate,
		applicant.MilitaryServiceEndDate,
		applicant.TaaminPassword
	FROM req.Applicant applicant
	INNER JOIN req.AdmissionRequest req ON req.ID = applicant.ID
	INNER JOIN org.Users usr ON usr.ID = req.ApplicantUserID
	LEFT JOIN pbl.Places AddressProvince ON AddressProvince.ID = applicant.AddressProvinceID
	LEFT JOIN pbl.Places AddressCounty ON AddressCounty.ID = applicant.AddressCountyID
	LEFT JOIN pbl.Places AddressCity ON AddressCity.ID = applicant.AddressCityID
	LEFT JOIN pbl.Places WorkProvince ON WorkProvince.ID = applicant.WorkProvinceID
	LEFT JOIN pbl.Places WorkCounty ON WorkCounty.ID = applicant.WorkCountyID
	LEFT JOIN pbl.Places WorkCity ON WorkCity.ID = applicant.WorkCityID
	WHERE applicant.ID = @ID

	RETURN @@ROWCOUNT
END