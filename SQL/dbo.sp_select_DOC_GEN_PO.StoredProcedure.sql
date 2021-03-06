/****** Object:  StoredProcedure [dbo].[sp_select_DOC_GEN_PO]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_DOC_GEN_PO]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_DOC_GEN_PO]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

/************************************************************************
Author:		Tommy Ho     
Date:		20 Dec, 2001
Description:	Generate Doc No.
		Format : Prefix + (YY-2 digits of current year) + running no.
		e.g. UCPP Quotation No. = UQ0100001
************************************************************************/


CREATE PROCEDURE [dbo].[sp_select_DOC_GEN_PO]

@cocde 	nvarchar(6),
@gtyp	 nvarchar(2),
@usrid	nvarchar(30),
@purord nvarchar(20) OUTPUT

AS

update SYDOCCTL set ydc_seqno = 
	Case (Len(ydc_seqno+1))  
	when 1 then '0000'
	when 2 then '000'	
	when 3 then '00'	
	when 4 then '0'
	else ''
	end +
	ltrim(Str(ydc_seqno +1)),
	ydc_upddat = getdate(),
	ydc_updusr = @usrid
where ydc_cocde = @cocde and ydc_doctyp = @gtyp

set @purord = (select ydc_prefix+ right(year(getdate()),2)+ydc_seqno
from SYDOCCTL 
where ydc_cocde = @cocde and ydc_doctyp =@gtyp)

RETURN




GO
GRANT EXECUTE ON [dbo].[sp_select_DOC_GEN_PO] TO [ERPUSER] AS [dbo]
GO
