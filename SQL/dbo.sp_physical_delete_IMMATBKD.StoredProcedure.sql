/****** Object:  StoredProcedure [dbo].[sp_physical_delete_IMMATBKD]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_IMMATBKD]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_IMMATBKD]    Script Date: 09/29/2017 15:29:10 ******/
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
Date:		24th September, 2001
************************************************************************/
CREATE PROCEDURE [dbo].[sp_physical_delete_IMMATBKD] 

@ibm_cocde	 nvarchar(6),
@ibm_itmno 	nvarchar(20),
@ibm_matseq	int

AS

delete from IMMATBKD
where 	
--ibm_cocde = @ibm_cocde and
ibm_itmno = @ibm_itmno and
ibm_matseq = @ibm_matseq 










GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_IMMATBKD] TO [ERPUSER] AS [dbo]
GO
