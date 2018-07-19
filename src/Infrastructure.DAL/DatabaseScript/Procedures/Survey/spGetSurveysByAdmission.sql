USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spGetSurveysByAdmission'))
	DROP PROCEDURE pbl.spGetSurveysByAdmission
GO

CREATE PROCEDURE pbl.spGetSurveysByAdmission
	@AAdmissionID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @AdmissionID UNIQUEIDENTIFIER = @AAdmissionID
	
	SELECT
		survey.*,
		surveytmp.Title
	FROM pbl.Survey survey
	inner join pbl.SurveyTemplate surveytmp on surveytmp.ID = survey.SurveyTemplateID
	where (surveytmp.AdmissionID = @AdmissionID) 

	RETURN @@ROWCOUNT
END