/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Customer_GetCUMCOVEN]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PDA_Customer_GetCUMCOVEN]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Customer_GetCUMCOVEN]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/*
=========================================================
Description   	: sp_select_PDA_Customer_GetCUMCOVEN
Programmer  	: PIC
Create Date   	: 2008-06-13
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      Initial  	Description                          
=========================================================    */ 
CREATE procedure [dbo].[sp_select_PDA_Customer_GetCUMCOVEN]
@prmcus	nvarchar(20),
@ventyp	nvarchar(1)
as


select 	
	ccv_cocde,
	ccv_cusno,
	ccv_ventyp,
	ccv_vendef
from 
	CUMCOVEN (nolock)
where 
	left(ccv_cusno,1) >'4'
and ccv_cusno = @prmcus and ccv_ventyp = @ventyp
order by ccv_cocde asc






GO
GRANT EXECUTE ON [dbo].[sp_select_PDA_Customer_GetCUMCOVEN] TO [ERPUSER] AS [dbo]
GO
