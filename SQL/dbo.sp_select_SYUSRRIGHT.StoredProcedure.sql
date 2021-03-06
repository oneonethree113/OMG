/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRRIGHT]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYUSRRIGHT]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRRIGHT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO















/************************************************************************
Author:		Joe Yim
Date:		15th April, 2010
Description:	Select data From SYUSRRIGHT

************************************************************************/
CREATE            procedure [dbo].[sp_select_SYUSRRIGHT]
                                                                                                                                                                                                                                                                 
@yur_cocde	nvarchar(6)  = ' ',
@yur_cogrp	nvarchar(6),
@yur_usrid	nvarchar(30),
--@yur_doctyp	nvarchar(2),
@option		nvarchar(1) -- 0 with level 0 , 1 without level 0 

AS

begin

Select	yur_creusr as 'yur_status',
 	yur_usrid,
	yur_doctyp,
	yur_lvl,
	yul_desc,
	yur_para,
	yur_desc,
	yur_cogrp,
	yur_creusr,
	yur_updusr,
	yur_credat,
	yur_upddat,
	cast(yur_timstp as int) as yur_timstp
from SYUSRRIGHT
left join SYUSRLVL on yur_lvl = yul_lvl and yur_cogrp = yul_cogrp 
where yur_usrid = @yur_usrid and yur_cogrp = @yur_cogrp
and ((@option = '0' and yur_lvl =0) or (@option = '1' and yur_lvl <> 0))
order by yur_lvl, yur_para

end










GO
GRANT EXECUTE ON [dbo].[sp_select_SYUSRRIGHT] TO [ERPUSER] AS [dbo]
GO
