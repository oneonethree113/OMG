/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCOLINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYCOLINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCOLINF]    Script Date: 09/29/2017 15:29:10 ******/
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

CREATE PROCEDURE [dbo].[sp_physical_delete_SYCOLINF] 


@yci_cocde	 nvarchar(6) = ' ',
@yci_colcde 	nvarchar(30),
@yci_usrid	nvarchar(30)
AS


delete from SYCOLINF
--where 	yci_cocde = @yci_cocde
where 	yci_cocde = ' '
and 	yci_colcde= @yci_colcde










GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYCOLINF] TO [ERPUSER] AS [dbo]
GO
