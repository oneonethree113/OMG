/****** Object:  StoredProcedure [dbo].[sp_select_SYCATREL_SYS]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYCATREL_SYS]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYCATREL_SYS]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





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



/************************************************************************
Author:		Samuel 
Date:		22/10/2001
Description:	Select data From SYCATREL

************************************************************************/

CREATE procedure [dbo].[sp_select_SYCATREL_SYS]

@ycr_cocde 	nvarchar(6) = ' '

AS

declare @ycr_timstp int

--Set  @ycr_timstp = (Select max(cast(ycr_timstp as int)) from sycatrel where ycr_cocde = @ycr_cocde)
Set  @ycr_timstp = (Select max(cast(ycr_timstp as int)) from sycatrel where ycr_cocde = ' ')
begin

Select
ycr_creusr as 'ycr_status',
ycr_cocde,
ycr_catseq,
ycr_catlvl0,
ycr_catlvl1,
ycr_catlvl2,
ycr_catlvl3,
ycr_catlvl4,
ycr_creusr,
ycr_updusr,
ycr_credat,
ycr_upddat,
@ycr_timstp as ycr_timstp 

from SYCATREL

where                                                                                                                                                                                                                                                                

--ycr_cocde	 = @ycr_cocde 
ycr_cocde	 = ' ' 

order by 

ycr_catlvl0,
ycr_catlvl1,
ycr_catlvl2,
ycr_catlvl3,
ycr_catlvl4



end









GO
GRANT EXECUTE ON [dbo].[sp_select_SYCATREL_SYS] TO [ERPUSER] AS [dbo]
GO
