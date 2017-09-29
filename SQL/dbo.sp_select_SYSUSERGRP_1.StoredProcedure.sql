/****** Object:  StoredProcedure [dbo].[sp_select_SYSUSERGRP_1]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYSUSERGRP_1]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYSUSERGRP_1]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/************************************************************************
Author:		Joe Yim
Date:		5th May, 2010
Description:	Select data From SYUSRGRP
***********************************************************************
*/
CREATE  Procedure [dbo].[sp_select_SYSUSERGRP_1]
                                                                                                                                                                                                                                                                 

@cocde nvarchar(6)

AS

begin

Select distinct yug_usrgrp, yug_grpdsc
from SYUSRGRP

end







GO
GRANT EXECUTE ON [dbo].[sp_select_SYSUSERGRP_1] TO [ERPUSER] AS [dbo]
GO
