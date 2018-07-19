USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spGetDocumentStatistics'))
	DROP PROCEDURE pbl.spGetDocumentStatistics
GO

CREATE PROCEDURE pbl.spGetDocumentStatistics
	@AUserPositionID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @UserPositionID UNIQUEIDENTIFIER = @AUserPositionID

	;WITH CTE (DocumentType)
	AS 
	(
		SELECT DISTINCT [Type] DocumentType FROM pbl.BaseDocument
	)
	SELECT CTE.DocumentType, 
		(SELECT count(*) FROM pbl.DocumentFlow flow
						INNER JOIN pbl.BaseDocument doc ON doc.ID = flow.DocumentID
						where flow.ActionDate IS NULL
							AND doc.[Type] = CTE.DocumentType
							AND flow.ToPositionID = @UserPositionID) InActionCount,
		(SELECT count(*) FROM pbl.DocumentFlow flow
						INNER JOIN pbl.BaseDocument doc ON doc.ID = flow.DocumentID
						where flow.ReadDate IS NULL
							AND flow.ActionDate IS NULL
							AND doc.[Type] = CTE.DocumentType
							AND flow.ToPositionID = @UserPositionID) UnReadCount
	FROM CTE
END