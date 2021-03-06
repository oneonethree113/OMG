/****** Object:  StoredProcedure [dbo].[sp_select_CURETPRC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CURETPRC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CURETPRC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/************************************************************************
Author:		Lester Wu    
Date:		12th September, 2008
Description:	Select data From CURETPRC
***********************************************************************
*/

CREATE procedure [dbo].[sp_select_CURETPRC]


@crp_cocde	nvarchar(6),
@crp_cusno	nvarchar(6)

 
AS

BEGIN

--------------------------------------------------------------------------------------------------


SELECT	
'' as crp_del,
crp_cusno,
crp_rpcde,
ysi_dsc as 'crp_rpdsc',
crp_pmu,
crp_fml,
yfi_fml as 'crp_fmldsc',
crp_default,
crp_creusr,
crp_updusr,
crp_credat,
crp_upddat,
cast(crp_timstp as int) as crp_timstp
from CURETPRC
left join SYSETINF on ysi_cde = crp_rpcde and ysi_typ = '18'
left join SYFMLINF on yfi_fmlopt = crp_fml
where	
crp_cusno = @crp_cusno
order by crp_cusno, crp_rpcde

END






GO
GRANT EXECUTE ON [dbo].[sp_select_CURETPRC] TO [ERPUSER] AS [dbo]
GO
