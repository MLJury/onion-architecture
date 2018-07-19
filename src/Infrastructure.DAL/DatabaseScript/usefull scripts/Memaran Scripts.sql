USE [MEFA_Azmoon]

select top 10 * from [dbo].[PersonProfiles]

select top 10 * from [dbo].[PersonProfileEducationalRecords] where PersonProfileCode = '8F0D73F3-6366-495A-9EC6-001DD6BD696A'
select top 10 * from [dbo].[PersonProfileProfessionalCertificates] where PersonProfileCode = '8F0D73F3-6366-495A-9EC6-001DD6BD696A'
select top 10 * from [dbo].[PersonProfileWorkExperiences] where PersonProfileCode = '8F0D73F3-6366-495A-9EC6-001DD6BD696A'
select top 10 * from [dbo].[PersonProfileWorkOrganization] where PersonProfileCode = '8F0D73F3-6366-495A-9EC6-001DD6BD696A'


select * from [dbo].Azmoon
select * from [dbo].Requests_Real where PersonRequestCode in
(
'7363C32A-BA91-4AC3-BB39-0004D2CB8CA2'
,'13888FE9-F78A-4980-9924-8E903FC56339'
,'11CEA57E-636C-4107-BC3A-A398AE3C9E3B'
)
--select * from HCConfirmStatusTypes
select * from [Mefa_Azmoon].[dbo].Requests_Real WHERE PersonRequestCode IN (select Code from [dbo].[PersonRequest] where NationalCode = '0078400511')

select * from [Mefa_Azmoon].[dbo].zones where code = '82238E2B-38FF-4C64-8C86-24A7A4FB4FAA'
select * from [Mefa_Azmoon].[dbo].zones where code = '4E64AA71-2B53-4EF3-9DE1-ED68909885A1'
select * from [Mefa_Azmoon].[dbo].zones where code = '4C4BE211-0C5C-4D6D-807D-91FBD95CD752'

select * from [dbo].[PersonRequest] 
LEFT join requests_real on requests_real.PersonRequestCode = PersonRequest.Code
LEFT join RequestAzmoon on RequestAzmoon.RequestRealCode = Requests_Real.Code
LEFT join Azmoon on Azmoon.Code = RequestAzmoon.AzmoonCode
where NationalCode = '0078400511'

select PersonRequest.CreateTime, * 
from dbo.PersonRequest
--LEFT join requests_real on requests_real.PersonRequestCode = PersonRequest.Code
where 
--NationalCode = '0078400511' and 
PersonRequest.CreateTime > '2016-12-31'
order by NationalCode 

select RequestRealCode, Count(*)
 from RequestMoafiat
 group by RequestRealCode

select RequestRealCode, Count(*)
 from RequestAzmoon
 group by RequestRealCode









select * from [Mefa_Azmoon].[dbo].[PersonRequest] where BirthDate IS NULL
select * from [Mefa_Azmoon].[dbo].[PersonRequest] where Code = '9AB0B52B-2472-4157-BE85-007DD3DDAE4A'

select * from [Mefa_Azmoon].[dbo].[PersonRequestEducationalRecords] where personrequestcode = '9AB0B52B-2472-4157-BE85-007DD3DDAE4A'
select * from [Mefa_Azmoon].[dbo].[PersonRequestProfessionalCertificates]  where personrequestcode = '9AB0B52B-2472-4157-BE85-007DD3DDAE4A'
select * from [Mefa_Azmoon].[dbo].[PersonRequestWorkExperiences] where personrequestcode = '9AB0B52B-2472-4157-BE85-007DD3DDAE4A'
select * from [Mefa_Azmoon].[dbo].[PersonRequestWorkOrganization] where personrequestcode = '9AB0B52B-2472-4157-BE85-007DD3DDAE4A'

