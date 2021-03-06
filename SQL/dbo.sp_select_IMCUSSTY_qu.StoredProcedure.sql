/****** Object:  StoredProcedure [dbo].[sp_select_IMCUSSTY_qu]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMCUSSTY_qu]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMCUSSTY_qu]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/************************************************************************
Author:		Lester Wu    
Date:		29th September, 2008
Description:	Select data From CUCSTEMT
***********************************************************************
*/

CREATE procedure [dbo].[sp_select_IMCUSSTY_qu]


@qud_cocde	nvarchar(6),
@qud_itmno	nvarchar(20),
@quh_cusno	nvarchar(20)

 
AS

BEGIN

--------------------------------------------------------------------------------------------------


SELECT	
*
from IMCUSSTY
where	
ics_itmno = @qud_itmno and ics_cusno = @quh_cusno
order by ics_upddat desc, ics_cusstyno asc

END


GO
GRANT EXECUTE ON [dbo].[sp_select_IMCUSSTY_qu] TO [ERPUSER] AS [dbo]
GO
