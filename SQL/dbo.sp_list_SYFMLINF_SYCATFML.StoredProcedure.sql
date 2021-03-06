/****** Object:  StoredProcedure [dbo].[sp_list_SYFMLINF_SYCATFML]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYFMLINF_SYCATFML]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYFMLINF_SYCATFML]    Script Date: 09/29/2017 15:29:10 ******/
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
Author:		Kenny Chan
Date:		01/17/2002
Description:	List data From SYFMLINF + SYCATFML
Parameter:	1. Company Code range    
************************************************************************/


CREATE procedure [dbo].[sp_list_SYFMLINF_SYCATFML]
                                                                                                                                                                                                                                                               
@yaf_cocde nvarchar(6)  = ' '

AS

Select 
yaf_cocde,
yaf_lnecde,
yaf_catcde,
yaf_fmlopt as 'yaf_fmlopt',
yaf_fmlopt + ' - '  + yfi_fml as 'yaf_fml' ,
yfi_prcfml,
yaf_creusr,
yaf_updusr,
yaf_credat,
yaf_upddat

from SYCATFML
-- left join SYFMLINF on yfi_cocde = @yaf_cocde and yfi_fmlopt = yaf_fmlopt
 left join SYFMLINF on yfi_cocde = ' ' and yfi_fmlopt = yaf_fmlopt
 where                                                                                                                                                                                                                                                                  
-- yaf_cocde = @yaf_cocde
 yaf_cocde = ' '

order by yaf_lnecde, yaf_fmlopt







GO
GRANT EXECUTE ON [dbo].[sp_list_SYFMLINF_SYCATFML] TO [ERPUSER] AS [dbo]
GO
