USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetWorkExperience'))
	DROP PROCEDURE req.spGetWorkExperience
GO

CREATE PROCEDURE req.spGetWorkExperience
	@AID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID

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
	WHERE (work.ID = @ID)

	RETURN @@ROWCOUNT
END