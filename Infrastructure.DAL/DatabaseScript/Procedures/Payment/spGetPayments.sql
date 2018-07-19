USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('req.spGetPayments'))
	DROP PROCEDURE req.spGetPayments
GO

CREATE PROCEDURE req.spGetPayments
	@AAdmissionID UNIQUEIDENTIFIER
	, @AAdmissionYear SMALLINT
	, @AApplicantName NVARCHAR(50)
	, @AApplicantNational NVARCHAR(50)
	, @ATransactionDateFrom SMALLDATETIME
	, @ATransactionDateTo SMALLDATETIME
	, @ATransactionResult TINYINT
	, @APageSize INT
	, @APageIndex INT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE 
		@AdmissionID UNIQUEIDENTIFIER = @AAdmissionID
		, @AdmissionYear SMALLINT = COALESCE(@AAdmissionYear, 0) 
		, @ApplicantName NVARCHAR(50) = LTRIM(RTRIM(@AApplicantName))
		, @ApplicantNational NVARCHAR(50) = LTRIM(RTRIM(@AApplicantNational))
		, @TransactionDateFrom SMALLDATETIME = @ATransactionDateFrom
		, @TransactionDateTo SMALLDATETIME = @ATransactionDateTo
		, @TransactionResult TINYINT = COALESCE(@ATransactionResult, 0)
		, @PageSize INT = COALESCE(@APageSize, 10)
		, @PageIndex INT = COALESCE(@APageIndex, 0)

	IF @PageIndex = 0 
	BEGIN
		SET @pagesize = 10000000
		SET @PageIndex = 1
	END

	SELECT 
		Count(*) OVER() Total,
		payment.ID,
		payment.AdmissionRequestID,
		adm.ID AdmissionID,
		adm.[Title] AdmissionTitle,
		adm.[Year] AdmissionYear,
		usr.FirstName ApplicantFirstName,
		usr.LastName ApplicantLastName,
		usr.NationalCode ApplicantNationalCode,
		payment.OrderID,
		payment.Amount,
		payment.CreationDate,
		payment.TransactionDate,
		payment.TransactionResult,
		payment.RefID, 
		payment.SaleReferenceID, 
		doc.DocumentNumber,
		doc.TrackingCode
	FROM req.Payment payment
		INNER JOIN req.AdmissionRequest adr ON adr.ID = payment.AdmissionRequestID
		INNER JOIN pbl.BaseDocument as doc on doc.ID = adr.ID
		INNER JOIN adm.Admission adm ON adm.ID = adr.AdmissionID
		INNER JOIN org.[Users] usr ON usr.ID = adr.[ApplicantUserID]
	WHERE (@AdmissionID IS NULL OR adr.AdmissionID = @AAdmissionID)
		and (@ApplicantName IS NULL OR usr.FirstName like concat(N'%', usr.FirstName, N'%'))
		and (@ApplicantNational IS NULL OR usr.FirstName = usr.NationalCode)
		and (@TransactionDateFrom IS NULL OR payment.TransactionDate >= @TransactionDateFrom)
		and (@TransactionDateTo IS NULL OR payment.TransactionDate < @TransactionDateTo)
		and (@TransactionResult < 1 OR payment.TransactionResult = @TransactionResult OR (@TransactionResult = 3 AND payment.TransactionResult = 0))
		ORDER BY payment.Amount
		OFFSET ((@PageIndex - 1) * @PageSize) ROWS FETCH NEXT @PageSize ROWS ONLY;
	RETURN @@ROWCOUNT
END