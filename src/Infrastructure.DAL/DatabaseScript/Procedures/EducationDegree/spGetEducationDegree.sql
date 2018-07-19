USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetEducationDegree'))
	DROP PROCEDURE req.spGetEducationDegree
GO

CREATE PROCEDURE req.spGetEducationDegree
	@AID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID
		
	SELECT
		ed.ID,
		ed.RequestID,
		ed.Grade,
		ed.IssuanceCountryType,
		ed.UniversityID,
		COALESCE(ed.UniversityName, univ.[Name]) UniversityName,
		ed.UniversityUnitName,
		ed.EducationFieldID,
		COALESCE(ed.EducationFieldName, ef.[Name]) EducationFieldName,
		CAST(COALESCE(ef.EducationFieldType, 0) AS TINYINT) EducationFieldType,
		ed.GraduateDate,
		ed.RelatedCurricula
	FROM req.EducationDegree ed
	LEFT JOIN pbl.EducationField ef ON ef.ID = ed.EducationFieldID 
	LEFT JOIN pbl.University univ ON univ.ID = ed.UniversityID
	WHERE ed.ID = @ID

	RETURN @@ROWCOUNT
END