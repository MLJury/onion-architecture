USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spGetFlows'))
	DROP PROCEDURE pbl.spGetFlows
GO

CREATE PROCEDURE pbl.spGetFlows
	@ADocumentID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @DocumentID UNIQUEIDENTIFIER = @ADocumentID 
	
	SELECT
		flow.ID,
		flow.DocumentID,
		flow.FromPositionID,
		flow.FromUserID,
		fromUser.FirstName + ' ' + fromUser.LastName FromUserFullName,
		toUser.FirstName + ' ' + toUser.LastName ToUserFullName,
		fromPosition.[Type] FromUserPositionType,
		toPosition.[Type] ToUserPositionType,
		flow.ReadDate,
		flow.FromDocState,
		flow.ToDocState,
		flow.SendType,
		flow.[Date],
		flow.ActionDate,
		flow.Comment
	FROM pbl.DocumentFlow flow
	LEFT JOIN org.Users fromUser ON fromUser.ID = flow.FromUserID
	LEFT JOIN org.Positions fromPosition ON fromPosition.ID = flow.FromPositionID
	LEFT JOIN org.Positions toPosition ON toPosition.ID = flow.ToPositionID
	LEFT JOIN org.Users toUser ON toUser.ID = toPosition.UserID
	WHERE (flow.DocumentID = @DocumentID)
	ORDER BY [Date] 

	RETURN @@RowCount

END
