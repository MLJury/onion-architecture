USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spModifyAbsentsList'))
	DROP PROCEDURE adm.spModifyAbsentsList
GO

CREATE PROCEDURE adm.spModifyAbsentsList
	@AExamAdmissionID uniqueidentifier,
	@AExamExcelList NVARCHAR(MAX), 
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@ExamAdmissionID uniqueidentifier = @AExamAdmissionID,
		@ExamExcelList NVARCHAR(MAX) = LTRIM(RTRIM(@AExamExcelList)),
		@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog))

	BEGIN TRY
		BEGIN TRAN
			
			Update et
			SET et.TestRawScore = lst.TestRawScore
				, TestScore = lst.TestRawScore / 100
			FROM req.ExamTest et 
			INNER JOIN req.AdmissionRequest ar ON ar.ID = et.ExamRequestID
			INNER JOIN org.[Users] usr On usr.ID = ar.ApplicantUserID
			INNER JOIN OPENJSON(@ExamExcelList) 
				WITH
				(
					ApplicantNationalCode CHAR(10) ,
					TestType TINYINT,
					TestRawScore DECIMAL
				)lst ON lst.ApplicantNationalCode = usr.NationalCode
			WHERE lst.TestType = et.[Type]
				AND ar.AdmissionID = @ExamAdmissionID

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END