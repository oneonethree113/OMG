/****** Object:  StoredProcedure [dbo].[sp_select_IMVENINF_Check]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMVENINF_Check]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMVENINF_Check]    Script Date: 09/29/2017 15:29:10 ******/
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
Last Modified  	: 17 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
17 July 2003	Allan Yuen		For Merge Porject, disable company code
*/


/************************************************************************
Author:		Kenny Chan
ate:		24th September, 2001
Description:	Select data From IMVENINF
Parameter:	1. Company
		2. Item No.	
************************************************************************/

CREATE PROCEDURE [dbo].[sp_select_IMVENINF_Check] 


@ivi_cocde	nvarchar(6),
@ivi_venitm  	nvarchar (20),
@ivi_venno	nvarchar(6)
AS


Select * from IMVENINF

Where 
--ivi_cocde = @ivi_cocde and
ivi_venitm = @ivi_venitm and
ivi_venno = @ivi_venno








GO
GRANT EXECUTE ON [dbo].[sp_select_IMVENINF_Check] TO [ERPUSER] AS [dbo]
GO
