USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spModifyBaseDocument_'))
	DROP PROCEDURE pbl.spModifyBaseDocument_
GO

CREATE PROCEDURE pbl.spModifyBaseDocument_
	  @AIsNewRecord BIT
	, @AID UNIQUEIDENTIFIER
	, @AType TINYINT
	, @ACreatorID UNIQUEIDENTIFIER
	, @ATrackingCode NVARCHAR(50)
	, @ADocumentNumber NVARCHAR(50)
	, @ACreationDate SMALLDATETIME OUTPUT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @IsNewRecord BIT = ISNULL(@AIsNewRecord, 0)
		, @ID UNIQUEIDENTIFIER = @AID
		, @Type TINYINT = @AType
		, @CreatorID UNIQUEIDENTIFIER = @ACreatorID
		, @CreationDate SMALLDATETIME = GETDATE()
		, @TrackingCode NVARCHAR(50) = LTRIM(RTRIM(@ATrackingCode))
		, @DocumentNumber NVARCHAR(50) = LTRIM(RTRIM(@ADocumentNumber))
		, @FromPositionID uniqueidentifier

	IF @Type < 1 
		RETURN -2 --invalid type and creator id
	
	IF @CreatorID IS NULL
		RETURN -3 -- Creator undefined

	SET @FromPositionID = (select ID from org.Positions where UserID = @CreatorID AND [Type] = 20)

	BEGIN TRY
		BEGIN TRAN

			IF @IsNewRecord = 1 -- insert
			BEGIN

				INSERT INTO pbl.BaseDocument
				(ID, [Type], CreatorID, CreationDate, TrackingCode, DocumentNumber, RemoverID, RemoveDate, ConfirmerID, ConfirmDate)
				VALUES
				(@ID, @Type, @CreatorID, @CreationDate, @TrackingCode, @DocumentNumber, NULL, NULL, NULL, NULL)

				INSERT INTO pbl.DocumentFlow
				(ID, DocumentID, [Date], FromPositionID, FromUserID, FromDocState, ToPositionID, ToDocState, SendType, Comment)
				VALUES
				(NEWID(), @ID, GETDATE(), @FromPositionID, @CreatorID, 1, @FromPositionID, 1, 1, N'ثبت اولیه')

				SET @ACreationDate = @CreationDate

			 END
			 ELSE -- update
			 BEGIN
			    
				UPDATE pbl.BaseDocument
				SET DocumentNumber = @DocumentNumber
				WHERE ID = @ID

			 END
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
		
	RETURN @@ROWCOUNT
END