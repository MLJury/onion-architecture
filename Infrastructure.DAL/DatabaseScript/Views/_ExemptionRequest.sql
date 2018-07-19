USE [Kama.Mefa.Azmoon]

IF EXISTS(SELECT 1 FROM sys.views WHERE [object_id] = OBJECT_ID('req._ExemptionRequest'))
	DROP VIEW req._ExemptionRequest
GO

CREATE VIEW req._ExemptionRequest
WITH ENCRYPTION --, SCHEMABINDING
AS
	SELECT TOP 100 PERCENT
		exmpr.ID	
		, exmpr.PanelProceedingsNumber
		, exmpr.PanelProceedingsDate
		, adm.[Type] AdmissionType
		, adm.Title AdmissionTitle
		, adm.[Year] AdmissionYear 
		, admr.AdmissionID 
		, admr.ApplicantUserID 
		, admr.AgreementAccepted 
		, admr.AgreementType
		, opn.SecretaryConfirmType
		, doc.CreatorID
		, doc.CreationDate
		, doc.DocumentNumber
		, doc.TrackingCode
		, applicant.[Address]
		, lastFlow.ID LastFlowID
		, lastFlow.SendType LastSendType
		, CAST(COALESCE(lastFlow.ToDocState, 1) AS SMALLINT) LastDocState
		, lastFlow.[Date] LastFlowDate
		, lastFlow.ReadDate LastReadDate
		, lastFlow.FromUserID LastFromUserID 
		, lastFlow.ToPositionID LastToPositionID
	FROM req.ExemptionRequest exmpr
	INNER JOIN req.AdmissionRequest admr ON admr.ID = exmpr.ID
	INNER JOIN pbl.BaseDocument doc ON doc.ID = admr.ID
	INNER JOIN adm.Admission adm ON adm.ID = admr.AdmissionID
	INNER JOIN req.Opinion opn ON opn.AdmissionRequestID = exmpr.ID
	LEFT JOIN req.Applicant applicant ON admr.ID = applicant.ID
	INNER JOIN pbl.DocumentFlow lastFlow ON lastFlow.DocumentID = admr.ID AND lastFlow.ActionDate IS NULL
	WHERE doc.RemoverID IS NULL
	ORDER BY lastFlow.[Date] DESC