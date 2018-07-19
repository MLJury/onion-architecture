USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spUpdateExamTestState_'))
	DROP PROCEDURE req.spUpdateExamTestState_
GO

CREATE PROCEDURE req.spUpdateExamTestState_
	@AExamRequestID UNIQUEIDENTIFIER

WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ExamRequestID UNIQUEIDENTIFIER = @AExamRequestID
		, @AdmissionID UNIQUEIDENTIFIER
		, @ApplicantUserID UNIQUEIDENTIFIER
		, @Year SMALLINT
		, @ConditionalYears TINYINT
		, @LastState SMALLINT

	BEGIN TRY
		BEGIN TRAN
			
			SET @LastState = (SELECT TOP 1 ToDocState FROM pbl.DocumentFlow WHERE DocumentID = @ExamRequestID AND ActionDate IS NULL)

			-- مشخص کردن وضعیت معافیت از آزمون های حسابداری و حسابرسی
			IF @LastState = 40  -- شرکت در آزمون
				AND (EXISTS(SELECT 1 FROM req.ProfessionalDegree WHERE RequestID = @ExamRequestID)
					   OR EXISTS(SELECT 1 
								 FROM req.EducationDegree ed
								 INNER JOIN pbl.EducationField ef ON ef.ID = ed.EducationFieldID
								 WHERE ed.RequestID = @ExamRequestID
									   AND ed.Grade = 6  -- دکتری حسابداری
									   AND ef.EducationFieldType = 2   -- حسابداری یا حسابرسی
								)
					)
				UPDATE req.ExamTest
				SET [State] = 2
				WHERE ExamRequestID = @ExamRequestID AND [Type] IN (1,2)

			-- مشخص کردن وضعیت مشروط بودن
			SET @AdmissionID = (SELECT AdmissionID FROM req.AdmissionRequest WHERE ID = @ExamRequestID)
			SET @ApplicantUserID = (SELECT ApplicantUserID FROM req.AdmissionRequest WHERE ID = @ExamRequestID)
			SET @Year = (SELECT [Year] FROM adm.Admission WHERE ID = @AdmissionID)
			--SET @ConditionalYears = (SELECT ConditionalYears FROM adm.ExamAdmission adm where ID = @AdmissionID)

			-- بروز رسانی وضعیت مشروطین به شکل اتوماتیک - از سال 98 اعمال شود
			--UPDATE ExamTest
			--SET ConditionalAdmissionYear = (SELECT adm.[Year] 
			--									FROM req.ExamTest et 
			--									INNER JOIN req.AdmissionRequest admr ON et.ExamRequestID = admr.ID 
			--									INNER JOIN adm.Admission adm ON admr.AdmissionID = adm.ID
			--									WHERE et.[Type] = ExamTest.[Type]
			--											AND admr.ApplicantUserID = @ApplicantUserID 
			--											AND et.TotalResult = 1
			--											AND @Year - adm.[Year] < @ConditionalYears)
			--FROM req.ExamTest ExamTest
			--WHERE ExamRequestID = @ExamRequestID

			--UPDATE req.ExamTest 
			--SET [State] = 3
			--WHERE ConditionalAdmissionYear IS NOT NULL
			--		AND ExamRequestID = @ExamRequestID

			UPDATE ExamTest 
			SET ExamTest.[State] = 3
				, ExamTest.ConditionalAdmissionYear = Conditional.TestType1
			FROM req.ExamTest 
			INNER JOIN req.AdmissionRequest ON AdmissionRequest.ID = ExamTest.ExamRequestID
			INNER JOIN adm.Admission ON Admission.ID = AdmissionRequest.AdmissionID
			INNER JOIN org.Users usr ON usr.ID = AdmissionRequest.ApplicantUserID
			INNER JOIN req.Conditional ON Conditional.NationalCode =  usr.NationalCode
			WHERE Admission.ID = Conditional.AdmissionID
				AND (Conditional.TestType1 IS NOT NULL AND ExamTest.[Type] = 1)
				AND AdmissionRequest.ID = @ExamRequestID

			UPDATE ExamTest 
			SET ExamTest.[State] = 3
				, ExamTest.ConditionalAdmissionYear = Conditional.TestType2
			FROM req.ExamTest 
			INNER JOIN req.AdmissionRequest ON AdmissionRequest.ID = ExamTest.ExamRequestID
			INNER JOIN adm.Admission ON Admission.ID = AdmissionRequest.AdmissionID
			INNER JOIN org.Users usr ON usr.ID = AdmissionRequest.ApplicantUserID
			INNER JOIN req.Conditional ON Conditional.NationalCode =  usr.NationalCode
			WHERE Admission.ID = Conditional.AdmissionID
				AND (Conditional.TestType2 IS NOT NULL AND ExamTest.[Type] = 2)
				AND AdmissionRequest.ID = @ExamRequestID

			UPDATE ExamTest 
			SET ExamTest.[State] = 3
				, ExamTest.ConditionalAdmissionYear = Conditional.TestType4
			FROM req.ExamTest 
			INNER JOIN req.AdmissionRequest ON AdmissionRequest.ID = ExamTest.ExamRequestID
			INNER JOIN adm.Admission ON Admission.ID = AdmissionRequest.AdmissionID
			INNER JOIN org.Users usr ON usr.ID = AdmissionRequest.ApplicantUserID
			INNER JOIN req.Conditional ON Conditional.NationalCode =  usr.NationalCode
			WHERE Admission.ID = Conditional.AdmissionID
				AND (Conditional.TestType4 IS NOT NULL AND ExamTest.[Type] = 4)
				AND AdmissionRequest.ID = @ExamRequestID

			UPDATE ExamTest 
			SET ExamTest.[State] = 3
				, ExamTest.ConditionalAdmissionYear = Conditional.TestType8
			FROM req.ExamTest 
			INNER JOIN req.AdmissionRequest ON AdmissionRequest.ID = ExamTest.ExamRequestID
			INNER JOIN adm.Admission ON Admission.ID = AdmissionRequest.AdmissionID
			INNER JOIN org.Users usr ON usr.ID = AdmissionRequest.ApplicantUserID
			INNER JOIN req.Conditional ON Conditional.NationalCode =  usr.NationalCode
			WHERE Admission.ID = Conditional.AdmissionID
				AND (Conditional.TestType8 IS NOT NULL AND ExamTest.[Type] = 8)
				AND AdmissionRequest.ID = @ExamRequestID

			EXEC req.spUpdateDemandedTestType_ @AExamRequestID = @ExamRequestID

		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END