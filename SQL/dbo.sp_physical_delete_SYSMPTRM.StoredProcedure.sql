/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYSMPTRM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYSMPTRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYSMPTRM]    Script Date: 09/29/2017 15:29:10 ******/
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

/*
'***  Author : Samuel Chan
'***  Creation Date : 18-Sept-2000
'***  Description : Delete SYSMPTRM
'***  Logic : 1.  
'***              2. 
*/

------------------------------------------------- 
CREATE procedure [dbo].[sp_physical_delete_SYSMPTRM]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@yst_cocde	nvarchar(6) = ' ',
@yst_trmcde	nvarchar(6)
                    
-------------------------------- 
AS
 
delete SYSMPTRM
       
------ 
where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--yst_cocde = @yst_cocde and
yst_cocde = ' ' and
yst_trmcde = @yst_trmcde
     
----









GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYSMPTRM] TO [ERPUSER] AS [dbo]
GO
