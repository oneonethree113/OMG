/****** Object:  StoredProcedure [dbo].[sp_select_CUAGTINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUAGTINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUAGTINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/************************************************************************
Author:		Kath Ng     
Date:		13th September, 2001
Description:	Select data From CUBASINF
Parameter:	1. Company Code range    
		2. Customer Code range    
************************************************************************/

CREATE procedure [dbo].[sp_select_CUAGTINF]
                                                                                                                                                                                                                                                                 

@cai_cocde nvarchar(6) ,
@cai_cusno nvarchar(20) 
                                            
 
AS

BEGIN
-----------------------------------------------------------------------------------------------------------------------
SELECT	'   ' as 'Status',
	cai_cocde,	cai_cusno,	cai_cusagt + ' - ' + yai_stnam as cai_cusagt,
	cai_comrat,	cai_cusdef,	cai_creusr,
	cai_updusr,	cai_credat,	cai_upddat,
	cast(cai_timstp as int) as cai_timstp
                                  

FROM CUAGTINF

JOIN SYAGTINF ON yai_agtcde = cai_cusagt and yai_cocde =  ' ' --yai_cocde = @cai_cocde

WHERE	--cai_cocde = @cai_cocde  AND
	cai_cusno = @cai_cusno

ORDER BY cai_cusagt
-----------------------------------------------------------------------------------------------------------------------
end







GO
GRANT EXECUTE ON [dbo].[sp_select_CUAGTINF] TO [ERPUSER] AS [dbo]
GO
