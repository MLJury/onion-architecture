USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifyPayment'))
	DROP PROCEDURE req.spModifyPayment
GO

CREATE PROCEDURE req.spModifyPayment
	@AIsNewRecord BIT,
	@AID UNIQUEIDENTIFIER,
	@AAdmissionRequestID UNIQUEIDENTIFIER,
	@AAmount INT,
	@ATransactionDate DATETIME,
	@ATransactionResult TINYINT,
	@ARefID UNIQUEIDENTIFIER,
	@ASaleReferenceID BIGINT,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@IsNewRecord BIT = @AIsNewRecord,
		@ID UNIQUEIDENTIFIER = @AID,
		@AdmissionRequestID UNIQUEIDENTIFIER = @AAdmissionRequestID,
		@Amount INT = @AAmount,
		@TransactionDate DATETIME = @ATransactionDate,
		@TransactionResult TINYINT = @ATransactionResult,
		@RefID UNIQUEIDENTIFIER = @ARefID,
		@SaleReferenceID BIGINT = @ASaleReferenceID,
		@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog)),
		@OrderID BIGINT

	BEGIN TRY
		BEGIN TRAN
			
			IF @IsNewRecord = 1 -- insert
			BEGIN
	
				-- Create sequence for code 
				IF NOT EXISTS(SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'pbl.sqPaymentOrderID') AND type = 'SO')
				CREATE SEQUENCE pbl.sqPaymentOrderID 
					AS bigint
					START WITH 1100000
					INCREMENT BY 1
				SET @OrderID = NEXT VALUE FOR pbl.sqPaymentOrderID

				INSERT INTO [req].[Payment]
					([ID], [AdmissionRequestID], [OrderID], [Amount], [CreationDate], [TransactionDate], [TransactionResult])
				VALUES
					(@ID, @AdmissionRequestID, @OrderID, @Amount, GETDATE(), NULL, 0)
			END
			ELSE
			BEGIN
				
				IF @ID IS NULL
					SET @ID = (SELECT ID FROM [req].[Payment] WHERE OrderID = @OrderID)

				UPDATE [req].[Payment]
				SET [TransactionDate] = @TransactionDate, TransactionResult= @TransactionResult, RefID = @RefID, SaleReferenceID = @SaleReferenceID 
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