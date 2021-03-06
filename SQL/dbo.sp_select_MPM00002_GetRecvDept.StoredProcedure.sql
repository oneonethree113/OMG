/****** Object:  StoredProcedure [dbo].[sp_select_MPM00002_GetRecvDept]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MPM00002_GetRecvDept]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MPM00002_GetRecvDept]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/*
=========================================================
Program ID	: sp_select_MPM00002_GetRecvDept
Description   	: 
Programmer  	: Mark Lau
Create Date   	: 2009-06-16
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     

*/

CREATE Procedure [dbo].[sp_select_MPM00002_GetRecvDept]
@cocde	varchar(6),
@strpono	varchar(30)

as
Begin



declare @strPrefix as nvarchar(2)
declare @strPrefix2 as nvarchar(2)
set 	@strPrefix = ''
set 	@strPrefix2 = ''

if ( len(@strpono) < 2)
begin 
	select @strpono as 'recvdept' ,'' as 'recvdept'
end
else
begin
	set @strPrefix = substring(@strpono,1,2)
	set @strPrefix2 = substring(@strpono,1,1)
	
	if ( @strPrefix2 = 'H' or @strPrefix2 = 'h')
	begin
		set @strPrefix = @strPrefix2
	end
	
	select 
	@strPrefix as 'prefix',
	case  @strPrefix when '45' then '華泰' 
			when '15' then '華裕'
			when '25' then '華裕盆景'
			when '35' then '通藝'
			when '85' then '富泰'
			when '55' then '華奧'
			when '65' then '通泰'
			when '75' then '華翔'
			when 'H' then '華泰'
	end as  'recvdept'

end 
End


GO
GRANT EXECUTE ON [dbo].[sp_select_MPM00002_GetRecvDept] TO [ERPUSER] AS [dbo]
GO
