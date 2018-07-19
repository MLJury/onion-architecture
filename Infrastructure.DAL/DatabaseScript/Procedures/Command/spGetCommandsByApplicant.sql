USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spGetCommandsByUser'))
	DROP PROCEDURE pbl.spGetCommandsByUser
GO

CREATE PROCEDURE pbl.spGetCommandsByUser
	@AUserID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @UserID UNIQUEIDENTIFIER = @AUserID
			
	select 
		cmd.[Name]
	FROM org.Command cmd
	WHERE (cmd.UserID = @UserID)

	RETURN @@ROWCOUNT
END