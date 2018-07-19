USE [Kama.Mefa.Azmoon]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnIsLeapYearShamsi]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnIsLeapYearShamsi]
GO

CREATE FUNCTION [dbo].[fnIsLeapYearShamsi]( @Year int )
RETURNS bit
AS
 
BEGIN
 
    DECLARE @B int,
            @isLeap bit
 
    SET @B = @Year % 33
 
    IF @B IN (1, 5, 9, 13, 17, 22, 26, 30)
        SET @isLeap = 1
    ELSE
        SET @isLeap = 0
     
    RETURN @isLeap
 
END