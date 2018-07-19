USE [Kama.Mefa.Azmoon]

IF EXISTS(SELECT 1 FROM sys.views WHERE [object_id] = OBJECT_ID('req._AdmissionRequest'))
	DROP VIEW req._AdmissionRequest
GO

CREATE VIEW req._AdmissionRequest
WITH ENCRYPTION --, SCHEMABINDING
AS
	SELECT TOP 100 PERCENT
		admr.ID 
		, admr.AdmissionID 
		, adm.[Type] AdmissionType
		, adm.Title AdmissionTitle
		, adm.[Year] AdmissionYear
		, admr.ApplicantUserID 
		, doc.CreatorID
		, doc.CreationDate
		, doc.DocumentNumber
		, doc.TrackingCode
		, CAST(COALESCE(lastFlow.ToDocState, 1) AS SMALLINT) LastDocState
		, lastFlow.[Date] LastFlowDate
	FROM req.AdmissionRequest admr
	INNER JOIN adm.Admission adm ON adm.ID = admr.AdmissionID
	INNER JOIN pbl.BaseDocument doc ON doc.ID = admr.ID
	LEFT JOIN pbl.DocumentFlow lastFlow ON lastFlow.DocumentID = admr.ID AND lastFlow.ActionDate IS NULL
	WHERE doc.RemoverID IS NULL
	ORDER BY lastFlow.[Date] DESC