/****** Object:  StoredProcedure [dbo].[sp_select_IMBOMASS_Q_copy]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMBOMASS_Q_copy]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMBOMASS_Q_copy]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO










-- Checked by Allan Yuen at 28/07/2003



/************************************************************************
Author:		Tommy Ho
Date:		3 Jan, 2002
Frankie Cheung 20110223 Add assd/bom period
************************************************************************/
------------------------------------------------- 
CREATE PROCEDURE [dbo].[sp_select_IMBOMASS_Q_copy] 

@cocde  	nvarchar(6),	@itmno  	nvarchar(20),
@qutno	nvarchar(20),	@qutseq	int,
@creusr	nvarchar(12)

AS

SELECT 	
		iba_assitm,		
		iba_colcde,	

		
		--Added by Mark Lau 20060926
		isnull(ibi_alsitmno,qai_alsitmno) as 'ibi_alsitmno',
		isnull(ibi_alscolcde,qai_alscolcde) as 'ibi_alscolcde',
		
		isnull(icf_coldsc,'') as 'icf_coldsc',
		ISNULL(ibi_engdsc,'N/A') as 'ibi_engdsc',
		iba_pckunt,	
		iba_inrqty,		
		iba_mtrqty,
		qai_cusitm,
		qai_cussku,	
		qai_upcean,	
		qai_cusrtl,
		--Frankie Cheung 20110223 Add assd/bom period
		case when year(iba_period) = 1900 then '' else
		ltrim(str(year(iba_period))) + '-' + right('0' +  ltrim(str( month(iba_period))),2) end as 'iba_period'
from 
		IMBOMASS

left join IMBASINF on 	
		--ibi_cocde = @cocde and 
		ibi_itmno = iba_assitm

left join VNBASINF on 	
		--vbi_cocde = @cocde and 
		ibi_venno = vbi_venno

left join IMCOLINF on 	
		--icf_cocde = @cocde and 
		icf_itmno = iba_assitm and 
		icf_colcde = iba_colcde
--		icf_vencol = iba_colcde

left join QUASSINF on	
		--qai_cocde = @cocde and 
		qai_qutno = @qutno and 
		qai_qutseq = @qutseq and
		qai_itmno = @itmno and 
		qai_assitm = iba_assitm and 
		qai_colcde = iba_colcde and
		qai_untcde = iba_pckunt and 
		qai_inrqty = iba_inrqty and 
		qai_mtrqty = iba_mtrqty
where 	
	--iba_cocde = @cocde and
	iba_itmno = @itmno and
	iba_typ = 'ASS'





GO
GRANT EXECUTE ON [dbo].[sp_select_IMBOMASS_Q_copy] TO [ERPUSER] AS [dbo]
GO
