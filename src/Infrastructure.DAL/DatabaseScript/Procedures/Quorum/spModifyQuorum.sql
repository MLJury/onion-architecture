USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spModifyQuorum'))
	DROP PROCEDURE adm.spModifyQuorum
GO

CREATE PROCEDURE adm.spModifyQuorum
	@AID UNIQUEIDENTIFIER,
	@ATestQuorum INT,
	@ADescriptiveQuorum INT,
	@ATotalQuorum INT,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID
		, @TestQuorum INT = @ATestQuorum
		, @DescriptiveQuorum INT = @ADescriptiveQuorum
		, @TotalQuorum INT = @ATotalQuorum
		, @Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog))
		, @LastExamAdmissionID UNIQUEIDENTIFIER

	BEGIN TRY
		BEGIN TRAN
			
			UPDATE [adm].[Quorum]
			SET [TestQuorum] = @TestQuorum, [DescriptiveQuorum] = @DescriptiveQuorum, [TotalQuorum] = @TotalQuorum
			WHERE ID = @ID

			EXEC pbl.spAddLog @Log

		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END