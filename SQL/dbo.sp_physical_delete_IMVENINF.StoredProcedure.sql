/****** Object:  StoredProcedure [dbo].[sp_physical_delete_IMVENINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_IMVENINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_IMVENINF]    Script Date: 09/29/2017 15:29:10 ******/
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
Last Modified  	: 17 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
17 July 2003	Allan Yuen		For Merge Porject
*/

/************************************************************************
Author:		Kenny Chan
Date:		13th September, 2001
************************************************************************/
CREATE PROCEDURE [dbo].[sp_physical_delete_IMVENINF] 

@ivi_cocde nvarchar(6),
@ivi_itmno nvarchar(20),
@ivi_venno nvarchar(6)

AS


delete from imveninf 
where 
--	ivi_cocde = @ivi_cocde and
 	ivi_itmno = @ivi_itmno and
 	ivi_venno = @ivi_venno









GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_IMVENINF] TO [ERPUSER] AS [dbo]
GO
