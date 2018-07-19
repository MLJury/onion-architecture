USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetWorkExperiences'))
	DROP PROCEDURE req.spGetWorkExperiences
GO

CREATE PROCEDURE req.spGetWorkExperiences
	@ARequestID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @RequestID UNIQUEIDENTIFIER = @ARequestID 

	SELECT
		work.ID,
		work.RequestID,
		work.WorkExperienceType,
		work.CountryType,
		work.WorkPlaceID,
		COALESCE(work.WorkPlaceName, workPlace.[Name]) WorkPlaceName,
		work.JobTitle,
		work.FromDate,
		work.ToDate,
		work.InsuranceNumber,
		work.InsuranceWorkCode,
		work.TaxScopeCode,
		work.WorkActivityType,
		work.TotalWorkExperience,
		work.InCountryWorkExperience,
		work.RelatedWorkExperience,
		work.IrrelevantWorkExperience,
		work.WorkPlaceGovernmentalType,
		work.WorkPlaceGovernmental
	FROM req.WorkExperience work
	LEFT JOIN pbl.WorkPlace workPlace On workPlace.ID = work.WorkPlaceID
	WHERE work.RequestID = @RequestID
	ORDER BY FromDate ASC 

	RETURN @@ROWCOUNT
END