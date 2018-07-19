USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetExamRequest'))
	DROP PROCEDURE req.spGetExamRequest
GO

CREATE PROCEDURE req.spGetExamRequest
	@AID UNIQUEIDENTIFIER
	, @AUserPositionID UNIQUEIDENTIFIER
	, @AUserID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ID UNIQUEIDENTIFIER = @AID
		, @UserPositionID UNIQUEIDENTIFIER = @AUserPositionID
		, @UserID UNIQUEIDENTIFIER = @AUserID 
		, @ApplicantUserID UNIQUEIDENTIFIER 
		, @ActionState TINYINT = 0
		, @LastDocState INT
	
	SET @ApplicantUserID = (SELECT ApplicantUserID FROM req.AdmissionRequest WHERE ID = @ID)
	SET @LastDocState = COALESCE((SELECT TOP 1 ToDocState FROM pbl.DocumentFlow WHERE DocumentID = @ID AND ActionDate IS NULL), 1)

	--IF @UserPositionID IS NULL --متقاضی
	--BEGIN
	--	IF @ApplicantUserID = @UserID  -- درخواست مربوط به کاربر جاری باشد
	--		AND (@LastDocState = 1   -- ارسال نشده
	--			 OR @LastDocState = 5) -- شکوائیه دارای نقص است
	--	   SET @ActionState = 1
	--END
	--ELSE
	--BEGIN  
	--END

	-- کاربران وزارت خانه
	IF EXISTS(SELECT 1 FROM pbl.DocumentFlow flw WHERE flw.ToPositionID = @UserPositionID AND flw.DocumentID = @ID AND flw.ActionDate IS NULL)
		SET @ActionState = 1
		
	SELECT exr.*
		, @ActionState ActionState
		, applicantUser.FirstName ApplicantFirstName
		, applicantUser.LastName ApplicantLastName
		, applicantUser.NationalCode ApplicantNationalCode
		, lastFromUser.FirstName + ' ' + lastFromUser.LastName LastFromUserName
		, lastToUser.FirstName + ' ' + lastToUser.LastName LastToUserName
		, lastToPosition.[Type] LastToPositionType
	FROM req._ExamRequest exr
	LEFT JOIN org.Users applicantUser ON applicantUser.ID = exr.ApplicantUserID
	LEFT JOIN org.Users lastFromUser ON lastFromUser.ID = exr.lastFromUserID
	LEFT JOIN org.Positions lastToPosition ON lastToPosition.ID = exr.LastToPositionID
	LEFT JOIN org.Users lastToUser ON lastToUser.ID = lastToPosition.UserID
	LEFT JOIN pbl.DocumentFlow flow ON flow.DocumentID = exr.ID AND flow.ID <> exr.LastFlowID
	WHERE exr.ID = @ID

	RETURN @@ROWCOUNT
END