/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Quotation_GetQuotStruct]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PDA_Quotation_GetQuotStruct]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Quotation_GetQuotStruct]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
=========================================================
Description   	: sp_select_PDA_Quotation_GetQuotStruct
Programmer  	: PIC
Create Date   	: 2008-06-18
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      Initial  	Description                          
=========================================================    */ 
CREATE procedure [dbo].[sp_select_PDA_Quotation_GetQuotStruct]
/*
@prmcus	nvarchar(10),
@seccus	nvarchar(10),
@usrid		nvarchar(30)
*/
as

/*
select 	
*
from 
	PDA_Quot (nolock)
where	qud_cus1no = @prmcus and qud_cus2no = @seccus
order by qud_cocde, qud_seq asc
*/
exec sp_select_PDA_Quotation_GetQuot '9999999999','9999999999','9999999999','9999999999'




GO
GRANT EXECUTE ON [dbo].[sp_select_PDA_Quotation_GetQuotStruct] TO [ERPUSER] AS [dbo]
GO
