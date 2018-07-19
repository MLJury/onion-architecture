USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetProfessionalDegree'))
	DROP PROCEDURE req.spGetProfessionalDegree
GO

CREATE PROCEDURE req.spGetProfessionalDegree
	@AID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID
		
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
	WHERE (degree.ID = @ID)

	RETURN @@ROWCOUNT
END