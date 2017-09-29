/****** Object:  StoredProcedure [dbo].[sp_list_SYSALREP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYSALREP]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYSALREP]    Script Date: 09/29/2017 15:29:10 ******/
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
Description:	List data From SYSALREP
Parameter:	1. Company Code range    
		2. Sales Code range    
************************************************************************/

CREATE procedure [dbo].[sp_list_SYSALREP]
                                                                                                                                                                                                                                                                 

@ysr_cocde	nvarchar(6)  = ' '
                                               
 
AS

BEGIN

Select	ysr_cocde,	ysr_code,		ysr_dsc,
	ysr_code1,	ysr_salmgr,	ysr_saltem,
	ysr_ref,		ysr_creusr,	ysr_updusr,
	ysr_credat,	ysr_upddat,	cast(ysr_timstp as int) as ysr_timstp
                                  

FROM	SYSALREP

--WHERE	ysr_cocde = @ysr_cocde
WHERE	ysr_cocde = ' '

END








GO
GRANT EXECUTE ON [dbo].[sp_list_SYSALREP] TO [ERPUSER] AS [dbo]
GO
