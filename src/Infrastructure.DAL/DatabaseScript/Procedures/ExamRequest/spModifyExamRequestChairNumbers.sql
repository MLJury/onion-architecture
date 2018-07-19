USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifyExamRequestChairNumbers'))
	DROP PROCEDURE req.spModifyExamRequestChairNumbers
GO

CREATE PROCEDURE req.spModifyExamRequestChairNumbers
	@AExamAdmissionID UNIQUEIDENTIFIER,
	@AChairNumbers NVARCHAR(4000),
	@AUserID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@ExamAdmissionID UNIQUEIDENTIFIER = @AExamAdmissionID,
		@ChairNumbers nvarchar(4000) = @AChairNumbers,
		@UserID UNIQUEIDENTIFIER = @AUserID 

	BEGIN TRY
		BEGIN TRAN

		UPDATE ExamRequest 
		SET ChairNumber = jsonResult.ChairNumber
		FROM req.ExamRequest INNER JOIN OPENJSON(@ChairNumbers)
		WITH(
			ID UNIQUEIDENTIFIER,
			ChairNumber INT
		) AS jsonResult ON ExamRequest.ID = jsonResult.ID

		UPDATE ChairNumber
		SET FromChairNumber = (SELECT MIN(ChairNumber) FROM req.ExamRequest exr INNER JOIN req.AdmissionRequest req ON exr.ID = req.ID WHERE exr.DemandedTestType = ChairNumber.TestType AND req.AdmissionID = @ExamAdmissionID)
			, ToChairNumber = (SELECT MAX(ChairNumber) FROM req.ExamRequest exr INNER JOIN req.AdmissionRequest req ON exr.ID = req.ID WHERE exr.DemandedTestType = ChairNumber.TestType AND req.AdmissionID = @ExamAdmissionID)
		FROM adm.ChairNumber ChairNumber
		WHERE AdmissionID = @ExamAdmissionID 

		UPDATE adm.ExamAdmission
		SET LastChairNumberAllocationUserID = @UserID 
		WHERE ID = @ExamAdmissionID 

		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END