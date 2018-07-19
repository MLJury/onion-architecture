USE [Kama.Mefa.Azmoon]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGetShamsiDate]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnGetShamsiDate]
GO

CREATE FUNCTION [dbo].[fnGetShamsiDate] (@Date smalldatetime)
RETURNS nvarchar(20)
AS
BEGIN
 
DECLARE @Year int,
        @Month int,
        @Day int, 
        @ToEid int, 
        @Elapsed int, 
        @counter int,
        @retVal nvarchar(20),
        @nDay nvarchar(2),
        @nMonth nvarchar(2)
 
DECLARE @LeapSumOfDays TABLE
(
    ID int,
    Val int
)
 
DECLARE @NonLeapSumOfDays TABLE(
    ID int,
    Val int
)
 
INSERT INTO @LeapSumOfDays
SELECT ROW_NUMBER() OVER (ORDER BY CAST([value] AS int)) AS ID, CAST([value] AS int) AS Val
FROM dbo.fnSplitStringList ('0,31,62,93,124,155,186,216,246,276,306,336,366')
 
 
INSERT INTO @NonLeapSumOfDays
SELECT ROW_NUMBER() OVER (ORDER BY CAST([value] AS int)) AS ID, CAST([value] AS int) AS Val
FROM dbo.fnSplitStringList ('0,31,62,93,124,155,186,216,246,276,306,336,365')
 
 
SET @Year = YEAR(@Date) - 621
 
IF dbo.fnIsLeapYearShamsi(@Year - 1) = 1 AND dbo.fnIsLeapYear(YEAR(@Date)) = 1
    SET @ToEid = 80
ELSE
    SET @ToEid = 79
 
IF DATEPART(dy,@Date) <= @ToEid
BEGIN
    SET @Year = @Year-1
    SET @Elapsed = 286 + DATEPART(dy,@Date)
    IF dbo.fnIsLeapYearShamsi(@Year) = 1 AND dbo.fnIsLeapYear(YEAR(@Date)) = 0
        SET @Elapsed = @Elapsed + 1
END
ELSE
    SET @Elapsed = DATEPART(dy,@Date) - @ToEid
      
 
IF dbo.fnIsLeapYearShamsi(@Year) = 1
BEGIN
    SELECT TOP 1 @counter = ID FROM @NonLeapSumOfDays WHERE val >= @Elapsed
    SET @Month = @counter - 1
    SELECT @Day = @Elapsed - val FROM @NonLeapSumOfDays WHERE ID = @counter - 1
END
ELSE
BEGIN
    SELECT TOP 1 @counter = ID FROM @LeapSumOfDays WHERE val >= @Elapsed
    SET @Month = @counter - 1
    SELECT @Day = @Elapsed - val FROM @LeapSumOfDays WHERE ID = @counter - 1
END
 
 
IF LEN(@Day) = 1 
    SET @nDay = '0' + CAST(@Day AS nvarchar(2))
ELSE
    SET @nDay = CAST(@Day AS nvarchar(2))
 
IF LEN(@Month) = 1 
    SET @nMonth = '0' + CAST(@Month AS nvarchar(2))
ELSE
    SET @nMonth =  CAST(@Month AS nvarchar(2))
 
 
SET @retVal = CAST(@Year AS nvarchar(4)) + '/' + @nMonth + '/' + @nDay   
 
RETURN @retVal
 
END