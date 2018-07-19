USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spAddFlow'))
	DROP PROCEDURE pbl.spAddFlow
GO

CREATE PROCEDURE pbl.spAddFlow
	@ADocumentID UNIQUEIDENTIFIER
  , @AFromPositionID UNIQUEIDENTIFIER
  , @AToPositionID UNIQUEIDENTIFIER
  , @AFromDocState SMALLINT
  , @AToDocState SMALLINT
  , @ASendType TINYINT
  , @AComment NVARCHAR(4000)
  , @ALog NVARCHAR(MAX)
  , @AResult NVARCHAR(MAX) OUTPUT
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @DocumentID UNIQUEIDENTIFIER = @ADocumentID
		  , @FromPositionID UNIQUEIDENTIFIER = @AFromPositionID
		  , @ToPositionID UNIQUEIDENTIFIER =  @AToPositionID
		  , @FromDocState SMALLINT =  COALESCE(@AFromDocState, 0)
		  , @ToDocState SMALLINT =  COALESCE(@AToDocState, 0)
		  , @SendType TINYINT =  COALESCE(@ASendType, 0)
		  , @Comment NVARCHAR(4000) =  LTRIM(RTRIM(@AComment))
		  , @Log NVARCHAR(MAX) =  LTRIM(RTRIM(@ALog))
		  , @ID UNIQUEIDENTIFIER
		  , @Date SMALLDATETIME = GETDATE()
		  , @TmpFromUserID UNIQUEIDENTIFIER
		  , @LastFlowID UNIQUEIDENTIFIER
		  , @DocumentType TINYINT
		  , @FromUserID UNIQUEIDENTIFIER

	IF @DocumentID IS NULL
		RETURN -2  -- داکیونت وجود ندارد

	IF @ToDocState < 1
		Return -3 -- وضعیت بعدی مشخص نشده است

	IF @SendType < 1
		RETURN -4  -- وضعیت تایید مشخص نشده است

	IF @Comment = '' SET @Comment = NULL

	SET @LastFlowID = (SELECT TOP(1) ID FROM pbl.DocumentFlow WHERE DocumentID = @DocumentID AND ActionDate IS NULL ORDER BY [Date] DESC)
	SET @FromDocState = COALESCE(@FromDocState, (SELECT TOP 1 ToDocState FROM pbl.DocumentFlow WHERE DocumentID = @DocumentID ORDER BY DATE DESC))
	SET @FromUserID = (SELECT UserID FROM org.positions WHERE ID = @FromPositionID)
	SET @DocumentType  = (SELECT [Type] FROM pbl.BaseDocument WHERE ID =@DocumentID)

	BEGIN TRY
		BEGIN TRAN
			
			SET @ID  = NEWID()

			INSERT INTO pbl.DocumentFlow
			(ID, DocumentID, [Date], FromPositionID, FromUserID, FromDocState, ToPositionID, ToDocState, SendType, Comment)
			VALUES
			(@ID, @DocumentID, @Date, @FromPositionID, @FromUserID, @FromDocState, @ToPositionID, @ToDocState, @SendType, @Comment)

			-- set action date for last flow
			UPDATE pbl.DocumentFlow
			SET ActionDate = @Date
			WHERE ID = @LastFlowID 

			-- افزودن رکوردهای استعلام
			IF @DocumentType IN (1, 2, 4)  -- فرآیندهای آزمون، معافیت، تکمیل سوابق 
				AND @ToDocState = 50  -- انجام استعلامات
			BEGIN
				-- عدم سوء پیشینه
				INSERT INTO req.Inquiry (ID, AdmissionRequestID, ParentID, [Type], [State], SendDate, ReceivedDate)
				VALUES (NEWID(), @DocumentID, NULL, 1, 1, NULL, NULL)

				-- عدم اعتیاد
				INSERT INTO req.Inquiry (ID, AdmissionRequestID, ParentID, [Type], [State], SendDate, ReceivedDate)
				VALUES (NEWID(), @DocumentID, NULL, 2, 1, NULL, NULL)

				-- دانشگاه ها

				-- سوابق کاری

				-- حسن انجام کار

			END

			-- افزودن رکوردهای مصاحبه
			IF @DocumentType  = 2     -- فرآیند معافیت 
				AND @ToDocState = 40  -- ثبت رکور مصاحبه
			BEGIN
				INSERT INTO req.InterView (ID, ExemptionRequestID, InterviewDate, InterviewResult)
				VALUES (NEWID(), @DocumentID, NULL, 0)
			END

			-- 
			IF @DocumentType  = 1     -- آزمون
				AND @ToDocState = 40  -- شرکت در آزمون
				EXEC req.spUpdateExamTestState_ @DocumentID

			EXEC pbl.spAddLog @Log
		COMMIT

		SET @AResult = '{Date:"' + CONVERT(VARCHAR, @Date, 25) + '"}'
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH

	RETURN @@ROWCOUNT
END