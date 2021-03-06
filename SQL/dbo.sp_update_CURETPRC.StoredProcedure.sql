/****** Object:  StoredProcedure [dbo].[sp_update_CURETPRC]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_CURETPRC]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_CURETPRC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/************************************************************************
Author:		Lester Wu   
Date:		12th September, 2008
Description:	Update data From CURETPRC
***********************************************************************
*/

CREATE procedure [dbo].[sp_update_CURETPRC]

@crp_cocde	nvarchar(6),
@crp_cusno	nvarchar(6),
@crp_rpcde	nvarchar(6),
@crp_pmu	nvarchar(100),
@crp_fml	nvarchar(6),
@crp_default	char(1),
@crp_updusr	nvarchar(30)
 
AS

BEGIN

--------------------------------------------------------------------------------------------------


update CURETPRC
set
crp_rpcde = @crp_rpcde,
crp_pmu = @crp_pmu,
crp_fml = @crp_fml,
crp_default = @crp_default,
crp_updusr = @crp_updusr,
crp_upddat = getdate()
WHERE	
crp_cusno = @crp_cusno and
crp_rpcde = @crp_rpcde


END







GO
GRANT EXECUTE ON [dbo].[sp_update_CURETPRC] TO [ERPUSER] AS [dbo]
GO
