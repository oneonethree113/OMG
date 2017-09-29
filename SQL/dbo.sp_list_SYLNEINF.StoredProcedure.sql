/****** Object:  StoredProcedure [dbo].[sp_list_SYLNEINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYLNEINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYLNEINF]    Script Date: 09/29/2017 15:29:10 ******/
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
Author:		Kenny Chan
Date:		13th September, 2001
************************************************************************/
CREATE PROCEDURE [dbo].[sp_list_SYLNEINF] 

@yli_cocde	nvarchar(6) = ' '

AS

	Select * from SYLNEINF
	Where yli_cocde = ' '
	order by yli_lnecde

/*
If @yli_cocde = 'UCPP'
Begin
	Select * from SYLNEINF
--	Where yli_cocde = @yli_Cocde
	Where yli_cocde = ' '
	order by yli_lnecde
END
Else
Begin
	Select * from SYLNEINF
	order by yli_lnecde
End
*/








GO
GRANT EXECUTE ON [dbo].[sp_list_SYLNEINF] TO [ERPUSER] AS [dbo]
GO
