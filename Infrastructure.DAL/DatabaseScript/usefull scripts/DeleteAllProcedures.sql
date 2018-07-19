create Procedure [dbo].[DeleteAllProcedures]
As 
declare @schemaName varchar(500)    
declare @procName varchar(500)
declare cur cursor
for select s.Name, p.Name from sys.procedures p
INNER JOIN sys.schemas s ON p.schema_id = s.schema_id
WHERE p.type = 'P' and is_ms_shipped = 0 and p.name not like 'sp[_]%diagram%'
ORDER BY s.Name, p.Name
open cur

fetch next from cur into @schemaName,@procName
while @@fetch_status = 0
begin
if @procName <> 'DeleteAllProcedures'
exec('drop procedure ' + @schemaName + '.' + @procName)
fetch next from cur into @schemaName,@procName
end
close cur
deallocate cur
