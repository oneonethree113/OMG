/****** Object:  StoredProcedure [dbo].[sp_update_CUELC]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_CUELC]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_CUELC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/************************************************************************
Author:		Lester Wu   
Date:		12th September, 2008
Description:	Update data From CUELC
***********************************************************************
*/

CREATE procedure [dbo].[sp_update_CUELC]


@cec_cocde	nvarchar(6),
@cec_cusno	nvarchar(6),
@cec_grpcde	nvarchar(6),
@cec_grpdsc	nvarchar(200),
@cec_updusr	nvarchar(30)
 
AS

BEGIN

--------------------------------------------------------------------------------------------------


update CUELC
set
cec_grpdsc = @cec_grpdsc,
cec_updusr = @cec_updusr,
cec_upddat = getdate()
WHERE	
cec_cusno = @cec_cusno and
cec_grpcde = @cec_grpcde


END







GO
GRANT EXECUTE ON [dbo].[sp_update_CUELC] TO [ERPUSER] AS [dbo]
GO
