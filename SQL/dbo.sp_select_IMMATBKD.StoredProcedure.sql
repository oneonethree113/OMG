/****** Object:  StoredProcedure [dbo].[sp_select_IMMATBKD]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMMATBKD]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMMATBKD]    Script Date: 09/29/2017 15:29:10 ******/
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
Date:		24th September, 2001
************************************************************************/
CREATE PROCEDURE [dbo].[sp_select_IMMATBKD] 

@ibm_cocde  	nvarchar(6),
@ibm_itmno  	nvarchar(20)
AS


Select 
ibm_creusr as 'ibm_status',
ibm_cocde,
ibm_itmno,
ibm_matseq,
ibm_mat,
ibm_curcde,
ibm_cst,
ibm_cstper,
ibm_wgtper,
ibm_creusr,
ibm_updusr,
ibm_credat,
ibm_upddat,
cast(ibm_timstp as int) as 'ibm_timstp' 

From IMMATBKD
Where 
--ibm_cocde = @ibm_cocde and
ibm_itmno = @ibm_itmno
order by ibm_matseq









GO
GRANT EXECUTE ON [dbo].[sp_select_IMMATBKD] TO [ERPUSER] AS [dbo]
GO
