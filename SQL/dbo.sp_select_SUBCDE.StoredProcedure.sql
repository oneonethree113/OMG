/****** Object:  StoredProcedure [dbo].[sp_select_SUBCDE]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SUBCDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SUBCDE]    Script Date: 09/29/2017 15:29:10 ******/
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




CREATE PROCEDURE [dbo].[sp_select_SUBCDE] 

@cocde	nvarchar(6) = ' '

AS

select ysi_cde + ' - ' + ysi_dsc as 'subcde' 
from SYSETINF 
where 
--	ysi_cocde = @cocde 
	ysi_cocde = ' ' 
	and ysi_typ = '09' order by ysi_typ




GO
GRANT EXECUTE ON [dbo].[sp_select_SUBCDE] TO [ERPUSER] AS [dbo]
GO
