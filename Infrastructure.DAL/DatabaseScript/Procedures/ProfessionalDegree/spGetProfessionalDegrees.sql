USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetProfessionalDegrees'))
	DROP PROCEDURE req.spGetProfessionalDegrees
GO

CREATE PROCEDURE req.spGetProfessionalDegrees
	@ARequestID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @RequestID UNIQUEIDENTIFIER = @ARequestID 

	SELECT
		degree.ID,
		degree.RequestID,
		degree.DegreeType,
		degree.DegreeTypeName,
		degree.CountryID,
		country.Name CountryName,
		degree.Date,
		degree.Number
	FROM req.ProfessionalDegree degree
	INNER JOIN pbl.Places country ON country.ID = degree.CountryID
	WHERE (degree.RequestID = @RequestID)

	RETURN @@ROWCOUNT
END