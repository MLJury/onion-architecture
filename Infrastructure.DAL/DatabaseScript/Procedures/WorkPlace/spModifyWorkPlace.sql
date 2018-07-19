USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spModifyWorkPlace'))
	DROP PROCEDURE pbl.spModifyWorkPlace
GO

CREATE PROCEDURE pbl.spModifyWorkPlace
	@AIsNewRecord BIT,
	@AID UNIQUEIDENTIFIER,
	@AName NVARCHAR(200),
	@AType TINYINT,
	@ANameNeeded BIT,
	@AEnable BIT,
	@AOrder INT,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @IsNewRecord BIT = ISNULL(@AIsNewRecord, 0),
			@ID UNIQUEIDENTIFIER = @AID,
			@Name NVARCHAR(200) = LTRIM(RTRIM(@AName)),
			@Type TINYINT = COALESCE(@AType , 0),
			@NameNeeded BIT = COALESCE(@ANameNeeded , 0),
			@Enable BIT = @AEnable,
			@Order INT = @AOrder,
			@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog)),
			@Code VARCHAR(10)

	-- Create sequence for code 
	IF NOT EXISTS(SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'pbl.sqWorkPlaceCode') AND type = 'SO')
	CREATE SEQUENCE pbl.sqWorkPlaceCode 
		AS bigint
		START WITH 2000
		INCREMENT BY 1
	SET @Code = CAST(NEXT VALUE FOR pbl.sqWorkPlaceCode AS VARCHAR(10))

	BEGIN TRY
		BEGIN TRAN
			
			IF @IsNewRecord = 1 -- insert
			BEGIN
				INSERT INTO [pbl].[WorkPlace]
					([ID], [Code], [Name], [Type], NameNeeded, [Enable], [Order])
				VALUES
					(@ID, @Code, @Name, @Type, @NameNeeded, @Enable, @Order)
			END
			ELSE
			BEGIN
				UPDATE [pbl].[WorkPlace]
				SET [Name] = @Name, [Type] = @Type, NameNeeded = @NameNeeded, [Enable] = @Enable, [Order] = @Order
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