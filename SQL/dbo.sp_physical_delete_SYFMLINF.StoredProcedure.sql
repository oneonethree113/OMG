/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYFMLINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYFMLINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYFMLINF]    Script Date: 09/29/2017 15:29:10 ******/
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

CREATE PROCEDURE [dbo].[sp_physical_delete_SYFMLINF] 


@yfi_cocde	 nvarchar(6) = ' ',
@yfi_fmlopt	 nvarchar(5)
--yci_usrid	nvarchar(30)
AS


delete from SYFMLINF
--where 	yfi_cocde = @yfi_cocde
where 	yfi_cocde = ' '
and 	yfi_fmlopt= @yfi_fmlopt










GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYFMLINF] TO [ERPUSER] AS [dbo]
GO
