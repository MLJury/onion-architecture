USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifyApplicant'))
	DROP PROCEDURE req.spModifyApplicant
GO

CREATE PROCEDURE req.spModifyApplicant
	@AID UNIQUEIDENTIFIER,
	@AGender TINYINT,
	@ABirthDate SMALLDATETIME,
	@ATel VARCHAR(20),
	@ABCNumber VARCHAR(10),
	@ABCSerial NVARCHAR(10),
	@ABCSeries VARCHAR(5),
	@ABCLetter nvarchar(3),
	@AIssuancePlace NVARCHAR(200),
	@AFatherName NVARCHAR(200),
	@AReligion TINYINT,
	@AFaith TINYINT,
	@AAddressProvinceID UNIQUEIDENTIFIER,
	@AAddressCountyID UNIQUEIDENTIFIER,
	@AAddressCityID UNIQUEIDENTIFIER,
	@APostalCode CHAR(10),
	@AAddress NVARCHAR(1000),
	@AWorkProvinceID UNIQUEIDENTIFIER,
	@AWorkCountyID UNIQUEIDENTIFIER,
	@AWorkCityID UNIQUEIDENTIFIER,
	@AWorkAddress NVARCHAR(1000),
	@AWorkPostalCode VARCHAR(10),
	@AWorkTel VARCHAR(20),
	@AMilitaryServiceType TINYINT,
	@AMilitaryServiceStartDate SMALLDATETIME,
	@AMilitaryServiceEndDate SMALLDATETIME,
	@ATaaminPassword NVARCHAR(100),
	@AFirstName nvarchar(50),
	@ALastName nvarchar(100),
	@AEmail varchar(256),
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID,
		@Gender TINYINT = COALESCE(@AGender, 0),
		@BirthDate SMALLDATETIME = @ABirthDate,
		@Tel VARCHAR(20) = LTRIM(RTRIM(@ATel)),
		@BCNumber VARCHAR(10) = LTRIM(RTRIM(@ABCNumber)),
		@BCSerial NVARCHAR(10) = LTRIM(RTRIM(@ABCSerial)),
		@BCSeries VARCHAR(5) = LTRIM(RTRIM(@ABCSeries)),
		@BCLetter nvarchar(3) = LTRIM(RTRIM(@ABCLetter)),
		@IssuancePlace NVARCHAR(200) = LTRIM(RTRIM(@AIssuancePlace)),
		@FatherName NVARCHAR(200) = LTRIM(RTRIM(@AFatherName)),
		@Religion TINYINT = COALESCE(@AReligion, 0),
		@Faith TINYINT = COALESCE(@AFaith, 0),
		@AddressProvinceID UNIQUEIDENTIFIER = @AAddressProvinceID,
		@AddressCountyID UNIQUEIDENTIFIER = @AAddressCountyID,
		@AddressCityID UNIQUEIDENTIFIER = @AAddressCityID,
		@PostalCode CHAR(10) = LTRIM(RTRIM(@APostalCode)),
		@Address NVARCHAR(1000) = LTRIM(RTRIM(@AAddress)),
		@WorkProvinceID UNIQUEIDENTIFIER = @AWorkProvinceID,
		@WorkCountyID UNIQUEIDENTIFIER = @AWorkCountyID,
		@WorkCityID UNIQUEIDENTIFIER = @AWorkCityID,
		@WorkAddress NVARCHAR(1000) = LTRIM(RTRIM(@AWorkAddress)),
		@WorkPostalCode VARCHAR(10) = @AWorkPostalCode,
		@WorkTel VARCHAR(20) = LTRIM(RTRIM(@AWorkTel)),
		@MilitaryServiceType TINYINT = COALESCE(@AMilitaryServiceType, 0),
		@MilitaryServiceStartDate SMALLDATETIME = @AMilitaryServiceStartDate,
		@MilitaryServiceEndDate SMALLDATETIME = @AMilitaryServiceEndDate,
		@TaaminPassword NVARCHAR(100) = ltrim(rtrim(@ATaaminPassword)),
		@FirstName nvarchar(50) = ltrim(rtrim(@AFirstName)),
		@LastName nvarchar(100) = ltrim(rtrim(@ALastName)),
		@Email varchar(256) = ltrim(rtrim(@AEmail)),
		@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog))

	BEGIN TRY
		BEGIN TRAN
			IF NOT EXISTS(SELECT 1 FROM req.Applicant WHERE ID = @ID) -- insert
			BEGIN
				INSERT INTO req.Applicant
					(ID, Gender, BirthDate, Tel, BCNumber, BCSerial, BCSeries, BCLetter, IssuancePlace, FatherName, Religion, Faith, AddressProvinceID, AddressCountyID, AddressCityID, PostalCode, Address, WorkProvinceID, WorkCountyID, WorkCityID, WorkAddress, WorkPostalCode, WorkTel, MilitaryServiceType, MilitaryServiceStartDate, MilitaryServiceEndDate, TaaminPassword)
				VALUES
					(@ID, @Gender, @BirthDate, @Tel, @BCNumber, @BCSerial, @BCSeries, @BCLetter, @IssuancePlace, @FatherName, @Religion, @Faith, @AddressProvinceID, @AddressCountyID, @AddressCityID, @PostalCode, @Address, @WorkProvinceID, @WorkCountyID, @WorkCityID, @WorkAddress, @WorkPostalCode, @WorkTel, @MilitaryServiceType, @MilitaryServiceStartDate, @MilitaryServiceEndDate, @TaaminPassword)
			END
			ELSE
			BEGIN
				UPDATE req.Applicant
				SET Gender = @Gender, BirthDate = @BirthDate, Tel = @Tel, BCNumber = @BCNumber, BCSerial = @BCSerial, BCSeries = @BCSeries, BCLetter = @BCLetter, IssuancePlace = @IssuancePlace, FatherName = @FatherName, Religion = @Religion, Faith = @Faith, AddressProvinceID = @AddressProvinceID, AddressCountyID = @AddressCountyID, AddressCityID = @AddressCityID, PostalCode = @PostalCode, Address = @Address, WorkProvinceID = @WorkProvinceID, WorkCountyID = @WorkCountyID, WorkCityID = @WorkCityID, WorkAddress = @WorkAddress, WorkPostalCode = @WorkPostalCode, WorkTel = @WorkTel, MilitaryServiceType = @MilitaryServiceType, MilitaryServiceStartDate = @MilitaryServiceStartDate, MilitaryServiceEndDate = @MilitaryServiceEndDate, TaaminPassword = @TaaminPassword
				WHERE ID = @ID

				UPDATE ORG.Users
				SET FirstName = @FirstName, LastName = @LastName, Email = @Email
				WHERE ID = (select ApplicantUserID from req.AdmissionRequest where ID = @ID)
			END

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END