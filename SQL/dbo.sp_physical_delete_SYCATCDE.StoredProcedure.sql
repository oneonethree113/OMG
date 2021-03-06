/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCATCDE]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYCATCDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCATCDE]    Script Date: 09/29/2017 15:29:10 ******/
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
'***  Description : Delete SYCATCDE
'***  Logic : 1.  
'***              2. 
*/

------------------------------------------------- 
CREATE procedure [dbo].[sp_physical_delete_SYCATCDE]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ycc_cocde	nvarchar(6) = ' ',
@ycc_level	nvarchar(2),
@ycc_catcde	nvarchar(20)

                    
-------------------------------- 
AS
 
delete SYCATCDE
       
------ 
where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--ycc_cocde = @ycc_cocde and
ycc_cocde = ' ' and
ycc_level = @ycc_level and
ycc_catcde = @ycc_catcde

     
----









GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYCATCDE] TO [ERPUSER] AS [dbo]
GO
