/****** Object:  StoredProcedure [dbo].[sp_list_VNCATREL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_VNCATREL]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_VNCATREL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 28/07/2003


/************************************************************************
Author:		Johnson Lai 
Date:		18th September, 2001
Description:	Select data From VNCATREL
Parameter:	1. Company
		2. Vendor No.	
************************************************************************/

CREATE procedure [dbo].[sp_list_VNCATREL]

@vcr_cocde 	nvarchar(6) ,
@vcr_venno  	nvarchar(6) 

                                              
AS

begin


select 

'   '  as 'Status',
a.vcr_catlvl0 as level0,
a.vcr_catlvl1 as level1,
a.vcr_catlvl2 as level2,
a.vcr_catlvl3 as level3,
a.vcr_catlvl4 as level4,
/*a.vcr_catlvl0 + space(20 - len(a.vcr_catlvl0)) + ',' +  
a.vcr_catlvl1 + space(20 - len(a.vcr_catlvl1)) + ',' +  
a.vcr_catlvl2 + space(20 - len(a.vcr_catlvl2)) + ',' +  
a.vcr_catlvl3 + space(20 - len(a.vcr_catlvl3)) + ',' +  
a.vcr_catlvl4 + space(20 - len(a.vcr_catlvl4)) as level01234,*/
a.vcr_catlvl4 + ' - ' + b.ycc_catdsc as level01234,

a.vcr_creusr,
a.vcr_catseq
from vncatrel a

left join sycatcde b
on 
--a.vcr_cocde 	= b.ycc_cocde and
a.vcr_catlvl4	= b.ycc_catcde and
b.ycc_level	= 4

where                                  
--a.vcr_cocde 	= @vcr_cocde and                                                                                                                                                                                                                         
a.vcr_venno 	= @vcr_venno

end








GO
GRANT EXECUTE ON [dbo].[sp_list_VNCATREL] TO [ERPUSER] AS [dbo]
GO
