/****** Object:  StoredProcedure [dbo].[sp_select_docqup]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_docqup]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_docqup]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE procedure [dbo].[sp_select_docqup]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@cocde nvarchar(6)                      
---------------------------------------------- 
 
AS

Select	'P',
	cus.cbi_cusnam,
	hdr.quh_cus1ad,	hdr.quh_cus1st, cty.ysi_dsc, hdr.quh_cus1zp,
	hdr.quh_cus1cp,

	hdr.quh_qutno,
	hdr.quh_rvsdat,
	hdr.quh_valdat,
	agt.yai_fulnam,
	hdr.quh_salrep,

---	Details Group by Item & Packing
	dtl.qud_itmno,
---	To be midified 
	dtl.qud_cusitm,
	dtl.qud_itmdsc,
	dtl.qud_curcde,
	dtl.qud_cus1dp,
	dtl.qud_untcde,
	dtl.qud_inrqty,
	dtl.qud_mtrqty,
	dtl.qud_cft,

	dtl.qud_moq,
	dtl.qud_moa,
	
	dtl.qud_smpqty,

---	For Internal User Only:
	ven.vbi_vensna,
	dtl.qud_venno,
	dtl.qud_venitm,

---	Logic for the display of factory currency and price
---	U, C, P, I, N T, E, R, H, K --> 1, 2,3, 4,5 ,6 ,7 8, 9, 0
---	1 --> USD & 2 --> HKD
--	e.g. US$38.745 = PRENT1
	dtl.qud_ftyprc,

	dtl.qud_note,

	imm.ibi_imgpth,

	hdr.quh_paytrm,
	hdr.quh_smpprd,
	hdr.quh_smpfgt

---	Sub-report for Color Code & Color Description


From 	QUOTNHDR hdr, QUOTNDTL dtl, CUBASINF cus, 
	SYSETINF cty, SYAGTINF agt, VNBASINF ven, IMBASINF imm
WHERE 	
	hdr.quh_cocde = dtl.qud_cocde and hdr.quh_qutno = dtl.qud_qutno
--and	hdr.quh_cocde = cus.cbi_cocde 
and 	hdr.quh_cus1no = cus.cbi_cusno
--and	hdr.quh_cocde = cty.ysi_cocde 
and 	hdr.quh_cus1cy = cty.ysi_cde and cty.ysi_typ = '02'
--and	hdr.quh_cocde = agt.yai_cocde 
and 	hdr.quh_cusagt = agt.yai_agtcde
--and	dtl.qud_cocde = ven.vbi_cocde 
and 	dtl.qud_venno = ven.vbi_venno
--and 	dtl.qud_cocde = imm.ibi_cocde 
and dtl.qud_itmno = imm.ibi_itmno







GO
GRANT EXECUTE ON [dbo].[sp_select_docqup] TO [ERPUSER] AS [dbo]
GO
