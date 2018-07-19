--CREATE TRIGGER req.trUpdateExamTest
--ON req.ExamTest
--FOR UPDATE 
--AS
--BEGIN
--	BEGIN TRY
--			INSERT INTO req.ExamTestScoreHistory 
--			SELECT 
--			FROM req.ExamTest examTest
--			INNER JOIN inserted i on examTest.ID = i.ID
--			VALUES(NEWID(), @ExamTestID, @OldRawScore, @OldRawScore / 100, @OldDescriptiveScore, GETDATE())
--		COMMIT
--	END TRY
--	BEGIN CATCH
--		;THROW
--	END CATCH
--END


