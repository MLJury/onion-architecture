USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spModifyManagementHistory'))
	DROP PROCEDURE req.spModifyManagementHistory
GO

CREATE PROCEDURE req.spModifyManagementHistory
	@AIsNewRecord BIT,
	@AID UNIQUEIDENTIFIER,
	@ARequestID UNIQUEIDENTIFIER,
	@AOrganizationName NVARCHAR(1000),
	@AType TINYINT,
	@AJobTitle NVARCHAR(200),
	@AFromDate SMALLDATETIME,
	@AToDate SMALLDATETIME,
	@ALog NVARCHAR(MAX)

WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @IsNewRecord BIT = ISNULL(@AIsNewRecord, 0),
		@ID UNIQUEIDENTIFIER = @AID,
		@RequestID UNIQUEIDENTIFIER = @ARequestID,
		@OrganizationName NVARCHAR(1000) = LTRIM(RTRIM(@AOrganizationName)),
		@Type TINYINT = COALESCE(@AType, 0),
		@JobTitle NVARCHAR(200) = LTRIM(RTRIM(@AJobTitle)),
		@FromDate SMALLDATETIME = @AFromDate,
		@ToDate SMALLDATETIME = @AToDate,
		@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog))

	BEGIN TRY
		BEGIN TRAN
			
			IF @IsNewRecord = 1 -- insert
			BEGIN
				INSERT INTO req.ManagementHistory
					(ID, RequestID, OrganizationName, Type, JobTitle, FromDate, ToDate, [ReadOnly])
				VALUES
					(@ID, @RequestID, @OrganizationName, @Type, @JobTitle, @FromDate, @ToDate, 0)
			END
			ELSE
			BEGIN
				UPDATE req.ManagementHistory
				SET RequestID = @RequestID, OrganizationName = @OrganizationName, Type = @Type, JobTitle = @JobTitle, FromDate = @FromDate, ToDate = @ToDate
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