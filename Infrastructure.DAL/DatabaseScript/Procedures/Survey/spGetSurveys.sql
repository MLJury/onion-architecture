USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spGetSurveys'))
	DROP PROCEDURE pbl.spGetSurveys
GO

CREATE PROCEDURE pbl.spGetSurveys
	@AAdmissionID UNIQUEIDENTIFIER
	, @AUserID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @AdmissionID UNIQUEIDENTIFIER = @AAdmissionID
			, @UserID UNIQUEIDENTIFIER = @AUserID
	
	SELECT
		survey.*,
		surveytmp.Title
	FROM pbl.Survey survey
	inner join pbl.SurveyTemplate surveytmp on surveytmp.ID = survey.SurveyTemplateID
	where (surveytmp.AdmissionID = @AdmissionID) 
		AND (survey.CreatorID = @UserID) 

	RETURN @@ROWCOUNT
END