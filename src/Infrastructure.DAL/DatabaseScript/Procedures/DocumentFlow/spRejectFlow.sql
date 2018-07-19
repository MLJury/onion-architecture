USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spRejectFlow'))
	DROP PROCEDURE pbl.spRejectFlow
GO

CREATE PROCEDURE pbl.spRejectFlow
	@ADocumentID UNIQUEIDENTIFIER
  , @AFromUserID UNIQUEIDENTIFIER
  , @AFromPositionID UNIQUEIDENTIFIER
  , @AComment NVARCHAR(4000)
  , @ALog NVARCHAR(MAX)
  , @AResult NVARCHAR(MAX) OUTPUT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @DocumentID UNIQUEIDENTIFIER = @ADocumentID
		  , @FromPositionID UNIQUEIDENTIFIER = @AFromPositionID
		  , @FromUserID UNIQUEIDENTIFIER = @AFromUserID
		  , @Comment NVARCHAR(4000) =  LTRIM(RTRIM(@AComment))
		  , @Log NVARCHAR(MAX) =  LTRIM(RTRIM(@ALog))
	      , @ID UNIQUEIDENTIFIER
		  , @LastFlowID UNIQUEIDENTIFIER
		  , @LastFromPositionID UNIQUEIDENTIFIER
		  , @LastToPositionID UNIQUEIDENTIFIER
		  , @LastFromDocState TINYINT
		  , @LastToDocState TINYINT
		  , @SendType TINYINT = 3   -- باگشت پرونده
		  , @Date SMALLDATETIME = GETDATE()

	IF @DocumentID IS NULL
		RETURN -2  -- داکیونت وجود ندارد

	IF @Comment = '' SET @Comment = NULL

	SELECT TOP(1)
		   @LastFlowID = ID
		   , @LastFromPositionID = FromPositionID
		   , @LastToPositionID = ToPositionID
		   , @LastFromDocState = FromDocState
		   , @LastToDocState = ToDocState
	FROM pbl.DocumentFlow
	WHERE DocumentID = @DocumentID
	ORDER BY [Date] DESC

	IF @FromPositionID <> @LastToPositionID
		RETURN -3  -- داکیونت در دست این شخص نیست

	BEGIN TRY
		BEGIN TRAN
			SET @ID  = NEWID()

			INSERT INTO pbl.DocumentFlow
			(ID, DocumentID, [Date], FromPositionID, FromUserID, FromDocState, ToPositionID, ToDocState, SendType, Comment)
			VALUES
			(@ID, @DocumentID, @Date, @FromPositionID, @FromUserID, @LastToDocState, @LastFromPositionID, @LastFromDocState, @SendType, @Comment)

			-- set action date for last flow
			UPDATE pbl.DocumentFlow
			SET ActionDate = GETDATE()
			WHERE ID = @LastFlowID

			EXEC pbl.spAddLog @Log
		COMMIT

		SET @AResult = '{Date:"' + CONVERT(VARCHAR, @Date, 25) + '"}'
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH

	RETURN @@ROWCOUNT
END