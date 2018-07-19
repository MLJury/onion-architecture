USE [Kama.Mefa.Azmoon]
GO

IF EXISTS(SELECT 1 FROM sys.procedures WHERE [object_id] = OBJECT_ID('pbl.spIsUserAuthenticated'))
	DROP PROCEDURE pbl.spIsUserAuthenticated
GO

CREATE PROCEDURE pbl.spIsUserAuthenticated
	@AUserID UNIQUEIDENTIFIER,
	@ACommandID UNIQUEIDENTIFIER
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @UserID UNIQUEIDENTIFIER = @AUserID
			, @CommandID UNIQUEIDENTIFIER = @ACommandID
			, @IsAuthorized BIT
			, @IsNotAuthorized BIT


	set @IsAuthorized = 1
	set @IsNotAuthorized = 0

	IF EXISTS(select * FROM org._Commands cmd WHERE cmd.UserID = @UserID AND cmd.CommandID = @CommandID)
	begin
		select @IsAuthorized
	end 
	else 
	begin 
		select @IsNotAuthorized
	end
END