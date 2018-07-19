USE [Kama.Mefa.Azmoon]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnSplitStringList]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnSplitStringList]
GO

CREATE FUNCTION [dbo].[fnSplitStringList]
(
    @StrList nvarchar(4000)
)
RETURNS
@ParsedList table
(
    value nvarchar(500) COLLATE Arabic_CI_AS
)
AS
BEGIN
    DECLARE @Value nvarchar(500), @Pos int
 
    SET @StrList = LTRIM(RTRIM(@StrList))+ ','
    SET @Pos = CHARINDEX(',', @StrList, 1)
 
    IF REPLACE(@StrList, ',', '') <> ''
    BEGIN
        WHILE @Pos > 0
        BEGIN
            SET @Value = LTRIM(RTRIM(LEFT(@StrList, @Pos - 1)))
            IF @Value <> ''
            BEGIN
                INSERT INTO @ParsedList (value) 
                VALUES (CAST(@Value AS nvarchar)) --Use Appropriate conversion
            END
            SET @StrList = RIGHT(@StrList, LEN(@StrList) - @Pos)
            SET @Pos = CHARINDEX(',', @StrList, 1)
 
        END
    END
    RETURN
END