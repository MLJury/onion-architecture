USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spDeleteAdmission'))
	DROP PROCEDURE adm.spDeleteAdmission
GO

CREATE PROCEDURE adm.spDeleteAdmission
	@AID UNIQUEIDENTIFIER,
	@ARemoverID UNIQUEIDENTIFIER,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID,
			@RemoverID UNIQUEIDENTIFIER = @ARemoverID, 
		    @Log NVARCHAR(MAX)

				
	IF @ID IS NULL
		RETURN -2 -- ‘‰«”Â ‰«„⁄ »— «” 

	BEGIN TRY
		BEGIN TRAN

			DELETE 
			FROM adm.ChairNumber
			WHERE  AdmissionID = @ID

			DELETE 
			FROM adm.Quorum
			WHERE ExamAdmissionID = @ID

			DELETE 
			FROM adm.ExamAdmission 
			WHERE  ID = @ID

			DELETE 
			FROM adm.ExemptionAdmission 
			WHERE  ID = @ID
			
			DELETE 
			FROM adm.Admission 
			WHERE  ID = @ID

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END