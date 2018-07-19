SELECT ORDINAL_POSITION, 
	   COLUMN_NAME, 
	   '', 
	   upper(DATA_TYPE), 
	   CASE upper(COLUMN_NAME) When 'ID' Then '@@' else '' end, 
	   CASE When upper(DATA_TYPE) = 'UNIQUEIDENTIFIER' AND upper(COLUMN_NAME) <> 'ID'  Then '@@' else '' end
	   , case IS_NULLABLE when 'NO' then '@@' else '' end, '' 
	   --, *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'TextTemplates'