/****** Object:  StoredProcedure [dbo].[sp_update_SYSETINF_All]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYSETINF_All]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYSETINF_All]    Script Date: 09/29/2017 15:29:10 ******/
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
CREATE procedure [dbo].[sp_update_SYSETINF_All]

                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ysi_cocde 	nvarchar(6) = ' ',
@ysi_typ		nvarchar(3),
@ysi_cde		nvarchar(6),
@ysi_dsc 		nvarchar(200),
@ysi_value	nvarchar(20),
@ysi_def		nvarchar(1),
@ysi_sys		nvarchar(1),
@ysi_buyrat	numeric(8,3),
@ysi_selrat	numeric(8,3),
@ysi_updusr 	nvarchar(30)
---------------------------------------------- 
 
AS


begin
update sysetinf

--set ysi_cocde= @ysi_cocde,
set
ysi_typ=@ysi_typ,
ysi_cde = @ysi_cde,
ysi_dsc = @ysi_dsc,
ysi_value = @ysi_value,
ysi_def = @ysi_def,
ysi_sys = @ysi_sys,
ysi_buyrat = @ysi_buyrat,
ysi_selrat = @ysi_selrat,
ysi_updusr = @ysi_updusr,
ysi_upddat=getdate()                                  
--------------------------------- 

 where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- ysi_cocde = @ysi_cocde and 
--ysi_cocde = ' ' and 
ysi_typ = @ysi_typ and 
ysi_cde = @ysi_cde

                                                           
---------------------------------------------------------- 
end



GO
GRANT EXECUTE ON [dbo].[sp_update_SYSETINF_All] TO [ERPUSER] AS [dbo]
GO
