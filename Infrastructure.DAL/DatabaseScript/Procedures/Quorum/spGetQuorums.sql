USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spGetQuorums'))
	DROP PROCEDURE adm.spGetQuorums
GO

CREATE PROCEDURE adm.spGetQuorums
	@AExamAdmissionID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ExamAdmissionID UNIQUEIDENTIFIER = @AExamAdmissionID 

	SELECT 
		q.ID	
		, q.ExamAdmissionID
		, q.TestType
		, q.TestQuorum
		, q.DescriptiveQuorum
		, q.TotalQuorum
	FROM adm.Quorum q
	WHERE q.ExamAdmissionID = @ExamAdmissionID
	ORDER BY TestType

	RETURN @@ROWCOUNT
END