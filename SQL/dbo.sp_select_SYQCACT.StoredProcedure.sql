/****** Object:  StoredProcedure [dbo].[sp_select_SYQCACT]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYQCACT]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYQCACT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
	
CREATE PROCEDURE [dbo].[sp_select_SYQCACT]
	@usrid nvarchar(30),
	@password nvarchar(60)
AS 
BEGIN
	DECLARE @crypted_passwd nvarchar(60)
	DECLARE @id nvarchar(30)
	DECLARE @usrnam nvarchar(20)
	select @id=yqa_usrid, @usrnam=yqa_usrnam, @crypted_passwd=yqa_paswrd from SYQCACT where yqa_usrid = @usrid
	
	select 
		isnull(@id, '') as 'id', isnull(@usrnam, '') as 'username', 
		case isnull(@id, '') when '' then 0 else  dbo.CheckPassword(@password,@crypted_passwd) end as 'result'

END




GO
