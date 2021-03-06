/****** Object:  StoredProcedure [dbo].[sp_update_SYCATFML]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYCATFML]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYCATFML]    Script Date: 09/29/2017 15:29:10 ******/
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
S A M U E L
*/
------------------------------------------------- 
CREATE procedure [dbo].[sp_update_SYCATFML]

                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@yaf_cocde	nvarchar(6) = ' ',
@yaf_lnecde	nvarchar(10),
@yaf_catcde	nvarchar(20),
@yaf_fmlopt	nvarchar(5),
@yaf_fml	nvarchar(300),
@yaf_updusr 	nvarchar(30)
---------------------------------------------- 
 
AS


begin
update sycatfml

set 
--yaf_cocde = @yaf_cocde,
yaf_lnecde = @yaf_lnecde,
yaf_catcde = @yaf_catcde,
yaf_fmlopt = @yaf_fmlopt,
yaf_fml = @yaf_fml,
yaf_updusr = @yaf_updusr,
yaf_upddat=getdate()                                  
--------------------------------- 

 where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--yaf_cocde = @yaf_cocde and 
--yaf_cocde = ' ' and 
yaf_lnecde = @yaf_lnecde and
yaf_catcde = @yaf_catcde



update sylneinf
set 
yli_updusr = @yaf_updusr,
yli_upddat=getdate()                                  
where
--yli_cocde = @yaf_cocde and 
yli_cocde = ' ' and 
yli_lnecde= @yaf_lnecde 

 ---------------------------------------------------------- 
end



GO
GRANT EXECUTE ON [dbo].[sp_update_SYCATFML] TO [ERPUSER] AS [dbo]
GO
