/****** Object:  StoredProcedure [dbo].[sp_list_SYCATREL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYCATREL]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYCATREL]    Script Date: 09/29/2017 15:29:10 ******/
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
20030715	Allan Yuen		Modify For Merge Porject
*/

CREATE procedure [dbo].[sp_list_SYCATREL]

@vcr_cocde 	nvarchar(6)  = ' '
                                               
AS

begin

select 
/*
a.ycr_catlvl0 + '-' + b.ycc_catdsc as level0,
a.ycr_catlvl1 + '-' + c.ycc_catdsc as level1,
a.ycr_catlvl2 + '-' + d.ycc_catdsc as level2,
a.ycr_catlvl3 + '-' + e.ycc_catdsc as level3,

a.ycr_catlvl0  +  Space(20-len( a.ycr_catlvl0) )    + ',' +
a.ycr_catlvl1 +  Space(20-len( a.ycr_catlvl1) )+ ',' +
a.ycr_catlvl2 +  Space(20-len( a.ycr_catlvl2) )+ ',' +
a.ycr_catlvl3 +  Space(20-len( a.ycr_catlvl3) )+ ',' +
a.ycr_catlvl4  as level4
*/
ycr_catlvl0 as level0,
ycr_catlvl1 as level1,
ycr_catlvl2 as level2,
ycr_catlvl3 as level3,
ycr_catlvl4 as level4,
ycr_catlvl4 + ' - ' + isnull(ycc_catdsc,'') as 'ycr_catlvl4'
--ycr_catlvl0 + space(20 - len(ycr_catlvl0)) + ',' +  
--ycr_catlvl1 + space(20 - len(ycr_catlvl1)) + ',' +  
--ycr_catlvl2 + space(20 - len(ycr_catlvl2)) + ',' +  
--ycr_catlvl3 + space(20 - len(ycr_catlvl3)) + ',' +  

from sycatrel 
--left join sycatcde  	on ycc_level = '4'  and   ycr_catlvl4 = ycc_catcde and ycc_cocde = @vcr_cocde
left join sycatcde  	on ycc_level = '4'  and   ycr_catlvl4 = ycc_catcde and ycc_cocde = ' ' 

where                                  
--ycr_cocde 	= @vcr_cocde 
ycr_cocde 	= ' '

order by ycr_catlvl0, ycr_catlvl1, ycr_catlvl2, ycr_catlvl3, ycr_catlvl4
end





GO
GRANT EXECUTE ON [dbo].[sp_list_SYCATREL] TO [ERPUSER] AS [dbo]
GO
