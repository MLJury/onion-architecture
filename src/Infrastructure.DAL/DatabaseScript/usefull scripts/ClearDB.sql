use [Kama.Mefa.Azmoon]


delete [Kama.Mefa.Organization].org.[Position] WHERE Type = 1000 AND ApplicationID = '67E63B1D-E423-46CC-ADB2-2D6A46226141'
delete [Kama.Mefa.Organization].org.[User] WHERE ID NOT IN (SELECT UserID FROM [Kama.Mefa.Organization].org.[Position])

delete req.ProfessionalDegree
delete req.WorkExperience
delete req.ManagementHistory
delete req.EducationDegree
delete pbl.Attachment

delete req.Objection
delete req.Opinion
DELETE req.Inquiry
delete req.Interview
delete req.Reason
delete req.ExamTestScoreHistory
delete req.ExamTest
delete req.Applicant
delete req.ExamRequest
delete req.ExemptionRequest
delete req.AdmissionRequest

delete pbl.DocumentFlow
delete pbl.BaseDocument

--delete adm.ChairNumber
--delete adm.Deprived
--delete adm.DivisionOfLabor
--delete adm.Quorum
--delete adm.ExamAdmission
--delete adm.ExemptionAdmission
--delete pbl.Survey
--delete pbl.SurveyTemplate
--delete adm.Admission
