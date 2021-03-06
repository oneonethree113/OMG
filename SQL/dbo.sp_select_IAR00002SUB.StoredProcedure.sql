/****** Object:  StoredProcedure [dbo].[sp_select_IAR00002SUB]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IAR00002SUB]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IAR00002SUB]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO










-- Checked by at Allan Yuen 27/07/2003
/*
=================================================================================================
Modification History
=================================================================================================
Modified On		Modified By		Description
=================================================================================================
24th Aug, 2004		Lester Wu			add alias name for all retrieved fields
5th Oct, 2004		Lester Wu			add "NOLOCK" to tables selected
*/

CREATE  procedure [dbo].[sp_select_IAR00002SUB]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

@cocde nvarchar(6)
---------------------------------------------- 
 
AS

SELECT	'Q' as 'Type', 
	hdr.quh_qutno as 'quh_qutno',
	bas.ibi_itmno as 'ibi_itmno',
	pck.ipi_pckseq as 'ipi_pckseq',
	hdr.quh_rvsdat as 'quh_rvsdat',
	ltrim(pck.ipi_pckunt)+'/ '+ltrim(str(pck.ipi_inrqty))+'/ '+ltrim(str(pck.ipi_mtrqty))+'/ '+ltrim(str(pck.ipi_cft,10,2)) as 'ipi_pckunt',
	dtl.qud_fcurcde as 'qud_fcurcde', 
	dtl.qud_ftyprc as 'qud_ftyprc',  
	dtl.qud_basprc as 'qud_basprc', 
	dtl.qud_curcde as 'qud_curcde',
	dtl.qud_cus1dp as 'qud_cus1sp',
	hdr.quh_valdat as 'quh_shpstr', 
	hdr.quh_valdat as 'quh_shpend',
	hdr.quh_cus1no as 'quh_cus1no', 
	pri.cbi_cussna as 'cbi_cussna_pri',
	hdr.quh_cus2no as 'quh_cus2no',
	sec.cbi_cussna as 'cbi_cussna_sec',
	0 as 'sod_ordqty',
	0 as 'sod_shpqty'

FROM	
	IMBASINF bas (NOLOCK), IMPCKINF pck (NOLOCK),
	QUOTNHDR hdr (NOLOCK)
	left join CUBASINF sec (NOLOCK) on sec.cbi_cusno = hdr.quh_cus2no
,
	QUOTNDTL dtl (NOLOCK), CUBASINF pri (NOLOCK)
WHERE	
	bas.ibi_itmno = pck.ipi_itmno
and	pck.ipi_itmno = dtl.qud_itmno and pck.ipi_pckseq = dtl.qud_pckseq
and	dtl.qud_cocde = hdr.quh_cocde and dtl.qud_qutno = hdr.quh_qutno
and	pri.cbi_cusno = hdr.quh_cus1no


and	hdr.quh_valdat >= getdate()

UNION

SELECT	'S',
	hdr.soh_ordno,
	bas.ibi_itmno,
	pck.ipi_pckseq,
	hdr.soh_issdat,
	ltrim(pck.ipi_pckunt)+'/ '+ltrim(str(pck.ipi_inrqty))+'/ '+ltrim(str(pck.ipi_mtrqty))+'/ '+ltrim(str(pck.ipi_cft,10,2)),
	dtl.sod_fcurcde, dtl.sod_ftyprc, dtl.sod_itmprc,dtl.sod_curcde, dtl.sod_untprc,
	dtl.sod_shpstr, dtl.sod_shpend,
	hdr.soh_cus1no, 
	pri.cbi_cussna,
	hdr.soh_cus2no,
	sec.cbi_cussna,
	dtl.sod_ordqty,
	dtl.sod_shpqty

FROM	
	IMBASINF bas (NOLOCK), IMPCKINF pck (NOLOCK),
	SCORDHDR hdr (NOLOCK)
	left join CUBASINF sec (NOLOCK) on sec.cbi_cusno = hdr.soh_cus2no
,
	SCORDDTL dtl (NOLOCK), CUBASINF pri (NOLOCK)
WHERE	
	bas.ibi_itmno = pck.ipi_itmno
and 	pck.ipi_itmno = dtl.sod_itmno and pck.ipi_pckseq = dtl.sod_pckseq
and	dtl.sod_cocde = hdr.soh_cocde and dtl.sod_ordno = hdr.soh_ordno
and 	pri.cbi_cusno = hdr.soh_cus1no
and	hdr.soh_ordsts <> 'CLO'

ORDER BY
	2, 3, 1, 4 desc, 12







GO
GRANT EXECUTE ON [dbo].[sp_select_IAR00002SUB] TO [ERPUSER] AS [dbo]
GO
