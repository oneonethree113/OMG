/****** Object:  StoredProcedure [dbo].[sp_physical_delete_IMCOLINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_IMCOLINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_IMCOLINF]    Script Date: 09/29/2017 15:29:10 ******/
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
Date:		14th September, 2001
************************************************************************/
CREATE PROCEDURE [dbo].[sp_physical_delete_IMCOLINF] 

@icf_cocde	 nvarchar(6),
@icf_itmno 	nvarchar(20),
@icf_colcde	nvarchar(30),
@icf_colseq	int


AS


delete from IMCOLINF
where 	
--icf_cocde = @icf_cocde and
icf_itmno = @icf_itmno and
icf_colcde = @icf_colcde
--icf_colseq = @icf_colseq










GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_IMCOLINF] TO [ERPUSER] AS [dbo]
GO
