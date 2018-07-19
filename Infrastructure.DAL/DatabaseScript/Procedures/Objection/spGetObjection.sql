USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetObjection'))
	DROP PROCEDURE req.spGetObjection
GO

CREATE PROCEDURE req.spGetObjection
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

	IF @UserPositionID IS NULL --متقاضی
	BEGIN
		IF @ApplicantUserID = @UserID  -- درخواست مربوط به کاربر جاری باشد
			AND (@LastDocState = 1   -- ارسال نشده
				 OR @LastDocState = 5) -- شکوائیه دارای نقص است
		   SET @ActionState = 1
	END
	ELSE
	BEGIN  -- کاربران وزارت خانه
		IF EXISTS(SELECT 1 FROM pbl.DocumentFlow flw WHERE flw.ToPositionID = @UserPositionID AND flw.DocumentID = @ID AND flw.ActionDate IS NULL)
			SET @ActionState = 1
	END

	SELECT obj.*
		, @ActionState ActionState
		, applicantUser.FirstName ApplicantFirstName
		, applicantUser.LastName ApplicantLastName
		, applicantUser.NationalCode ApplicantNationalCode
		, lastFromUser.FirstName + ' ' + lastFromUser.LastName LastFromUserName
		, lastToUser.FirstName + ' ' + lastToUser.LastName LastToUserName
	FROM req._Objection obj
	LEFT JOIN org.Users applicantUser ON applicantUser.ID = obj.ApplicantUserID
	LEFT JOIN org.Users lastFromUser ON lastFromUser.ID = obj.lastFromUserID
	LEFT JOIN org.Positions lastToPosition ON lastToPosition.ID = obj.LastToPositionID
	LEFT JOIN org.Users lastToUser ON lastToUser.ID = lastToPosition.UserID
	--left JOIN pbl.DocumentFlow flow ON flow.DocumentID = obj.ID AND flow.ID <> obj.LastFlowID
	WHERE obj.ID = @ID 

	RETURN @@ROWCOUNT
END