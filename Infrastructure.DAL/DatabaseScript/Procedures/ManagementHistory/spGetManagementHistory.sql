USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetManagementHistory'))
	DROP PROCEDURE req.spGetManagementHistory
GO

CREATE PROCEDURE req.spGetManagementHistory
	@AID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID
		
	SELECT
		mgm.ID,
		mgm.RequestID,
		mgm.OrganizationName,
		mgm.Type,
		mgm.JobTitle,
		mgm.FromDate,
		mgm.ToDate
	FROM req.ManagementHistory mgm
	WHERE (mgm.ID = @ID)

	RETURN @@ROWCOUNT
END