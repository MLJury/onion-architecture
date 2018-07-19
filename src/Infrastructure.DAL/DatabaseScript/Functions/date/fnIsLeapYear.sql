USE [Kama.Mefa.Azmoon]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnIsLeapYear]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnIsLeapYear]
GO

CREATE FUNCTION [dbo].[fnIsLeapYear] (@Year SMALLINT)
RETURNS BIT
AS
BEGIN
    DECLARE @leapDate SMALLDATETIME
    DECLARE @checkDay TINYINT
  
    SET @leapDate = CONVERT(VARCHAR(4), @Year) + '0228'
    SET @checkDay = DATEPART(d, DATEADD(d, 1, @leapDate))
    IF (@checkDay = 29)
        RETURN 1
 
    RETURN 0  
END