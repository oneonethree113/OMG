/****** Object:  StoredProcedure [dbo].[sp_list_SYFMLINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYFMLINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYFMLINF]    Script Date: 09/29/2017 15:29:10 ******/
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
Date:		25th September, 2001
Description:	List data From SYFMLINF
Parameter:	1. Company Code range    
************************************************************************/


CREATE procedure [dbo].[sp_list_SYFMLINF]
                                                                                                                                                                                                                                                               
@yfi_cocde nvarchar(6)  = ' '

AS 

Select 
*
 from SYFMLINF
 where                                                                                                                                                                                                                                                                 
-- yfi_cocde = @yfi_cocde
 yfi_cocde = ' '
--order by yfi_fmlopt
--order by yfi_fml







GO
GRANT EXECUTE ON [dbo].[sp_list_SYFMLINF] TO [ERPUSER] AS [dbo]
GO
