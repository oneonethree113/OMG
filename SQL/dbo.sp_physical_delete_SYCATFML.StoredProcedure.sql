/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCATFML]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYCATFML]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCATFML]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
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

CREATE PROCEDURE [dbo].[sp_physical_delete_SYCATFML] 


@yaf_cocde	 nvarchar(6) = ' ',
@yaf_lnecde	nvarchar(10),
@yaf_catcde	nvarchar(20),
@yaf_updusr	nvarchar(30)

AS

delete from SYCATFML
--where 	yaf_cocde = @yaf_cocde
where 	yaf_cocde = ' '
and 	yaf_lnecde= @yaf_lnecde
and 	yaf_catcde=@yaf_catcde


update sylneinf
set 
yli_updusr = @yaf_updusr,
yli_upddat=getdate()                                  
where
--yli_cocde = @yaf_cocde and 
yli_cocde = ' ' and 
yli_lnecde= @yaf_lnecde






GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYCATFML] TO [ERPUSER] AS [dbo]
GO
