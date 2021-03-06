/****** Object:  StoredProcedure [dbo].[sp_select_CUELC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUELC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUELC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/************************************************************************
Author:		Lester Wu    
Date:		12th September, 2008
Description:	Select data From CUELC
***********************************************************************
*/

CREATE procedure [dbo].[sp_select_CUELC]


@cec_cocde	nvarchar(6),
@cec_cusno	nvarchar(6)

 
AS

BEGIN

--------------------------------------------------------------------------------------------------


SELECT	
'' as cec_del,
cec_cusno,
cec_grpcde,
cec_grpdsc,
cec_creusr,
cec_updusr,
cec_credat,
cec_upddat,
cast(cec_timstp as int) as cec_timstp
from CUELC
where	
cec_cusno = @cec_cusno
order by cec_cusno, cec_grpcde

END






GO
GRANT EXECUTE ON [dbo].[sp_select_CUELC] TO [ERPUSER] AS [dbo]
GO
