/****** Object:  StoredProcedure [dbo].[sp_update_SYLNEFML]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYLNEFML]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYLNEFML]    Script Date: 09/29/2017 15:29:10 ******/
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

------------------------------------------------- 
CREATE procedure [dbo].[sp_update_SYLNEFML]

                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ylf_cocde	nvarchar(6)  = ' ',
@ylf_lnecde	nvarchar(12),
@ylf_fmlopt	nvarchar(5),
@ylf_deffml	nvarchar(3),
@yfi_prcfml	nvarchar(50),
@yfi_fml		nvarchar(200),
@ylf_updusr	nvarchar(30)

---------------------------------------------- 
 
AS


begin
update sylnefml
set 
--ylf_cocde = @ylf_cocde,
ylf_lnecde= @ylf_lnecde,
ylf_fmlopt=@ylf_fmlopt,
ylf_deffml = @ylf_deffml,
ylf_updusr = @ylf_updusr,
ylf_upddat=getdate()                                  

--------------------------------- 

where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--ylf_cocde = @ylf_cocde and 
--ylf_cocde = ' ' and 
ylf_lnecde= @ylf_lnecde and 
ylf_fmlopt = @ylf_fmlopt



---------------------------------------------------------- 
update syfmlinf
set 
--yfi_cocde = @ylf_cocde,
yfi_fmlopt=@ylf_fmlopt,
yfi_prcfml=@yfi_prcfml,
yfi_fml=@yfi_fml,
yfi_updusr = @ylf_updusr,
yfi_upddat=getdate()                                  


--------------------------------- 

where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--yfi_cocde = @ylf_cocde and 
yfi_cocde = ' ' and 
yfi_fmlopt = @ylf_fmlopt 

                                                           
---------------------------------------------------------- 

end



GO
GRANT EXECUTE ON [dbo].[sp_update_SYLNEFML] TO [ERPUSER] AS [dbo]
GO
