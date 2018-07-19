USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE object_id = OBJECT_ID('adm.spModifyDeprived'))
	DROP PROCEDURE adm.spModifyDeprived
GO

CREATE PROCEDURE adm.spModifyDeprived
	@AIsNewRecord BIT,
	@AID UNIQUEIDENTIFIER,
	@ANationalCode VARCHAR(10),
	@AFirstName NVARCHAR(200),
	@ALastName NVARCHAR(200),
	@AType tinyint,
	@AFromYear smallint,
	@AToYear smallint,
	@AUserID UNIQUEIDENTIFIER,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@IsNewRecord BIT = @AIsNewRecord,
		@ID UNIQUEIDENTIFIER = @AID,
		@NationalCode VARCHAR(10) = LTRIM(RTRIM(@ANationalCode)),
		@FirstName NVARCHAR(200) = LTRIM(RTRIM(@AFirstName)),
		@LastName NVARCHAR(200) = LTRIM(RTRIM(@ALastName)),
		@Type tinyint = @AType,
		@FromYear smallint = @AFromYear,
		@ToYear smallint = @AToYear,
		@UserID UNIQUEIDENTIFIER = @AUserID,
		@Log NVARCHAR(MAX) = @ALog

	--IF EXISTS(SELECT 1 FROM adm.Deprived 
	--			WHERE ApplicantUserID = @ApplicantUserID 
	--				AND ID <> @ID 
	--				AND [Type] = 1 OR ([Type] = 2 AND StartDate < @StartDate))
	-- جلوگیری از داده های تکراری

	BEGIN TRY
		BEGIN TRAN
			IF @IsNewRecord = 1 -- insert
			BEGIN
				INSERT INTO adm.Deprived
					(ID, NationalCode, FirstName, LastName, [Type], FromYear, ToYear, [Enabled], CreatorID, CreationDate)
				VALUES
					(@ID, @NationalCode, @FirstName, @LastName, @Type, @FromYear, @ToYear, 1, @UserID, GETDATE())
			END
			ELSE
			BEGIN
				UPDATE adm.Deprived
				SET NationalCode = @NationalCode, FirstName = @FirstName, LastName = @LastName, [Type] = @Type, FromYear = @FromYear, ToYear = @ToYear
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