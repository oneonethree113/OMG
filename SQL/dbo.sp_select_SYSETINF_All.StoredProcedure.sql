/****** Object:  StoredProcedure [dbo].[sp_select_SYSETINF_All]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYSETINF_All]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYSETINF_All]    Script Date: 09/29/2017 15:29:10 ******/
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
20030715	Allan Yuen		For Merge Porject
*/

/*
S A M U E L
*/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_SYSETINF_All]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ysi_cocde nvarchar(6) = ' ', 
@ysi_typ     nvarchar(3)
---------------------------------------------- 
 
AS


begin
 Select 
ysi_creusr as 'ysi_status',
ysi_cocde,
ysi_typ,
ysi_cde,
ysi_dsc,
ysi_value,
ysi_def,
ysi_sys,
ysi_buyrat,
ysi_selrat,
ysi_creusr,
ysi_updusr,
ysi_credat,
ysi_upddat,
cast(ysi_timstp as int) as ysi_timstp

--------------------------------- 
 from SYSETINF
 where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--ysi_cocde = @ysi_cocde and 
ysi_cocde = ' ' and 
ysi_typ = @ysi_typ
                           
-------------------------- 

                                                           
---------------------------------------------------------- 
end








GO
GRANT EXECUTE ON [dbo].[sp_select_SYSETINF_All] TO [ERPUSER] AS [dbo]
GO
