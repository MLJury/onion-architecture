USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spGetSurveyTemplate'))
	DROP PROCEDURE pbl.spGetSurveyTemplate
GO

CREATE PROCEDURE pbl.spGetSurveyTemplate
	@AID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID
	
	SELECT
		SurveyTmp.*
	FROM pbl.SurveyTemplate SurveyTmp
	where (SurveyTmp.ID = @ID)

	RETURN @@ROWCOUNT
END