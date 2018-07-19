USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spGetAttachments'))
	DROP PROCEDURE pbl.spGetAttachments
GO

CREATE PROCEDURE pbl.spGetAttachments
	@AParentID UNIQUEIDENTIFIER,
	@AType TINYINT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ParentID UNIQUEIDENTIFIER = @AParentID,
		@Type TINYINT = COALESCE(@AType, 0)
	
	SELECT ID
		, ParentID  
		, [Type]
		, [FileName]
		, Comment
	FROM pbl.Attachment
	WHERE ParentID = @ParentID
		AND (@Type < 1 OR [Type] = @Type)

	RETURN @@ROWCOUNT
END