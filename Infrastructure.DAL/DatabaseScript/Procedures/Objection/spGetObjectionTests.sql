USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetObjectionTests'))
	DROP PROCEDURE req.spGetObjectionTests
GO

CREATE PROCEDURE req.spGetObjectionTests
	@AObjectionID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ObjectionID UNIQUEIDENTIFIER = @AObjectionID


	SELECT 
		objTests.ID,
		objTests.ObjectionID,
		objTests.ApplicantComment,
		objTests.ExpertComment,
		objTests.SecretaryComment,
		objTests.Result,
		objTests.ExamTestID,
		objTests.NewTestRawScore,
		objTests.NewDescriptiveScore,
		objTests.IsObjected,
		examTest.[Type], 
		examTest.ExamRequestID,
		examTest.[State],
		examTest.ConditionalAdmissionYear,
		examTest.TestRawScore,
		examTest.TestScore,
		examTest.DescriptiveScore,
		examTest.TotalScore,
		examTest.TestResult,
		examTest.TotalResult
	FROM req.ObjectionTest objTests
	inner join req.Objection obj on obj.ID = objTests.ObjectionID
	left join req.ExamTest examTest on examTest.ID = objTests.ExamTestID
	WHERE (objTests.ObjectionID = @ObjectionID)
	order by examTest.[Type]

	RETURN @@ROWCOUNT
END