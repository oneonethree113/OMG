/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYAGTINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYAGTINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYAGTINF]    Script Date: 09/29/2017 15:29:10 ******/
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


/************************************************************************
Author:		Samuel Chan
Date:		14th September, 2001
************************************************************************/
CREATE PROCEDURE [dbo].[sp_physical_delete_SYAGTINF] 

@yai_cocde	nvarchar(6) = ' ',
@yai_agtcde	nvarchar(6)



AS

delete from SYAGTINF
--where 	yai_cocde = @yai_cocde
where 	yai_cocde = ' '
and 	yai_agtcde = @yai_agtcde









GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYAGTINF] TO [ERPUSER] AS [dbo]
GO
