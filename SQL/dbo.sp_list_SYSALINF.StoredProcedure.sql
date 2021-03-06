/****** Object:  StoredProcedure [dbo].[sp_list_SYSALINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYSALINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYSALINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/*
=================================================================
Program ID	: sp_list_SYSALINF
Description	: Retrieve all active Sales Rep Infomration entries
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-02-15 	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_list_SYSALINF]
@cocde	varchar(6),
@option varchar(20)
as

if @option = 'MGR'
begin
	select	'' as ssi_del,
		ssi_saldiv,
		ssi_salmgr,
		yup_usrnam as ssi_usrnam,
		'' as ssi_status
	from	SYSALINF, SYUSRPRF
	where	ssi_typ = 'MGR' and
		ssi_salmgr = yup_usrid
	order by ssi_saldiv
end
else if @option = 'TEAM'
begin
	select	'' as ssi_del,
		ssi_saltem,
		ssi_saldiv,
		'' as ssi_status
	from	SYSALINF
	where	ssi_typ = 'TEAM'
	order by ssi_saltem
end




GO
GRANT EXECUTE ON [dbo].[sp_list_SYSALINF] TO [ERPUSER] AS [dbo]
GO
