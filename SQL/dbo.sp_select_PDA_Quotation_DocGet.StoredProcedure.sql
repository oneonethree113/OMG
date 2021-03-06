/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Quotation_DocGet]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PDA_Quotation_DocGet]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Quotation_DocGet]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[sp_select_PDA_Quotation_DocGet]

@cocde 	nvarchar(6),
@doctyp 	nvarchar(10),
@updusr	nvarchar(30)

AS
begin
update pda_quot_doc set pqd_seqno = 
	Case (Len(pqd_seqno+1))  
	when 1 then '0000'
	when 2 then '000'	
	when 3 then '00'	
	when 4 then '0'
	else ''
	end +
	ltrim(Str(pqd_seqno +1)),
	pqd_upddat = getdate(),
	pqd_updusr = @updusr
where pqd_cocde = @cocde and pqd_doctyp = @doctyp

select pqd_prefix+ right(year(getdate()),2)+pqd_seqno
from pda_quot_doc 
where pqd_cocde = @cocde and pqd_doctyp = @doctyp
end




GO
GRANT EXECUTE ON [dbo].[sp_select_PDA_Quotation_DocGet] TO [ERPUSER] AS [dbo]
GO
