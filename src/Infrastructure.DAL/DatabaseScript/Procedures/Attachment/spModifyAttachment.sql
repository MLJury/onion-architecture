USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spModifyAttachment'))
	DROP PROCEDURE pbl.spModifyAttachment
GO

CREATE PROCEDURE pbl.spModifyAttachment
	@AIsNewRecord BIT,
	@AID UNIQUEIDENTIFIER,
	@AParentID UNIQUEIDENTIFIER,
	@AType TINYINT,
	@AFileName NVARCHAR(256),
	@AComment NVARCHAR(256),
	@AData VARBINARY(MAX),
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @IsNewRecord BIT = ISNULL(@AIsNewRecord, 0)
		  , @ID UNIQUEIDENTIFIER = @AID
		  , @ParentID UNIQUEIDENTIFIER = @AParentID
		  , @Type TINYINT = COALESCE(@AType, 0)
		  , @FileName NVARCHAR(256) = LTRIM(RTRIM(@AFileName))
		  , @Comment NVARCHAR(256) = LTRIM(RTRIM(@AComment))
		  , @Data VARBINARY(MAX) = @AData
		  , @Log NVARCHAR(MAX)

	IF @ParentID IS NULL
		THROW 50000, N'شناسه پدر مشخص نشده است', 1

	IF @FileName IS NULL OR @FileName = ''
		THROW 50000, N'نام فایل مشخص نشده است', 1

	IF DATALENGTH(@Data) < 1
		THROW 50000, N'فایل بارگذاری نشده است', 1

	BEGIN TRY
		BEGIN TRAN
			IF @IsNewRecord = 1 -- insert
			BEGIN

				INSERT INTO pbl.Attachment
				(ID, ParentID, [Type], [FileName], [Data])
				VALUES
				(@ID, @ParentID, @Type, @FileName, @Data)

			END
			ELSE
			BEGIN
				SET @ParentID = (SELECT ParentID FROM pbl.Attachment WHERE ID = @ID)

				UPDATE pbl.Attachment
				SET [FileName] = @FileName, [Data] = @Data
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