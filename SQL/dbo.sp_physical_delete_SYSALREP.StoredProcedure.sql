/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYSALREP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYSALREP]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYSALREP]    Script Date: 09/29/2017 15:29:10 ******/
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

CREATE PROCEDURE [dbo].[sp_physical_delete_SYSALREP] 


@ysr_cocde	 nvarchar(6) = ' ',
@ysr_code1		nvarchar(5),
@ysr_usrid	nvarchar(30)
AS


delete from SYSALREP
--where 	ysr_cocde = @ysr_cocde
where 	ysr_cocde = ' '
and 	ysr_code1= @ysr_code1








GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYSALREP] TO [ERPUSER] AS [dbo]
GO
