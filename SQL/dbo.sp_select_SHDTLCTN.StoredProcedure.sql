/****** Object:  StoredProcedure [dbo].[sp_select_SHDTLCTN]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHDTLCTN]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHDTLCTN]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/************************************************************************
Author:		Johnson Lai
Date:		31 th Jan, 2002
Description:	Select data From SHDTLCTN
Parameter:	1. Company
		2. Ship No.	
************************************************************************/
CREATE PROCEDURE [dbo].[sp_select_SHDTLCTN] 

@hdc_cocde 	nvarchar(6),
@hdc_shpno	nvarchar(20)--,


AS
select 	
' ' as 'DEL',
hdc_cocde,
hdc_shpno,
hdc_shpseq,
hdc_ctnseq,
hdc_from,
hdc_to,
hdc_ttlctn,
hdc_creusr,
hdc_updusr,
hdc_credat,
hdc_upddat,
cast( hdc_timstp as int) as 'hdc_timstp'

from 	SHDTLCTN
where 	hdc_cocde = @hdc_cocde and 
	hdc_shpno = @hdc_shpno







GO
GRANT EXECUTE ON [dbo].[sp_select_SHDTLCTN] TO [ERPUSER] AS [dbo]
GO
