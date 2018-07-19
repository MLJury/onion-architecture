USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetExamFlowPrerequisite'))
	DROP PROCEDURE req.spGetExamFlowPrerequisite
GO

CREATE PROCEDURE req.spGetExamFlowPrerequisite
	@AExamRequestID UNIQUEIDENTIFIER,
	@AUserPositionID UNIQUEIDENTIFIER,
	@AUserID UNIQUEIDENTIFIER,
	@AApplicationID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@ExamRequestID  UNIQUEIDENTIFIER = @AExamRequestID,
		@UserPositionID UNIQUEIDENTIFIER = @AUserPositionID,
		@UserID UNIQUEIDENTIFIER = @AUserID,
		@ApplicationID UNIQUEIDENTIFIER = @AApplicationID,
		@FirstLetter NCHAR(1),
		@FirstLetterCode TINYINT,
		@ApplicantUserID UNIQUEIDENTIFIER,
		@ApplicantPositionID UNIQUEIDENTIFIER,
		@ExpertPositionID UNIQUEIDENTIFIER,
		@BossPositionID UNIQUEIDENTIFIER,
		@SecretaryPositionID UNIQUEIDENTIFIER,
		@ProtectionUnitPositionID UNIQUEIDENTIFIER,
		@SelectedExamsCount INT 
	
	SET @FirstLetter = (SELECT LEFT(LastName, 1) FROM Org.Users usr INNER JOIN req.AdmissionRequest req ON usr.ID = req.ApplicantUserID WHERE req.ID = @ExamRequestID)
	SET @FirstLetterCode = (SELECT Code FROM pbl.PersianLetter WHERE Letter = @FirstLetter)

	SET @ApplicantUserID = (select ApplicantUserID from req.AdmissionRequest where ID = @ExamRequestID)
	SET @ApplicantPositionID = (SELECT TOP 1 ID FROM org.Positions WHERE UserID = @ApplicantUserID AND [Type] = 20) 
	SET @ExpertPositionID = (SELECT PositionID FROM adm.DivisionOfLabor dvl INNER JOIN org.Positions pos ON pos.Id = dvl.PositionID WHERE @FirstLetterCode >= FromLetterType AND @FirstLetterCode <= ToLetterType AND pos.[Type] = 1 AND pos.ApplicationID = @ApplicationID AND pos.RemoverID IS NULL)
	SET @BossPositionID = (SELECT PositionID FROM adm.DivisionOfLabor dvl INNER JOIN org.Positions pos ON pos.Id = dvl.PositionID WHERE @FirstLetterCode >= FromLetterType AND @FirstLetterCode <= ToLetterType AND pos.[Type] = 2 AND pos.ApplicationID = @ApplicationID AND pos.RemoverID IS NULL)
	SET @SecretaryPositionID = (SELECT Top 1 ID FROM org.Positions WHERE [Type] = 3 AND ApplicationID = @ApplicationID AND RemoverID IS NULL)
	SET @ProtectionUnitPositionID = (SELECT Top 1 ID FROM org.Positions WHERE [Type] = 4 AND ApplicationID = @ApplicationID AND RemoverID IS NULL)

	SET @SelectedExamsCount = (SELECT Count(*) FROM req.ExamTest WHERE ExamRequestID = @ExamRequestID AND [State] = 1)

	SELECT 
		@ApplicantPositionID ApplicantPositionID,
		@ExpertPositionID ExpertPositionID,
		@BossPositionID BossPositionID,
		@SecretaryPositionID SecretaryPositionID,
		@ProtectionUnitPositionID ProtectionUnitPositionID,
		ausr.FirstName ApplicantFirstName,
		ausr.LastName ApplicantLastName,
		ausr.Email ApplicantEmail,
		ausr.CellPhone ApplicantCellPhone,
		exmr.DocumentNumber,
		exmr.TrackingCode,
		exmr.LastToPositionID,
		opn.ProtectionUnitConfirmType,
		exmr.LastDocState,
		opn.ExpertConfirmType,
		opn.BossConfirmType,
		opn.SecretaryConfirmType,
		@SelectedExamsCount SelectedExamsCount
	FROM req._ExamRequest exmr
	INNER JOIN Org.[Users] ausr ON ausr.ID = exmr.ApplicantUserID
	INNER JOIN req.Opinion opn ON opn.AdmissionRequestID = exmr.ID
	where exmr.ID = @ExamRequestID

	RETURN @@ROWCOUNT
END