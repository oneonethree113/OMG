/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRPRF_All]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYUSRPRF_All]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRPRF_All]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO










/************************************************************************
Author:		Joe Yim
Date:		15th April, 2010
Description:	Select data From SYUSRPRF

************************************************************************/
CREATE        procedure [dbo].[sp_select_SYUSRPRF_All]
                                                                                                                                                                                                                                                                 
@yup_cocde	nvarchar(6)  = ' '
                                               
 
AS

begin

Select	yup_usrid,
	yup_usrnam,
	yuc_usrgrp,
	yco_cogrp,
	yug_grpdsc
from syusrprf
left join
(
	select yuc_usrid, yuc_usrgrp, yco_cogrp
	from symusrco
	left join
	sycominf
	on yuc_cocde = yco_cocde
	group by  yuc_usrid, yuc_usrgrp, yco_cogrp
) as a on yup_usrid = yuc_usrid
left join 
(
	select yug_usrgrp, yug_grpdsc from syusrgrp
	group by yug_usrgrp, yug_grpdsc
) as b on yuc_usrgrp = yug_usrgrp
where yup_accexp >= getdate()
order by 
yup_usrid

end










GO
GRANT EXECUTE ON [dbo].[sp_select_SYUSRPRF_All] TO [ERPUSER] AS [dbo]
GO
