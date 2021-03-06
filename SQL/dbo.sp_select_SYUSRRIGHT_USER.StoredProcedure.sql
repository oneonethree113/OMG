/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRRIGHT_USER]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYUSRRIGHT_USER]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRRIGHT_USER]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



















/************************************************************************
Author:		Joe Yim
Date:		03rd June, 2010
Description:	Select data From SYUSRRIGHT

************************************************************************/
CREATE    PROCEDURE [dbo].[sp_select_SYUSRRIGHT_USER]
                                                                                                                                                                                                                                                                 
@yur_cocde	nvarchar(6)  = ' ',
@yur_usrid	nvarchar(30)

AS

begin

select
	yul_cogrp,
	yur_usrid,
	yud_desc,
	case yur_lvl when 0 then 'Full Control' else yul_desc + ' - ' + yur_desc end 'desc'
from syusrright 
left join syusrlvl
	on yur_lvl = yul_lvl and yur_cogrp = yul_cogrp
left join syusrdoc
	on yur_doctyp = yud_doctyp and yur_cogrp = yud_cogrp
where yur_usrid = @yur_usrid
order by
	yul_cogrp desc,
	yud_desc,
	yul_desc,
	yur_desc,
	yur_para
end









GO
GRANT EXECUTE ON [dbo].[sp_select_SYUSRRIGHT_USER] TO [ERPUSER] AS [dbo]
GO
