/****** Object:  StoredProcedure [dbo].[sp_list_PKWASGE]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_PKWASGE]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_PKWASGE]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 28/07/2003

/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 15 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
20030715	Allan Yuen		For Merge Porject
*/

/************************************************************************
Author:		Kath Ng     
Date:		4th October, 2001
Description:	List data From PKWASGE
Parameter:	1. Company Code range    
		2. Sales Code range    
************************************************************************/

CREATE procedure [dbo].[sp_list_PKWASGE]
                                                                                                                                                                                                                                                                 

@pwa_cocde	nvarchar(6)  = ' '
                                               
 
AS

BEGIN

Select	 pwa_cocde,pwa_code,pwa_seq,
pwa_qtyfrm,pwa_qtyto,pwa_wasage,pwa_um,pwa_creusr,pwa_updusr,
pwa_credat,pwa_upddat
                                  

FROM	PKWASGE

--WHERE	ysr_cocde = @ysr_cocde
WHERE	pwa_cocde = ' '
order by pwa_code,pwa_qtyfrm

END










GO
GRANT EXECUTE ON [dbo].[sp_list_PKWASGE] TO [ERPUSER] AS [dbo]
GO
