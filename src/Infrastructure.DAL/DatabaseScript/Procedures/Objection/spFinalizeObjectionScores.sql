USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spFinalizeObjectionScores'))
	DROP PROCEDURE req.spFinalizeObjectionScores
GO

CREATE PROCEDURE req.spFinalizeObjectionScores
	@AObjectionID uniqueidentifier,
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ObjectionID UNIQUEIDENTIFIER = @AObjectionID,
			@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog))
	
	BEGIN TRY
		BEGIN TRAN
			-- Create History for changed score
			insert into req.ExamTestScoreHistory (ID , ExamTestID, TestRawScore, TestScore, DescriptiveScore, CreationDate, [Type])
			select 
				NEWID()
				, examTest.ID
				, examTest.TestRawScore
				, examTest.TestScore
				, examTest.DescriptiveScore
				, GETDATE()
				, 1
			from req.Objection objection
			inner join req.ObjectionTest objTests on objTests.ObjectionID = objection.ID
			inner join req.ExamTest examTest on examTest.ID = objTests.ExamTestID
			where objection.ID = @ObjectionID and objTests.Result = 1 

			--update examTest changed scores
			update examTest set TestRawScore = objTests.NewTestRawScore
								, TestScore = coalesce(objTests.NewTestRawScore, TestRawScore) / 100
								, DescriptiveScore = coalesce(objTests.NewDescriptiveScore, DescriptiveScore)
								, TotalScore = ((coalesce(objTests.NewTestRawScore, TestRawScore) / 100) + coalesce(objTests.NewDescriptiveScore, DescriptiveScore)) / 2
			from req.Objection objection
			inner join req.ObjectionTest objTests on objTests.ObjectionID = objection.ID
			inner join req.ExamTest examTest on examTest.ID = objTests.ExamTestID
			where objection.ID = @ObjectionID and objTests.Result = 1
			
			--update objection examTest approved Final Result
			update examTest set TotalResult = 1
			from req.Objection objection
			inner join req.ObjectionTest objTests on objTests.ObjectionID = objection.ID
			inner join req.ExamTest examTest on examTest.ID = objTests.ExamTestID
			inner join req.AdmissionRequest admr on admr.ID = objection.AdmissionRequestID
			inner join adm.Quorum quorum on quorum.ExamAdmissionID = admr.AdmissionID And (TestType = examTest.[Type])
			where objection.ID = @ObjectionID 
					AND objTests.Result = 1
					AND examTest.TestResult >= quorum.TestQuorum 
					AND examTest.DescriptiveScore >= quorum.DescriptiveQuorum
					AND examTest.TotalScore >= quorum.TotalQuorum

			--update objection examTest failed Final Result
			update examTest set TotalResult = 2
			from req.Objection objection
			inner join req.ObjectionTest objTests on objTests.ObjectionID = objection.ID
			inner join req.ExamTest examTest on examTest.ID = objTests.ExamTestID
			inner join req.AdmissionRequest admr on admr.ID = objection.AdmissionRequestID
			inner join adm.Quorum quorum on quorum.ExamAdmissionID = admr.AdmissionID And (TestType = examTest.[Type])
			where objection.ID = @ObjectionID 
					AND objTests.Result = 1
					AND (examTest.TestScore < quorum.TestQuorum 
						OR examTest.DescriptiveScore < quorum.DescriptiveQuorum
						OR examTest.TotalScore < quorum.TotalQuorum)

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END