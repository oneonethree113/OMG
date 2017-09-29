/****** Object:  StoredProcedure [dbo].[sp_update_IMMATBKD]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMMATBKD]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMMATBKD]    Script Date: 09/29/2017 15:29:10 ******/
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
17 July 2003	Allan Yuen		For Merge Porject, disable company code
*/

/************************************************************************
Author:		Kenny Chan
Date:		24th September, 2001
************************************************************************/
CREATE PROCEDURE [dbo].[sp_update_IMMATBKD] 

@ibm_cocde  	nvarchar(6),
@ibm_itmno  	nvarchar(20),
@ibm_matseq	int,
@ibm_mat	nvarchar(200),
@ibm_curcde	nvarchar(6),
@ibm_cst	numeric(13,4),
@ibm_cstper	numeric(13,4),
@ibm_wgtper	numeric(13,4),
@ibm_updusr  	nvarchar(30)


AS

update IMMATBKD
SET
ibm_mat = @ibm_mat,
ibm_curcde = @ibm_curcde,
ibm_cst = @ibm_cst,
ibm_cstper = @ibm_cstper,
ibm_wgtper = @ibm_wgtper,
ibm_updusr= @ibm_updusr,
ibm_upddat = getdate()

where
--ibm_cocde = @ibm_cocde and
ibm_itmno = @ibm_itmno and
ibm_matseq = @ibm_matseq











GO
GRANT EXECUTE ON [dbo].[sp_update_IMMATBKD] TO [ERPUSER] AS [dbo]
GO
