USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spDeleteLastFlow_'))
	DROP PROCEDURE pbl.spDeleteLastFlow_
GO

CREATE PROCEDURE pbl.spDeleteLastFlow_
	@ADocumentID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @DocumentID UNIQUEIDENTIFIER = @ADocumentID

	IF @DocumentID IS NULL
		RETURN -2  -- وضعیت تایید مشخص نشده است

	BEGIN TRY
		BEGIN TRAN
			
			-- delete Last flow
			delete pbl.DocumentFlow where DocumentID = @DocumentID AND ActionDate IS NULL
			UPDATE pbl.DocumentFlow SET ActionDate = NULL WHERE ID = (SELECT TOP 1 ID FROM pbl.DocumentFlow WHERE DocumentID = @DocumentID ORDER BY [Date] DESC)


		COMMIT

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH

END