/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYAGTTIR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYAGTTIR]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYAGTTIR]    Script Date: 09/29/2017 15:29:10 ******/
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
CREATE PROCEDURE [dbo].[sp_physical_delete_SYAGTTIR] 

@yat_cocde	nvarchar(6) = ' ',
@yat_agtcde	nvarchar(6),
@yat_seq		int


AS

delete from SYAGTTIR
--where 	yat_cocde = @yat_cocde
where 	yat_cocde = ' '
and 	yat_agtcde = @yat_agtcde
and	yat_seq	= @yat_seq









GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYAGTTIR] TO [ERPUSER] AS [dbo]
GO
