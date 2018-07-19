USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spDeleteProfessionalDegree'))
	DROP PROCEDURE req.spDeleteProfessionalDegree
GO

CREATE PROCEDURE req.spDeleteProfessionalDegree
	@AID UNIQUEIDENTIFIER,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID,
		    @Log NVARCHAR(MAX)
			, @ExamRequestID UNIQUEIDENTIFIER

				
	IF @ID IS NULL
		RETURN -2 -- شناسه نامعتبر است

	BEGIN TRY
		BEGIN TRAN
			
			DELETE FROM req.ProfessionalDegree
			WHERE ID = @ID

			SET @ExamRequestID = (SELECT ExamRequestID FROM req.ExamTest WHERE ID = @ID )
			EXEC req.spUpdateExamTestState_ @AExamRequestID = @ExamRequestID     -- جهت مشخص کردن وضعیت مشروطین و معافین (از آزمون حسابداری و حسابرسی)

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END