USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifyConditional'))
	DROP PROCEDURE req.spModifyConditional
GO

CREATE PROCEDURE req.spModifyConditional
	@AIsNewRecord BIT,
	@AID uniqueidentifier,
	@AAdmissionID uniqueidentifier,
	@AFirstName nvarchar(255),
	@ALastName nvarchar(255),
	@AFatherName  nvarchar(255),
	@ANationalCode char(10),
	@AExamYear smallint,
	@ATestType1 smallint,
	@ATestType2 smallint,
	@ATestType4 smallint,
	@ATestType8 smallint,
	@ALog NVARCHAR(MAX)

WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @IsNewRecord BIT = ISNULL(@AIsNewRecord, 0),
			@ID uniqueidentifier = @AID,
			@AdmissionID uniqueidentifier = @AAdmissionID,
			@FirstName nvarchar(255) = ltrim(rtrim(@AFirstName)),
			@LastName nvarchar(255) = ltrim(rtrim(@ALastName)),
			@FatherName  nvarchar(255) = ltrim(rtrim(@AFatherName)),
			@NationalCode char(10) = @ANationalCode,
			@ExamYear smallint = @AExamYear,
			@TestType1 smallint = @ATestType1,
			@TestType2 smallint = @ATestType2,
			@TestType4 smallint = @ATestType4,
			@TestType8 smallint = @ATestType8,
			@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog))
	BEGIN TRY
		BEGIN TRAN
			IF @IsNewRecord = 1 -- insert
			BEGIN

				INSERT INTO req.Conditional
				(ID, AdmissionID, FirstName, LastName, FatherName, NationalCode, ExamYear, TestType1, TestType2, TestType4, TestType8)
				VALUES
				(@ID, @AdmissionID, @FirstName, @LastName, @FatherName, @NationalCode, @ExamYear, @TestType1, @TestType2, @TestType4, @TestType8)

			END
			ELSE
			BEGIN
				UPDATE req.Conditional
				SET AdmissionID = @AdmissionID, [FirstName] = @FirstName, [LastName] = @LastName, [FatherName] = @FatherName, [NationalCode] = @NationalCode, [ExamYear] = @ExamYear, [TestType1] = @TestType1, [TestType2] = @TestType2, [TestType4] = @TestType4, [TestType8] = @TestType8 
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