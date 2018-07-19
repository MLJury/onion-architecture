USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spModifyChairNumber'))
	DROP PROCEDURE adm.spModifyChairNumber
GO

CREATE PROCEDURE adm.spModifyChairNumber
	@AAdmissionID UNIQUEIDENTIFIER,
	@AChairNumbers nvarchar(MAX),
	@ACreatorID UNIQUEIDENTIFIER 
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@AdmissionID UNIQUEIDENTIFIER = @AAdmissionID,
		@ChairNumbers nvarchar(MAX) = @AChairNumbers,
		@CreatorID UNIQUEIDENTIFIER = @ACreatorID 

	BEGIN TRY
		BEGIN TRAN

		DELETE FROM adm.ChairNumber WHERE AdmissionID = @AdmissionID

		INSERT INTO adm.ChairNumber
		SELECT
			NEWID() ID 
			, AdmissionID 
			, TestType
			, [Order]
			, FromChairNumber
			, ToChairNumber
			, GETDATE()
		FROM OPENJSON(@ChairNumbers)
		WITH( 
			AdmissionID UNIQUEIDENTIFIER,
			TestType TINYINT,
			[Order] INT,
			FromChairNumber INT,
			ToChairNumber INT
		)

		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END