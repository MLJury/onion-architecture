USE [Kama.Mefa.Azmoon]

IF EXISTS(SELECT 1 FROM sys.views WHERE [object_id] = OBJECT_ID('req._Objection'))
	DROP VIEW req._Objection
GO

CREATE VIEW req._Objection
WITH ENCRYPTION --, SCHEMABINDING
AS
	SELECT TOP 100 PERCENT
		obj.ID	
		, obj.AdmissionRequestID
		, obj.[Type]
		, obj.ApplicantComment
		, obj.ExpertComment
		, obj.SecretaryComment
		, obj.Result
		, obj.SecretaryConfirmType
		, admr.AdmissionID 
		, admr.ApplicantUserID 
		, admr.AgreementAccepted 
		, admr.AgreementType
		, doc.CreatorID
		, doc.CreationDate
		, doc.DocumentNumber
		, doc.RemoveDate
		, doc.TrackingCode
		, lastFlow.ID LastFlowID
		, lastFlow.SendType LastSendType
		, CAST(COALESCE(lastFlow.ToDocState, 1) AS SMALLINT) LastDocState
		, lastFlow.[Date] LastFlowDate
		, lastFlow.ReadDate LastReadDate
		, lastFlow.FromUserID LastFromUserID 
		, lastFlow.ToPositionID LastToPositionID
		, adm.[Type] AdmissionType
		, adm.Title AdmissionTitle
	FROM req.Objection obj 
	INNER JOIN req.AdmissionRequest admr ON admr.ID = obj.AdmissionRequestID
	INNER JOIN adm.Admission adm ON adm.ID = admr.AdmissionID
	INNER JOIN pbl.BaseDocument doc ON doc.ID = obj.ID
	LEFT JOIN pbl.DocumentFlow lastFlow ON lastFlow.DocumentID = obj.ID AND lastFlow.ActionDate IS NULL
	WHERE doc.RemoverID IS NULL
	ORDER BY lastFlow.[Date] DESC