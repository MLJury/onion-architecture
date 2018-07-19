use [kama.mefa.organization]

--select * from org.[user] where id = '7E60AFFC-6ACA-4A75-A83A-A5C5EFA79CB7'

declare @pass nvarchar(1000) = (select [password] from org.[user] where id = '7E60AFFC-6ACA-4A75-A83A-A5C5EFA79CB7')

update org.[user]
set [password] = @pass

