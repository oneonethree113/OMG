/****** Object:  StoredProcedure [dbo].[sp_select_QUASSINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUASSINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUASSINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO











CREATE PROCEDURE [dbo].[sp_select_QUASSINF] 

@cocde 		nvarchar(6),
@qutno		nvarchar(20)--,
--@itmno 		nvarchar(20),
--@qutseq		int

AS

declare	@mode 	nvarchar(3)
set @mode = ''

select 	@mode as 'mode', 	qai_qutno,		qai_qutseq,	qai_itmno,
	qai_assitm, 	qai_assdsc,		qai_cusitm,	qai_cusstyno, qai_colcde,	
	qai_coldsc,	
	
	--Added by Mark Lau 20060917
	qai_alsitmno,	qai_alscolcde,	
	-- Frankie Cheung 20110223 Add Assd Period
	case when year(qai_imperiod) = 1900 then '' else
	ltrim(str(year(qai_imperiod))) + '-' + right('0' +  ltrim(str( month(qai_imperiod))),2) end as 'qai_imperiod',
	---------------------------------------------
	case ibi_itmsts 	when 'CMP' then 'CMP - Active Item with complete Info.'
			when 'INC' then 'INC - Active Item with incomplete Info.'
			when 'HLD' then 'HLD - Active Item Hold by the system'
			when 'DIS' then 'DIS - Discontinue Item'
			when 'INA' then 'INA - Inactive Item'
			when 'TBC' then 'TBC - To be confirmed Item'
			when 'OLD' then 'OLD - Old Item'
	end as 'ibi_itmsts',
	
	qai_cussku,	qai_upcean,	qai_cusrtl,	
	qai_untcde,	qai_inrqty,	qai_mtrqty,	
	qai_creusr

from 	QUASSINF
left join imbasinf on qai_assitm = ibi_itmno

where 	qai_cocde = @cocde and 
	qai_qutno = @qutno






GO
GRANT EXECUTE ON [dbo].[sp_select_QUASSINF] TO [ERPUSER] AS [dbo]
GO
