/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYMCATCDE]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYMCATCDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYMCATCDE]    Script Date: 09/29/2017 15:29:10 ******/
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

*/


------------------------------------------------- 
CREATE procedure [dbo].[sp_physical_delete_SYMCATCDE]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ymc_cocde	nvarchar(6) = ' ',
@ymc_type	char(1),
@ymc_catcde	nvarchar(20)

                    
-------------------------------- 
AS
 
delete SYMCATCDE
       
------ 
where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
ymc_cocde = ' ' and
ymc_type = @ymc_type and
ymc_catcde = @ymc_catcde

     
----










GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYMCATCDE] TO [ERPUSER] AS [dbo]
GO
