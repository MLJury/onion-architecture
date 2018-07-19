USE [Kama.Mefa.Azmoon]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGetPositionIDByApplicantLastName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnGetPositionIDByApplicantLastName]
GO

CREATE FUNCTION [dbo].[fnGetPositionIDByApplicantLastName] (@ApplicantLastName nvarchar(100))
RETURNS uniqueidentifier
AS
BEGIN
 
DECLARE @PositionID uniqueidentifier,
		@LetterType tinyint

set @LetterType = (select 
					Code 
					from 
					pbl.PersianLetter 
					where Letter = SUBSTRING(@ApplicantLastName, 1, 1))

set @PositionID = (select top 1 PositionID from adm.DivisionOfLabor dol 
						where dol.FromLetterType <= @LetterType 
						AND dol.ToLetterType >=  @LetterType)


RETURN @PositionID
 
END