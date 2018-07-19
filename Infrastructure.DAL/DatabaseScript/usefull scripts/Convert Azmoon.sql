use [Kama.Mefa.Azmoon]

--INSERT INTO adm.Admission
--SELECT Code ID, 
--	1 [Type],
--	CAST(Year AS SMALLINT) Year,
--	Title,
--	RegisterationStartDate,
--	RegisterationEndDate,
--	NULL RegisterExtendDate,
--	NULL VerifyStartDate,
--	NULL VerifyEndDate,
--	NULL VerifyExtendDate,
--	NEWID() CreatorID,
--	CreateTime,
--	NULL ObjectionStartDate,
--	NULL ObjectionEndDate,
--	NULL ObjectionExtendDate,
--	NULL CompleteRecordsStartDate,
--	NULL CompleteRecordsEndDate,
--	Price RegistrationFee
--FROM [MEFA_Azmoon].[dbo].Azmoon

--INSERT INTO adm.ExamAdmission
--SELECT Code ID,
--	0 FirstChairNumber,
--	AzmoonDate ExamDate,
--	ResultDate ResultAnnouncementDate,
--	DeadlineOfMashrootiYear ConditionalYears,
--	PrintCartAzmoonDate PrintDate,
--	ActiveAssignDeskNumberBtn ShowChairNumberButton,
--	LastAssignDeskNumberDate LastChairNumberAllocationDate,
--	NULL LastChairNumberAllocationUserID
--from [MEFA_Azmoon].[dbo].Azmoon

--INSERT INTO adm.Admission
--SELECT Code ID, 
--	1 [Type],
--	CAST(Year AS SMALLINT) Year,
--	Title,
--	RegisterationStartDate,
--	RegisterationEndDate,
--	NULL RegisterExtendDate,
--	NULL VerifyStartDate,
--	NULL VerifyEndDate,
--	NULL VerifyExtendDate,
--	NEWID() CreatorID,
--	COALESCE(CreateTime, GETDATE()) CreationDate,
--	NULL ObjectionStartDate,
--	NULL ObjectionEndDate,
--	NULL ObjectionExtendDate,
--	NULL CompleteRecordsStartDate,
--	NULL CompleteRecordsEndDate,
--	Price RegistrationFee
--FROM [MEFA_Azmoon].[dbo].Moafiat

--INSERT INTO adm.ExemptionAdmission
--SELECT Code ID
--from [MEFA_Azmoon].[dbo].Moafiat

select * from req.Applicant

select * from [dbo].[PersonRequest] 