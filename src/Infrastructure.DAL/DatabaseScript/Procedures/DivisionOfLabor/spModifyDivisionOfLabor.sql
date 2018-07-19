USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spModifyDivisionOfLabor'))
	DROP PROCEDURE adm.spModifyDivisionOfLabor
GO

CREATE PROCEDURE adm.spModifyDivisionOfLabor
	@AIsNewRecord BIT,
	@AID UNIQUEIDENTIFIER,
	@APositionID UNIQUEIDENTIFIER,
	@AFromLetterType TINYINT,
	@AToLetterType TINYINT,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @IsNewRecord BIT = ISNULL(@AIsNewRecord, 0),
		@ID UNIQUEIDENTIFIER = @AID,
		@PositionID UNIQUEIDENTIFIER = @APositionID,
		@FromLetterType TINYINT = @AFromLetterType,
		@ToLetterType TINYINT = @AToLetterType,
		@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog))

	BEGIN TRY
		BEGIN TRAN
			
			IF @IsNewRecord = 1 -- insert
			BEGIN
				SET @ID = NEWID()

				INSERT INTO adm.DivisionOfLabor
					(ID, PositionID, FromLetterType, ToLetterType)
				VALUES
					(@ID, @PositionID, @FromLetterType, @ToLetterType)
			END
			ELSE 			 -- update
			BEGIN
				UPDATE adm.DivisionOfLabor
				SET PositionID = @PositionID, FromLetterType = @FromLetterType, ToLetterType = @ToLetterType
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