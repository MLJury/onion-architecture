USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetConditional'))
	DROP PROCEDURE req.spGetConditional
GO

CREATE PROCEDURE req.spGetConditional
	@AID uniqueidentifier

WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	declare @ID uniqueidentifier = @AID

	SELECT 
		cnd.*,
		admission.[Year] [Year]
	FROM req.Conditional cnd
	inner join adm.Admission admission on admission.ID = cnd.AdmissionID
	where cnd.ID = @AID
	Order By cnd.LastName

	
	RETURN @@ROWCOUNT
END