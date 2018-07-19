USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spAddFlows'))
	DROP PROCEDURE pbl.spAddFlows
GO

CREATE PROCEDURE pbl.spAddFlows
	@AFlows NVARCHAR(MAX)   -- list of flows in json format
	, @ALog NVARCHAR(MAX)
	, @AResult NVARCHAR(MAX) OUTPUT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @Flows NVARCHAR(MAX) = @AFlows
		  , @Log NVARCHAR(MAX) =  LTRIM(RTRIM(@ALog))
		  , @ID UNIQUEIDENTIFIER
		  , @Date SMALLDATETIME = GETDATE()

	BEGIN TRY
		BEGIN TRAN
			
			DECLARE @LastFLow Table(ID UNIQUEIDENTIFIER, DocumentID UNIQUEIDENTIFIER)

			SELECT *
			INTO #NewFlows
			FROM OPENJSON(@Flows)
			WITH(
				DocumentID UNIQUEIDENTIFIER,
				FromUserID UNIQUEIDENTIFIER,
				FromPositionID UNIQUEIDENTIFIER,
				FromDocState SMALLINT,
				ToPositionID UNIQUEIDENTIFIER,
				ToDocState SMALLINT,
				SendType TINYINT,
				Comment NVARCHAR(4000)
			)

			-- set action date for last flows
			UPDATE pbl.DocumentFlow
			SET ActionDate = GETDATE()
			WHERE ActionDate IS NULL 
				  AND DocumentID IN (SELECT DocumentID FROM #NewFlows)

			-- add new flow
			INSERT INTO pbl.DocumentFlow
			SELECT NEWID() ID
				, newFlow.DocumentID
				, @Date 
				, newFlow.FromPositionID
				, newFlow.FromUserID
				, newFlow.FromDocState
				, newFlow.ToPositionID
				, newFlow.ToDocState
				, newFlow.SendType
				, newFlow.Comment
				, NULL ReadDate
				, NULL ActionDate
			FROM #NewFlows newFlow

			EXEC pbl.spAddLog @Log

		COMMIT

		SET @AResult = '{Date:"' + CONVERT(VARCHAR, @Date, 25) + '"}'

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH

	RETURN @@ROWCOUNT
END