/****** Object:  StoredProcedure [dbo].[sp_select_POR00001_assortment]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00001_assortment]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00001_assortment]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







-- Checked by Allan Yuen at 28/07/2003


CREATE PROCEDURE [dbo].[sp_select_POR00001_assortment]
@cocde		nvarchar(6),	
@POfrom		nvarchar(20),	@POto		nvarchar(20)

AS


select 

	-- IMVENINF
	ivi_venitm,
	
	-- PODTLASS
	pda_purord,			pda_itmno,
	pda_assitm,			pda_assdsc,	pda_coldsc,
	pda_cussku,			pda_upcean,	--pda_cusrtl,
	case isnull(pda_cusrtl,'') when '0' then '' else ltrim(rtrim(pda_cusrtl)) end as 'pda_cusrtl',
	pda_pckunt = ltrim(pda_pckunt),			
	pda_cusitm,
	pda_colcde,			
	pda_inrqty = ltrim(str(pda_inrqty,10,0)),
	pda_mtrqty = ltrim(str(pda_mtrqty,10,0)),

	-- POORDDTL
	pod_purseq,

	-- SYSETINF 
	ysi_dsc as 'unit',
	pda_cusstyno


	From 	POORDDTL, PODTLASS, SYSETINF,  IMVENINF, IMBASINF
	WHERE	
		pod_cocde = pda_cocde 
	and	pod_purord = pda_purord
	and	pod_purseq = pda_seq

	and 	pda_assitm = ivi_itmno  
	and 	pda_assitm = ibi_itmno and ivi_def = 'Y'--ivi_venno = ibi_venno 

--	and	pod_cocde = ysi_cocde and pda_pckunt = ysi_cde and ysi_typ = '05'	
	and 	pda_pckunt = ysi_cde and ysi_typ = '05'	

	and 	pod_purord >= @POfrom and pod_purord <= @POto and pod_cocde = @cocde
	order by	pda_itmno, pda_assitm, pda_colcde






GO
GRANT EXECUTE ON [dbo].[sp_select_POR00001_assortment] TO [ERPUSER] AS [dbo]
GO
