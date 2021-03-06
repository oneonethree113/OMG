/****** Object:  StoredProcedure [dbo].[sp_Spring_CUMCAMRK_PDA]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_Spring_CUMCAMRK_PDA]
GO
/****** Object:  StoredProcedure [dbo].[sp_Spring_CUMCAMRK_PDA]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/************************************************************************
Author:		
Date:		
Description:	
****************

************************************************************************
=========================================================
Program ID	: 	sp_Spring_CUMCAMRK_PDA
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
           
=========================================================     
*/
CREATE procedure [dbo].[sp_Spring_CUMCAMRK_PDA]

as

select 	--ccm_cocde,
	ccm_cusno,
	ccm_ventyp,
	ccm_cat,
	ccm_markup,
	yfi_fml
	--vw.ccm_effdat
from  
	CUMCAMRK  (nolock)
	left join SYFMLINF (nolock) on yfi_fmlopt = ccm_markup
where 
	left(ccm_cusno,1) >'4'

GO
GRANT EXECUTE ON [dbo].[sp_Spring_CUMCAMRK_PDA] TO [ERPUSER] AS [dbo]
GO
