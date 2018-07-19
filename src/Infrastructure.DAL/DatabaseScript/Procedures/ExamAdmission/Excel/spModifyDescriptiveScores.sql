USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('adm.spModifyDescriptiveScores'))
	DROP PROCEDURE adm.spModifyDescriptiveScores
GO

CREATE PROCEDURE adm.spModifyDescriptiveScores
	@AExamAdmissionID uniqueidentifier,
	@AExamExcelList NVARCHAR(MAX), 
	@ALog NVARCHAR(MAX)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@ExamAdmissionID uniqueidentifier = @AExamAdmissionID,
		@ExamExcelList NVARCHAR(MAX) = LTRIM(RTRIM(@AExamExcelList)),
		@Log NVARCHAR(MAX) = LTRIM(RTRIM(@ALog)),
		@StringfiedFlows NVARCHAR(MAX),
		@FlowResult NVARCHAR(MAX)

	BEGIN TRY
		BEGIN TRAN
			------------------------------------------ ثبت نتایج آزمون تشریحی و کل 
			Update et
			SET et.DescriptiveScore = lst.DescriptiveScore
				, et.TotalScore = lst.TotalScore
			FROM req.ExamTest et 
			INNER JOIN req.AdmissionRequest ar ON ar.ID = et.ExamRequestID
			INNER JOIN org.[Users] usr On usr.ID = ar.ApplicantUserID
			INNER JOIN OPENJSON(@ExamExcelList) 
				WITH
				(
					ApplicantNationalCode CHAR(10),
					TestType TINYINT,
					DescriptiveScore DECIMAL,
					TotalScore DECIMAL
				)lst ON lst.ApplicantNationalCode = usr.NationalCode
			WHERE lst.TestType = et.[Type]
				AND ar.AdmissionID = @ExamAdmissionID

			------------------------------------------ تعیین قبولی در کل آزمون بر اساس نصاب ها
			Update et
			SET TotalResult = 1
			FROM req.ExamTest et
			INNER JOIN req.AdmissionRequest ar ON ar.ID = et.ExamRequestID
			INNER JOIN adm.Quorum qr ON qr.TestType = et.[Type] AND ar.AdmissionID = ar.AdmissionID
			WHERE ar.AdmissionID = @ExamAdmissionID
			AND ar.AdmissionID = @ExamAdmissionID
			AND COALESCE(TotalScore, 0) >= qr.TotalQuorum

			------------------------------------------ ارسال قبول شده ها به مرحله استعلام
			set @StringfiedFlows = (select 
									lastFlow.DocumentID,
									pbl.EmptyGuid() FromUserID,
									lastFlow.FromPositionID,
									lastFlow.FromDocState,
									dbo.fnGetPositionIDByApplicantLastName([user].LastName) ToPositionID,
									50 ToDocState, 
									1 SendType,
									N'ارسال قبول شدگان اعتراض به مرجله استعلام' Comment 
									from req.AdmissionRequest admissionRequest 
									inner join org.Users [user] on [user].ID = admissionRequest.ApplicantUserID
									inner join pbl.DocumentFlow lastFlow on lastFlow.DocumentID = admissionRequest.ID and lastFlow.ActionDate is null
									where NOT EXISTS (SELECT 1 FROM req.ExamTest ExamTest WHERE admissionRequest.ID = examTest.ExamRequestID AND ExamTest.State = 1 AND examTest.TotalResult <> 1)
										AND admissionRequest.AdmissionID = @ExamAdmissionID 
									FOR JSON AUTO)

			EXECUTE pbl.spAddFlows @StringfiedFlows, @Log, @FlowResult
			------------------------------------------ ارسال قبول شده ها به مرحله تکمیل سوابق کاری
			set @StringfiedFlows = (select 
						lastFlow.DocumentID,
						pbl.EmptyGuid() FromUserID,
						lastFlow.FromPositionID,
						lastFlow.FromDocState,
						dbo.fnGetPositionIDByApplicantLastName([user].LastName) ToPositionID,
						50 ToDocState, 
						1 SendType,
						N'ارسال قبول شده ها به مرحله تکمیل سوابق کاری' Comment 
						from req.ExamTest examTest
						inner join req.AdmissionRequest admissionRequest on admissionRequest.ID = examTest.ExamRequestID
						inner join org.Users [user] on [user].ID = admissionRequest.ApplicantUserID
						inner join pbl.DocumentFlow lastFlow on lastFlow.DocumentID = examTest.ExamRequestID and lastFlow.ActionDate is null
						where examTest.TotalResult = 1 AND admissionRequest.AdmissionID = @ExamAdmissionID 
						FOR JSON AUTO)

			EXECUTE pbl.spAddFlows @StringfiedFlows, @Log, @FlowResult
			------------------------------------------ ارسال قبول نشده ها به مرحله عدم قبولی
			set @StringfiedFlows = (select 
									lastFlow.DocumentID,
									pbl.EmptyGuid() FromUserID,
									lastFlow.FromPositionID,
									lastFlow.FromDocState,
									dbo.fnGetPositionIDByApplicantLastName([user].LastName) ToPositionID,
									220 ToDocState, 
									1 SendType,
									N'ارسال قبول نشده ها به مرحله عدم قبولی' Comment 
									from req.ExamTest examTest
									inner join req.AdmissionRequest admissionRequest on admissionRequest.ID = examTest.ExamRequestID
									inner join org.Users [user] on [user].ID = admissionRequest.ApplicantUserID 
									inner join pbl.DocumentFlow lastFlow on lastFlow.DocumentID = examTest.ExamRequestID and lastFlow.ActionDate is null
									where examTest.TotalResult = 2 AND admissionRequest.AdmissionID = @ExamAdmissionID 
									FOR JSON AUTO)

			EXECUTE pbl.spAddFlows @StringfiedFlows, @Log, @FlowResult

			EXEC pbl.spAddLog @Log
		COMMIT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
	
	RETURN @@ROWCOUNT
END