USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spGetAttachmentsByParentIDs'))
	DROP PROCEDURE pbl.spGetAttachmentsByParentIDs
GO

CREATE PROCEDURE pbl.spGetAttachmentsByParentIDs
	@AParentIDs nvarchar(4000)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ParentIDs nvarchar(4000) = @AParentIDs

	select
	attachment.ID,
	attachment.[FileName],
	attachment.ParentID,
	attachment.[Type],
	attachment.Comment
	from pbl.Attachment attachment
	where ParentID in (SELECT jsonResult.[value]
					FROM OPENJSON(@ParentIDs) AS jsonResult)

	RETURN @@ROWCOUNT
END