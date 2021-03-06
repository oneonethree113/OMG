/****** Object:  StoredProcedure [dbo].[sp_list_SYUSRPRF_SYM00028]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYUSRPRF_SYM00028]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYUSRPRF_SYM00028]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/*
=================================================================
Program ID	: sp_list_SYUSRPRF_SYM00028
Description	: Retrieve all active Sales (Supervisor) users
		  for SYM00028
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-02-07 	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_list_SYUSRPRF_SYM00028]
@cocde	varchar(6),
@option varchar(20)
as

if @option = 'MGR'
begin
	select	distinct
		yup_usrid,
		yup_usrnam,
		yup_updusr,
		yup_credat,
		yup_upddat

	from	SYUSRPRF, SYMUSRCO
	where	yup_usrid = yuc_usrid and
		yuc_usrgrp = 'SAL-S' and
		yup_accexp > getdate()
end
else if @option = 'ALL'
begin
	select	distinct
		yup_usrid,
		yup_usrnam,
		yup_updusr,
		yup_credat,
		yup_upddat
	from	SYUSRPRF, SYMUSRCO
	where	yup_usrid = yuc_usrid and
		yuc_usrgrp like 'SAL-%' and
		yup_accexp > getdate()
end





GO
GRANT EXECUTE ON [dbo].[sp_list_SYUSRPRF_SYM00028] TO [ERPUSER] AS [dbo]
GO
