USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spSetInquiryState'))
	DROP PROCEDURE req.spSetInquiryState
GO

CREATE PROCEDURE req.spSetInquiryState
	@AID UNIQUEIDENTIFIER,
	@AState TINYINT,
	@ADate SMALLDATETIME,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE  @ID UNIQUEIDENTIFIER = @AID,
		@State TINYINT = coalesce(@AState, 0) ,
		@Date SMALLDATETIME = coalesce(@ADate, 0) ,
		@Log NVARCHAR(MAX) = @ALog

	BEGIN TRY
		BEGIN TRAN

			update req.Inquiry 
			set [State] = @State
			where ID = @ID

			IF @State = 3
				Update req.Inquiry
				SET SendDate = @Date
				WHERE ID = @ID 

			IF @State in (4, 5)
				Update req.Inquiry
				SET ReceivedDate = @Date
				WHERE ID = @ID 

		EXEC pbl.spAddLog @Log

		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END