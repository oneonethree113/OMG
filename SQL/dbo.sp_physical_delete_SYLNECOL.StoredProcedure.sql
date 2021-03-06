/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYLNECOL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYLNECOL]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYLNECOL]    Script Date: 09/29/2017 15:29:10 ******/
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
20030715	Allan Yuen		Modify For Merge Porject
*/

/*
'***  Author : Samuel Chan
'***  Creation Date : 18-Sept-2000
'***  Description : 
'***  Logic : 1.  
'***              2. 
*/

------------------------------------------------- 
CREATE procedure [dbo].[sp_physical_delete_SYLNECOL]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ylc_cocde	nvarchar(6) = ' ',
@ylc_lnecde	nvarchar(12),
@ylc_colcde	nvarchar(12),
@ylc_updusr	nvarchar(30)

                    
-------------------------------- 
AS
 
delete SYLNECOL
       
------ 
where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--ylc_cocde = @ylc_cocde and
ylc_cocde = ' ' and
ylc_lnecde = @ylc_lnecde and
ylc_colcde = @ylc_colcde

----
update sylneinf
set 
yli_updusr = @ylc_updusr,
yli_upddat=getdate()                                  
where
--yli_cocde = @ylc_cocde and 
yli_cocde = ' ' and 
yli_lnecde= @ylc_lnecde






GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYLNECOL] TO [ERPUSER] AS [dbo]
GO
