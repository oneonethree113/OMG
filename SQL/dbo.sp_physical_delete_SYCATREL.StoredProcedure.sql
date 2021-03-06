/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCATREL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYCATREL]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCATREL]    Script Date: 09/29/2017 15:29:10 ******/
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



/*
'***  Author : Samuel Chan
'***  Creation Date : 22-10-2001
'***  Description : 
'***  Logic : 1.  
'***              2. 
*/

------------------------------------------------- 
CREATE procedure [dbo].[sp_physical_delete_SYCATREL]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ycr_cocde	nvarchar(6) = ' ',
@ycr_catseq	int,
@ycr_catlvl0	nvarchar(20),
@ycr_catlvl1	nvarchar(20),
@ycr_catlvl2	nvarchar(20),
@ycr_catlvl3	nvarchar(20),
@ycr_catlvl4	nvarchar(20)                    
-------------------------------- 
AS
 
delete SYCATREL
       
------ 
where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--ycr_cocde = @ycr_cocde and
ycr_cocde = ' ' and
ycr_catseq = @ycr_catseq and
ycr_catlvl0 = @ycr_catlvl0 and
ycr_catlvl1 = @ycr_catlvl1 and
ycr_catlvl2 = @ycr_catlvl2 and
ycr_catlvl3 = @ycr_catlvl3 and
ycr_catlvl4 = @ycr_catlvl4 

----









GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYCATREL] TO [ERPUSER] AS [dbo]
GO
