/****** Object:  StoredProcedure [dbo].[sp_list_SYFMLINF_SYLNEFML]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYFMLINF_SYLNEFML]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYFMLINF_SYLNEFML]    Script Date: 09/29/2017 15:29:10 ******/
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
Date:		24-102001
Description:	List data From SYFMLINF + SYLNEFML
Parameter:	1. Company Code range    
************************************************************************/


CREATE procedure [dbo].[sp_list_SYFMLINF_SYLNEFML]
                                                                                                                                                                                                                                                               
@ylf_cocde nvarchar(6)  = ' '

AS

Select 
ylf_cocde,
ylf_lnecde,
ylf_deffml,
yfi_fmlopt,
yfi_prcfml,
cast(ylf_fmlopt as nvarchar(10)) + ' - ' +  yfi_fml as 'yfi_fml'


 from SYFMLINF,SYLNEFML
 where                                                                                                                                                                                                                                                                  
-- ylf_cocde = @ylf_cocde and
-- yfi_cocde = @ylf_cocde and
 ylf_cocde = ' ' and
 yfi_cocde = ' ' and
 ylf_fmlopt = yfi_fmlopt
order by ylf_lnecde, yfi_fmlopt








GO
GRANT EXECUTE ON [dbo].[sp_list_SYFMLINF_SYLNEFML] TO [ERPUSER] AS [dbo]
GO
