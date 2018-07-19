USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spModifyUniversity'))
	DROP PROCEDURE pbl.spModifyUniversity
GO

CREATE PROCEDURE pbl.spModifyUniversity
	@AIsNewRecord BIT,
	@AID UNIQUEIDENTIFIER,
	@AName NVARCHAR(200),
	@AType TINYINT,
	@AEnable BIT,
	@AOrder INT,
	@AIsInternal BIT,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @IsNewRecord BIT = ISNULL(@AIsNewRecord, 0),
			@ID UNIQUEIDENTIFIER = @AID,
			@Name NVARCHAR(200) = LTRIM(RTRIM(@AName)),
			@Type TINYINT = COALESCE(@AType, 0),
			@Enable BIT = @AEnable,
			@Order INT = @AOrder,
			@IsInternal BIT = COALESCE(@AIsInternal, 0),
			@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog)),
			@Code VARCHAR(10)

	-- Create sequence for code 
	IF NOT EXISTS(SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'pbl.sqUniversityCode') AND type = 'SO')
	CREATE SEQUENCE pbl.sqUniversityCode 
		AS bigint
		START WITH 2010
		INCREMENT BY 1
	SET @Code = CAST(NEXT VALUE FOR pbl.sqUniversityCode AS VARCHAR(10))

	BEGIN TRY
		BEGIN TRAN
			
			IF @IsNewRecord = 1 -- insert
			BEGIN
				INSERT INTO [pbl].[University]
					([ID], [Code], [Name], [Type], [Enable], [Order], IsInternal)
				VALUES
					(@ID, @Code, @Name, @Type, @Enable, @Order, @IsInternal)
			END
			ELSE
			BEGIN
				UPDATE [pbl].[University]
				SET [Name] = @Name, [Type] = @Type, [Enable] = @Enable, [Order] = @Order, IsInternal = @IsInternal
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