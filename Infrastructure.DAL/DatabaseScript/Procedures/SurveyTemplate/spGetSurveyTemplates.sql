USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spGetSurveyTemplates'))
	DROP PROCEDURE pbl.spGetSurveyTemplates
GO

CREATE PROCEDURE pbl.spGetSurveyTemplates
	@AAdmissionID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @AdmissionID UNIQUEIDENTIFIER = @AAdmissionID
	
	SELECT
		surveyTmp.*
	FROM pbl.SurveyTemplate surveyTmp
	where (surveyTmp.AdmissionID = @AdmissionID)
		and (surveyTmp.IsRemoved is null)

	RETURN @@ROWCOUNT
END