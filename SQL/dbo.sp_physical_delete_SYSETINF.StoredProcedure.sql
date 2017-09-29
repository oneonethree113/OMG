/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYSETINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYSETINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYSETINF]    Script Date: 09/29/2017 15:29:10 ******/
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

/* Samuel
*/

CREATE PROCEDURE [dbo].[sp_physical_delete_SYSETINF] 

@ysi_cocde	nvarchar(6) = ' ',
@ysi_typ		nvarchar(3),
@ysi_cde		nvarchar(6)


AS

delete from SYSETINF
--where 	ysi_cocde = @ysi_cocde
where 	ysi_cocde = ' '
and 	ysi_typ= @ysi_typ
and	ysi_cde=@ysi_cde









GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYSETINF] TO [ERPUSER] AS [dbo]
GO
