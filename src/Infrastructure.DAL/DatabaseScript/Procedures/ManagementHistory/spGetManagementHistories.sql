USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetManagementHistories'))
	DROP PROCEDURE req.spGetManagementHistories
GO

CREATE PROCEDURE req.spGetManagementHistories
	@ARequestID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @RequestID UNIQUEIDENTIFIER = @ARequestID 

	SELECT
		mgm.ID,
		mgm.RequestID,
		mgm.OrganizationName,
		mgm.Type,
		mgm.JobTitle,
		mgm.FromDate,
		mgm.ToDate
	FROM req.ManagementHistory mgm
	WHERE (mgm.RequestID = @RequestID)
	ORDER BY mgm.FromDate

	RETURN @@ROWCOUNT
END