/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYLNEFML]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYLNEFML]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYLNEFML]    Script Date: 09/29/2017 15:29:10 ******/
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
'***  Creation Date : 18-Sept-2000
'***  Description :  Delete SYFMLINF, SYLNEFML
'***  Logic : 1.  
'***              2. 
*/

------------------------------------------------- 
CREATE procedure [dbo].[sp_physical_delete_SYLNEFML]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ylf_cocde	nvarchar(6) = ' ',
@ylf_lnecde	nvarchar(4),
@ylf_fmlopt	nvarchar(5)                                
-------------------------------- 
AS
 
delete SYLNEFML
       
------ 
where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--ylf_cocde = @ylf_cocde  and
ylf_cocde = ' ' and
ylf_lnecde = @ylf_lnecde and
ylf_fmlopt = @ylf_fmlopt 


 
--delete SYFMLINF

-------
--where
--yfi_cocde = @ylf_cocde and
--yfi_fmlopt = @ylf_fmlopt

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------









GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYLNEFML] TO [ERPUSER] AS [dbo]
GO
