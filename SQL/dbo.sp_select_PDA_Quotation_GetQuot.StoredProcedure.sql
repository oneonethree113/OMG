/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Quotation_GetQuot]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PDA_Quotation_GetQuot]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Quotation_GetQuot]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
=========================================================
Description   	: sp_select_PDA_Quotation_GetQuot
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
CREATE procedure [dbo].[sp_select_PDA_Quotation_GetQuot]
@tmpqutno		nvarchar(20),
@sessid		nvarchar(50),
@prmcus	nvarchar(10),
@seccus	nvarchar(10)


as

-- UCPP
select 	
*
, convert(nvarchar(20),qud_inrqty) + convert(nvarchar(1),'/') + convert(nvarchar(20),qud_mtrqty) + convert(nvarchar(1), '/') + convert(nvarchar(20),qud_cft) + convert(nvarchar(1), '/') + convert(nvarchar(20),qud_untcde) as 'qud_packing'
, 'N' as 'qud_actflg'

from 
	PDA_Quot  (nolock)
	where	qud_cus1no = @prmcus and qud_cus2no = @seccus and qud_sessid = @sessid and  qud_aprsts = '' and qud_qutno = ''
	and qud_tmpqutno = @tmpqutno


order by qud_sessid desc , qud_cocde asc, qud_cus1no asc



GO
GRANT EXECUTE ON [dbo].[sp_select_PDA_Quotation_GetQuot] TO [ERPUSER] AS [dbo]
GO
