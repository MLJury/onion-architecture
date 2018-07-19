USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetInquiries'))
	DROP PROCEDURE req.spGetInquiries
GO

CREATE PROCEDURE req.spGetInquiries
	@AAdmissionRequestID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@AdmissionRequestID UNIQUEIDENTIFIER = @AAdmissionRequestID
		
	SELECT iq.*
		, COALESCE(ed.UniversityName, un.[Name], we.WorkPlaceName, wp.[Name]) ParentName
	FROM req.Inquiry iq
	LEFT JOIN req.EducationDegree ed ON iq.ParentID = ed.ID
	LEFT JOIN pbl.University un ON un.ID = ed.UniversityID
	LEFT JOIN req.WorkExperience we ON iq.ParentID = we.ID
	LEFT JOIN pbl.WorkPlace wp ON we.WorkPlaceID = wp.ID
	where AdmissionRequestID = @AdmissionRequestID
	Order By iq.[Type]

	RETURN @@ROWCOUNT
END