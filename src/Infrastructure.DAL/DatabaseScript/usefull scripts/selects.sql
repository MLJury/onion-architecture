USE [Kama.Mefa.Azmoon]

SELECT * FROM  req.ProfessionalDegree
SELECT * FROM  req.WorkExperience
SELECT * FROM  req.ManagementHistory
SELECT * FROM  req.EducationDegree
SELECT * FROM  pbl.Attachment

SELECT * FROM  req.Objection
SELECT * FROM  req.Opinion
SELECT * FROM  req.Interview
SELECT * FROM  req.Reason
SELECT * FROM  req.ExamTestScoreHistory
SELECT * FROM  req.ExamTest where ExamRequestID = 'DDE84FD6-E250-47FC-A145-675DBFA51944'
SELECT * FROM  req.Applicant
SELECT * FROM  req.ExamRequest
SELECT * FROM  req.ExemptionRequest
SELECT * FROM  req.AdmissionRequest

SELECT * FROM  pbl.DocumentFlow order by date desc
SELECT * FROM  pbl.BaseDocument

SELECT * FROM  adm.ChairNumber
SELECT * FROM  adm.Deprived
SELECT * FROM  adm.DivisionOfLabor
SELECT * FROM  adm.Quorum
SELECT * FROM  adm.ExamAdmission
SELECT * FROM  adm.ExemptionAdmission
SELECT * FROM  pbl.Survey
SELECT * FROM  pbl.SurveyTemplate
SELECT * FROM  adm.Admission

select * from req.conditional where NationalCode = '0059359013'