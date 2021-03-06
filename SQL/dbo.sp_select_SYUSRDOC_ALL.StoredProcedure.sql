/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRDOC_ALL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYUSRDOC_ALL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRDOC_ALL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO












/************************************************************************
Author:		Joe Yim
Date:		15th April, 2010
Description:	Select data From SYUSRDOC

************************************************************************/
CREATE         procedure [dbo].[sp_select_SYUSRDOC_ALL]
                                                                                                                                                                                                                                                                 
@yud_cocde	nvarchar(6)  = ' ',
@yud_cogrp	nvarchar(6)
 
AS

begin

Select	yud_doctyp,
	yud_desc,
	yud_cogrp,
	yud_creusr,
	yud_updusr,
	yud_credat,
	yud_upddat,
	cast(yud_timstp as int) as yud_timstp
from SYUSRDOC
where yud_cogrp = @yud_cogrp
order by yud_doctyp
end






GO
GRANT EXECUTE ON [dbo].[sp_select_SYUSRDOC_ALL] TO [ERPUSER] AS [dbo]
GO
