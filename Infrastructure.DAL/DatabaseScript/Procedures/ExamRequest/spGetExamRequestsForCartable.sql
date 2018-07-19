USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetExamRequestsForCartable'))
	DROP PROCEDURE req.spGetExamRequestsForCartable
GO

CREATE PROCEDURE req.spGetExamRequestsForCartable
	@AActionState INT, 
	@AUserPositionID UNIQUEIDENTIFIER,
	@ALastDocState TINYINT,
	@ALastSendType TINYINT,
	@ACreationDateFrom DATETIME,
	@ACreationDateTo DATETIME,
	@ALastFlowDateFrom SMALLDATETIME,
	@ALastFlowDateTo SMALLDATETIME,
	@ADemandedTestType TINYINT,
	@AApplicantFirstName nvarchar(50),
	@AApplicantLastName nvarchar(50),
	@AApplicantNationalCode varchar(11),
	@ADocumentNumber nvarchar(50),
	@ATrackingCode nvarchar(50),
	@APageSize INT,
	@APageIndex INT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@ActionState INT = COALESCE(@AActionState, 0),
		@UserPositionID UNIQUEIDENTIFIER = @AUserPositionID,
		@LastDocState TINYINT = COALESCE(@ALastDocState, 0),
		@LastSendType TINYINT = COALESCE(@ALastSendType, 0),
		@CreationDateFrom DATETIME = DATEADD(dd, 0, DATEDIFF(dd, 0, @ACreationDateFrom)),
		@CreationDateTo DATETIME = DATEADD(dd, 0, DATEDIFF(dd, 0, @ACreationDateFrom)),
		@LastFlowDateFrom SMALLDATETIME = DATEADD(dd, 0, DATEDIFF(dd, 0, @ALastFlowDateFrom)),
		@LastFlowDateTo SMALLDATETIME = DATEADD(dd, 0, DATEDIFF(dd, 0, @ALastFlowDateTo)),
		@DemandedTestType TINYINT = COALESCE(@ADemandedTestType, 0),
		@ApplicantFirstName nvarchar(50) = ltrim(rtrim(@AApplicantFirstName)),
		@ApplicantLastName nvarchar(50) = ltrim(rtrim(@AApplicantLastName)),
		@ApplicantNationalCode varchar(11) = ltrim(rtrim(@AApplicantNationalCode)),
		@DocumentNumber nvarchar(50) = ltrim(rtrim(@ADocumentNumber)),
		@TrackingCode nvarchar(50) = @ATrackingCode,
		@PageSize INT = COALESCE(@APageSize, 10),
		@PageIndex INT = COALESCE(@APageIndex, 1)
	
	IF @PageIndex = 0 
	BEGIN
		SET @pagesize = 10000000
		SET @PageIndex = 1
	END

	DECLARE @Flow TABLE(DocumentID UNIQUEIDENTIFIER)
	IF @ActionState IN (2, 3, 10)
	BEGIN
		INSERT INTO @Flow
		SELECT DISTINCT DocumentID 
		FROM pbl.DocumentFlow
		WHERE ToPositionID = @UserPositionID
	END

	SELECT 
		Count(*) OVER() Total, 
		exr.*,
		applicantUser.FirstName ApplicantFirstName,
		applicantUser.LastName ApplicantLastName,
		applicantUser.NationalCode ApplicantNationalCode,
		lastFromUser.FirstName + ' ' + lastFromUser.LastName LastFromUserName,
		lastToUser.FirstName + ' ' + lastToUser.LastName LastToUserName,
		lastToPosition.[Type] LastToPositionType
	FROM req._ExamRequest exr
	LEFT JOIN org.Users applicantUser ON applicantUser.ID = exr.ApplicantUserID
	LEFT JOIN org.Users lastFromUser ON lastFromUser.ID = exr.lastFromUserID
	LEFT JOIN org.Positions lastToPosition ON lastToPosition.ID = exr.LastToPositionID
	LEFT JOIN org.Users lastToUser ON lastToUser.ID = lastToPosition.UserID
	LEFT JOIN @Flow flow ON flow.DocumentID = exr.ID
	WHERE
		@ActionState IN (1, 2, 3, 10, 20)
		AND (@ActionState <> 1 OR exr.LastToPositionID = @UserPositionID)
		AND (@ActionState <> 2 OR (exr.LastToPositionID <> @UserPositionID AND flow.DocumentID IS NOT NULL))
		AND (@ActionState <> 3 OR flow.DocumentID IS NOT NULL AND exr.LastDocState = 100)
		AND (@ActionState <> 10 OR flow.DocumentID IS NOT NULL)

		AND (@LastDocState < 1 OR exr.LastDocState = @LastDocState)
		AND (@LastSendType < 1 OR exr.LastSendType = @LastSendType)
		AND (@CreationDateFrom IS NULL OR DATEADD(dd, 0, DATEDIFF(dd, 0, exr.CreationDate)) >= @CreationDateFrom)
		AND (@CreationDateTo IS NULL OR DATEADD(dd, 0, DATEDIFF(dd, 0, exr.CreationDate)) <= @CreationDateTo)
		AND (@LastFlowDateFrom IS NULL OR DATEADD(dd, 0, DATEDIFF(dd, 0, exr.LastFlowDate)) >= @LastFlowDateFrom)
		AND (@LastFlowDateTo IS NULL OR DATEADD(dd, 0, DATEDIFF(dd, 0, exr.LastFlowDate)) <= @LastFlowDateTo)
		AND (@ApplicantFirstName IS NULL OR applicantUser.FirstName = @ApplicantFirstName)
		AND (@ApplicantLastName IS NULL OR applicantUser.LastName = @ApplicantLastName)
		AND (@ApplicantNationalCode IS NULL OR applicantUser.NationalCode = @ApplicantNationalCode)
		AND (@DocumentNumber IS NULL OR exr.DocumentNumber = @DocumentNumber)
		AND (@TrackingCode IS NULL OR exr.TrackingCode = @TrackingCode)
		AND (@DemandedTestType < 1 OR exr.DemandedTestType = @DemandedTestType)
	Order By exr.CreationDate
	OFFSET ((@PageIndex - 1) * @PageSize) ROWS FETCH NEXT @PageSize ROWS ONLY;

	RETURN @@ROWCOUNT
END