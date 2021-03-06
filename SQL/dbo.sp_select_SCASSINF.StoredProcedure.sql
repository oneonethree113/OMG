/****** Object:  StoredProcedure [dbo].[sp_select_SCASSINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCASSINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCASSINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
=================================================================
Program ID	: sp_select_SCASSINF
Description	: Select data From SCASSINF
Programmer	: Kenny Chan
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2001-12-19 	Kenny Chan		SP Created
2005-01-18	Allan Yuen		Add one more order sequence
					field for S/C Program use
2013-05-31	David Yue		Add IM Customer Style No. and
					TO Order No. and Seq
=================================================================
*/


CREATE PROCEDURE [dbo].[sp_select_SCASSINF] 

@sai_cocde 	nvarchar(6),
@sai_ordno	nvarchar(20)


AS

select 	sai_ordno,
	sai_ordseq,
	sai_itmno,
	sai_assitm, 	
	sai_assdsc,
	sai_cusitm,
	sai_colcde,	
	sai_coldsc,
	sai_cussku,
	sai_cusstyno,
	sai_upcean,
	sai_cusrtl,
	case when year(sai_imperiod) = 1900 then '' else
	ltrim(str(year(sai_imperiod))) + '-' + right('0' +  ltrim(str( month(sai_imperiod))),2) end as 'sai_imperiod',
	sai_untcde,	
	sai_inrqty,		
	sai_mtrqty,
	sai_creusr,
	sai_ordseq as 'sai_ordseq2',
	sai_tordno,
	cast((case sai_tordseq when 0 then '' else sai_tordseq end) as nvarchar(6)) as 'sai_tordseq'
from 	SCASSINF (nolock)
where 	sai_cocde = @sai_cocde and 
	sai_ordno= @sai_ordno









GO
GRANT EXECUTE ON [dbo].[sp_select_SCASSINF] TO [ERPUSER] AS [dbo]
GO
