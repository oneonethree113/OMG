/****** Object:  StoredProcedure [dbo].[sp_update_SYMCATCDE]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYMCATCDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYMCATCDE]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--sp_helptext sp_update_SYMCATCDE

     -- Checked by Allan Yuen at 28/07/2003  
  
/*  
=========================================================  
Program ID :   
Description    :   
Programmer   :   
ALTER  Date    :   
Last Modified   : 2005-08-11  
Table Read(s)  :  
Table Write(s)  :  
=========================================================  
 Modification History                                      
=========================================================  
Date  Author  Description  
=========================================================       
*/  
  
-------------------------------------------------   
CREATE procedure [dbo].[sp_update_SYMCATCDE]  
@ymc_cocde nvarchar(6) = ' ',  
@ymc_type  char(1),  
@ymc_catcde nvarchar(20),  
@ymc_catdsc nvarchar(200),  
@ymc_catdis nvarchar(200),
@ymc_cloth char(1),
@ymc_updusr  nvarchar(30)  
AS  
begin  

update SYMCATCDE  
set   
ymc_type = @ymc_type,  
ymc_catcde = @ymc_catcde,  
ymc_catdsc = @ymc_catdsc,  
ymc_catdis = @ymc_catdis ,
ymc_cloth = @ymc_cloth,
ymc_updusr = @ymc_updusr,  
ymc_upddat=getdate()  
 where  
ymc_cocde = ' ' and   
ymc_type = @ymc_type and  
ymc_catcde = @ymc_catcde  
                                                             
end  




GO
GRANT EXECUTE ON [dbo].[sp_update_SYMCATCDE] TO [ERPUSER] AS [dbo]
GO
