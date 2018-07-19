USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spGetQuorum'))
	DROP PROCEDURE adm.spGetQuorum
GO

CREATE PROCEDURE adm.spGetQuorum
	@AID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID
		
	SELECT 
		q.ID	
		, q.ExamAdmissionID
		, q.TestType
		, q.TestQuorum
		, q.DescriptiveQuorum
		, q.TotalQuorum
	FROM adm.Quorum q
	WHERE q.ID = @ID

	RETURN @@ROWCOUNT
END