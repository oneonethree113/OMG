/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYUSRGRPALL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYUSRGRPALL]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYUSRGRPALL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/************************************************************************
Author:		Louis Siu
Date:		21th Dev,2001
************************************************************************/
/*******************************************************************************************
Modification History
********************************************************************************************
Modified by	Modified on	Description
********************************************************************************************
Lester Wu		2005-04-14	Add company group
********************************************************************************************/

CREATE PROCEDURE [dbo].[sp_physical_delete_SYUSRGRPALL] 

@yug_cocde nvarchar(6),
@yug_usrgrp nvarchar(6),
@yug_cogrp nvarchar(6)


AS


delete from SYUSRGRP
where 	--yug_cocde = yug_cocde   and
 	yug_usrgrp = @yug_usrgrp
	and yug_cogrp = @yug_cogrp





GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYUSRGRPALL] TO [ERPUSER] AS [dbo]
GO
