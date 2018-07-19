Use [Kama.Mefa.Azmoon]

--select dbo.fnGetDBVersion() 

IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id(N'dbo.fnGetDBVersion') AND xtype IN (N'FN', N'IF', N'TF'))
	Exec('CREATE FUNCTION dbo.fnGetDBVersion() RETURNS INT AS BEGIN RETURN 1 END')

DECLARE @Version INT = (SELECT dbo.fnGetDBVersion())

IF @Version = 1
BEGIN

	-- date : 2018-03-07
	EXEC('ALTER TABLE req.EducationDegree ADD UniversityUnitName NVARCHAR(200) NULL')

	EXEC('ALTER TABLE adm.admission ADD ObjectionStartDate SMALLDATETIME NULL')
	EXEC('ALTER TABLE adm.admission ADD ObjectionEndDate SMALLDATETIME NULL')
	EXEC('ALTER TABLE adm.admission ADD ObjectionExtendDate SMALLDATETIME NULL')
	EXEC('ALTER TABLE adm.admission ADD CompleteRecordsStartDate SMALLDATETIME NULL')
	EXEC('ALTER TABLE adm.admission ADD CompleteRecordsEndDate SMALLDATETIME NULL')
	EXEC('ALTER TABLE adm.admission ADD RegistrationFee INT NULL')

	EXEC('ALTER TABLE adm.ExamAdmission ADD ExamDate SMALLDATETIME NULL')
	EXEC('ALTER TABLE adm.ExamAdmission ADD ResultsAnnouncementDate SMALLDATETIME NULL')
	EXEC('ALTER TABLE adm.ExamAdmission ADD ConditionalYears TINYINT NULL')
	EXEC('ALTER TABLE adm.ExamAdmission ADD PrintDate SMALLDATETIME NULL')
	EXEC('ALTER TABLE adm.ExamAdmission ADD ShowChairNumberButton BIT NULL')
	EXEC('UPDATE adm.ExamAdmission SET ShowChairNumberButton = 0')
	EXEC('ALTER TABLE adm.ExamAdmission ALTER COLUMN ShowChairNumberButton BIT Not NULL')
	EXEC('ALTER TABLE adm.ExamAdmission ADD LastChairNumberAllocationDate SMALLDATETIME NULL')
	EXEC('ALTER TABLE adm.ExamAdmission ADD LastChairNumberAllocationUserID UNIQUEIDENTIFIER NULL')
	
	EXEC('ALTER TABLE req.Applicant ALTER COLUMN BCSeries VARCHAR(5) NULL')

	EXEC('ALTER FUNCTION dbo.fnGetDBVersion() RETURNS INT WITH ENCRYPTION AS BEGIN RETURN 7 END')

	EXEC('create table pbl.SurveyTemplate(
			ID uniqueidentifier not null
			, Title nvarchar(50)
			, primary key (ID));')

	EXEC('create table pbl.Survey(
			ID uniqueidentifier not null,
			SurveyTemplateID uniqueidentifier not null,
			TestType tinyint,
			AnswerType tinyint,
			primary key (ID));')

	EXEC('ALTER TABLE pbl.Survey  WITH CHECK ADD  CONSTRAINT [FK_Survey_SurveyTemplates] FOREIGN KEY([SurveyTemplateID])
			REFERENCES pbl.SurveyTemplate ([ID])
			ALTER TABLE pbl.Survey CHECK CONSTRAINT [FK_Survey_SurveyTemplates]')

	EXEC('ALTER TABLE pbl.Survey ADD CreatorID UNIQUEIDENTIFIER NOT NULL')

	EXEC('ALTER TABLE pbl.SurveyTemplate ADD AdmissionID UNIQUEIDENTIFIER NOT NULL')

	EXEC('ALTER TABLE pbl.SurveyTemplate  WITH CHECK ADD  CONSTRAINT [FK_SurveyTemplate_Admission] FOREIGN KEY([AdmissionID])
			REFERENCES adm.Admission ([ID])
			ALTER TABLE pbl.SurveyTemplate CHECK CONSTRAINT [FK_SurveyTemplate_Admission]')

	EXEC('ALTER TABLE pbl.SurveyTemplate ADD CreationDate SMALLDATETIME NOT NULL')

	EXEC('ALTER TABLE pbl.SurveyTemplate alter column Title nvarchar(200) NOT NULL')
	EXEC('ALTER TABLE pbl.SurveyTemplate ADD IsRemoved bit')
	EXEC('ALTER TABLE pbl.Survey ADD IsRemoved bit')

	EXEC('ALTER TABLE pbl.SurveyTemplate ADD QuestionType tinyint NULL')
	EXEC('ALTER TABLE pbl.Survey ADD QuestionType tinyint Null')

	EXEC('ALTER FUNCTION dbo.fnGetDBVersion() RETURNS INT WITH ENCRYPTION AS BEGIN RETURN 2 END')	

END
IF @Version = 2
BEGIN
	EXEC('ALTER TABLE adm.Deprived drop column FromDate')
	EXEC('ALTER TABLE adm.Deprived drop column ToDate')
	EXEC('ALTER TABLE adm.Deprived ADD Type TINYINT NOT NULL')
	EXEC('ALTER TABLE adm.Deprived ADD FromYear SMALLINT NOT NULL')
	EXEC('ALTER TABLE adm.Deprived ADD ToYear SMALLINT NOT NULL')
	EXEC('ALTER TABLE adm.Deprived ADD Enabled BIT NOT NULL')
	EXEC('ALTER TABLE adm.Deprived ADD CreatorID UNIQUEIDENTIFIER NOT NULL')
	EXEC('ALTER TABLE adm.Deprived ADD CreationDate SMALLDATETIME NOT NULL')

	EXEC('ALTER FUNCTION dbo.fnGetDBVersion() RETURNS INT WITH ENCRYPTION AS BEGIN RETURN 3 END')	

END
IF @Version = 3
BEGIN
	EXEC('ALTER TABLE req.ExamTest drop column QualifiedExamTestID')
	EXEC('ALTER TABLE req.ExamTest Add ConditionalAdmissionYear SMALLINT NULL')
	
	EXEC('ALTER FUNCTION dbo.fnGetDBVersion() RETURNS INT WITH ENCRYPTION AS BEGIN RETURN 4 END')	
END
IF @Version = 4
BEGIN
	EXEC('ALTER TABLE [adm].[Deprived] ALTER column FromYear smallint null')
	EXEC('ALTER TABLE [adm].[Deprived] ALTER column ToYear smallint null')
	
	EXEC('ALTER FUNCTION dbo.fnGetDBVersion() RETURNS INT WITH ENCRYPTION AS BEGIN RETURN 5 END')	
END
IF @Version = 5
BEGIN
	EXEC('ALTER TABLE [req].[Applicant] ADD [ReadOnly] bit NOT NULL')
	EXEC('ALTER TABLE adm.Deprived drop column ApplicantUserID')
	EXEC('ALTER TABLE adm.Deprived add NationalCode char(10) not null')
	EXEC('ALTER TABLE adm.Deprived add FirstName NVARCHAR(200) not null')
	EXEC('ALTER TABLE adm.Deprived add LastName NVARCHAR(200) not null')

	EXEC('ALTER FUNCTION dbo.fnGetDBVersion() RETURNS INT WITH ENCRYPTION AS BEGIN RETURN 5 END')	
END
IF @Version = 5
BEGIN
	Update pbl.PersianLetter 
	set code = code * 5

	INSERT INTO pbl.PersianLetter(ID, Code, Letter)
	VALUES(newID(), 3, N'آ')
	
	update adm.DivisionOfLabor
	set FromLetterType = FromLetterType * 5
		, ToLetterType = ToLetterType * 5

	EXEC('ALTER TABLE req.Conditional add TestType1temp smallint null')
	EXEC('ALTER TABLE req.Conditional add TestType2temp smallint null')
	EXEC('ALTER TABLE req.Conditional add TestType4temp smallint null')
	EXEC('ALTER TABLE req.Conditional add TestType8temp smallint null')

	EXEC('update req.Conditional set TestType1temp = ExamYear where TestType1 = 1')
	EXEC('update req.Conditional set TestType2temp = ExamYear where TestType2 = 1')
	EXEC('update req.Conditional set TestType4temp = ExamYear where TestType4 = 1')
	EXEC('update req.Conditional set TestType8temp = ExamYear where TestType8 = 1')

	EXEC('ALTER TABLE req.Conditional drop column TestType1')
	EXEC('ALTER TABLE req.Conditional drop column TestType2')
	EXEC('ALTER TABLE req.Conditional drop column TestType4')
	EXEC('ALTER TABLE req.Conditional drop column TestType8')

	EXEC sp_rename 'req.Conditional.TestType1temp', 'TestType1', 'COLUMN'
	EXEC sp_rename 'req.Conditional.TestType2temp', 'TestType2', 'COLUMN'
	EXEC sp_rename 'req.Conditional.TestType4temp', 'TestType4', 'COLUMN'
	EXEC sp_rename 'req.Conditional.TestType8temp', 'TestType8', 'COLUMN'

	EXEC('ALTER TABLE req.Conditional add AdmissionID uniqueidentifier null')

	update req.Conditional set AdmissionID = (select ID from adm.Admission where [Type] = 1 and Year = 1397)

	EXEC('ALTER TABLE req.Conditional drop column Year')

	EXEC('ALTER TABLE req.Conditional
		ADD CONSTRAINT FK_Admission_Conditional
		FOREIGN KEY (AdmissionID) REFERENCES adm.Admission(ID)')

	EXEC('ALTER TABLE [req].[Conditional] ALTER column AdmissionID uniqueidentifier not null')

	EXEC('ALTER TABLE [req].[Conditional] ALTER column AdmissionID uniqueidentifier not null')
	/*applicant*/
	EXEC('alter table req.Applicant add BCLetter nvarchar(3) null')
	update req.Applicant set BCLetter = case BCLetterType when 1 then N'الف' when 2 then N'ب' end
	update req.Applicant set BCLetter = N'' where BCLetter is null
	EXEC('alter table req.Applicant drop column BCLetterType')

	EXEC('ALTER FUNCTION dbo.fnGetDBVersion() RETURNS INT WITH ENCRYPTION AS BEGIN RETURN 6 END')	
END
IF @Version = 6
BEGIN
	-- date 2018-05-18

	EXEC('CREATE TABLE [req].[Payment](
		[ID] [uniqueidentifier] NOT NULL,
		[AdmissionRequestID] [uniqueidentifier] NOT NULL,
		[OrderID] [bigint] NOT NULL,
		[Amount] [int] NOT NULL,
		[CreationDate] [datetime] NOT NULL,
		[TransactionDate] [datetime] NULL,
		[Result] [tinyint] NOT NULL,
	 CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]')

	EXEC('ALTER TABLE [req].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Request] FOREIGN KEY([AdmissionRequestID]) REFERENCES [req].[AdmissionRequest] ([ID])')
	EXEC('ALTER TABLE [req].[Payment] CHECK CONSTRAINT [FK_Payment_Request]')

	EXEC('ALTER FUNCTION dbo.fnGetDBVersion() RETURNS INT WITH ENCRYPTION AS BEGIN RETURN 7 END')	

END
IF @Version = 7
BEGIN
	EXEC('ALTER TABLE req.Payment ADD RefID UNIQUEIDENTIFIER')
	EXEC('ALTER TABLE req.Payment ADD SaleReferenceID BIGINT')

	EXEC('alter table req.Applicant add TaaminPassword Nvarchar(100)')

	EXEC('alter table req.ExemptionRequest add PanelProceedingsNumber Nvarchar(50) null')
	EXEC('alter table req.ExemptionRequest add PanelProceedingsDate SMALLDATETIME null')

	EXEC('alter table req.Interview add FirstName nvarchar(50) null')
	EXEC('alter table req.Interview add LastName nvarchar(50) null')
	EXEC('alter table req.Interview add NationalCode nvarchar(50) null')
	EXEC('alter table req.Interview add ProceedingsDate smalldatetime null')
	EXEC('alter table req.Interview add ProceedingsNumber nvarchar(50) null')

	EXEC('alter table req.AdmissionRequest drop column BankFishNumber, BankFishDate')

	EXEC('create table [req].[ObjectionTest] (
				[ID] Uniqueidentifier not null
				, [ObjectionID] Uniqueidentifier not null
				, [TestType] TINYINT NULL
				, [ApplicantComment] NVARCHAR(4000)
				, [ExpertComment] NVARCHAR(4000)
				, [SecretaryComment] NVARCHAR(4000)
				, [Result] TINYINT NULL
				, foreign key (ObjectionID) References [req].[Objection](ID)
				, constraint [PK_ObjectionTest] PRIMARY KEY CLUSTERED
				(
					[ID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
				) ON [PRIMARY]')

	EXEC('alter table req.ObjectionTest add NewTestRawScore int, NewDescriptiveScore numeric(5, 2)')
	EXEC('alter table req.Interview alter column ExemptionRequestID uniqueidentifier null')

	EXEC('alter table req.Interview add ConfirmerID uniqueidentifier null')
	EXEC('alter table req.Interview add ConfirmDate smalldatetime null')

	EXEC('alter table req.Objection add Result tinyint null')

	EXEC('alter table req.ObjectionTest add IsObjected bit')

	EXEC('alter table req.Objection add SecretaryConfirmType tinyint null')
END
IF @Version = 8
BEGIN
	EXEC('alter table req.ExamTestScoreHistory add Type tinyint null')
END