/****** Object:  StoredProcedure [dbo].[sp_select_IAR00001_bak]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IAR00001_bak]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IAR00001_bak]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_select_IAR00001_bak] 

@cocde	nvarchar(6),
@transdate datetime,
@transend datetime,
@itmlst	nvarchar(240),
@usrid	nvarchar(30)                

AS
SET ANSI_WARNINGS OFF 
exec('
SELECT	DISTINCT
	''Q'',

--	Header
	bas.ibi_itmno,
	bas.ibi_engdsc, 
	dat.iid_venitm,
	bas.ibi_venno,
	vnb.vbi_vensna,
	bas.ibi_upddat,
	pck.ipi_pckseq,
	pck.ipi_pckunt + ''/ ''+ ltrim(str(pck.ipi_inrqty))+ ''/ '' + ltrim(str(pck.ipi_mtrqty)) + ''/ '' + ltrim(str(pck.ipi_cft,8,2)),
	dat.iid_untcde + ''/ ''+ ltrim(str(dat.iid_inrqty)) + ''/ '' + ltrim(str(dat.iid_mtrqty)) + ''/ '' + ltrim(str(dat.iid_cft,8,2)),
	max(rtrim(isnull(mup.imu_curcde,'''')) +ltrim(str(mup.imu_ftyprc,13,4))),
	max(rtrim(isnull(dat.iid_curcde,'''')) + ltrim(str(dat.iid_ftyprc,13,4))),
	rtrim(mup.imu_bcurcde) + ltrim(str(mup.imu_basprc,13,4)),
	'''',
--	dat.iid_ftyprc,
--	new basic price
	Case mup.imu_ftyprc when 0 then 0 else (dat.iid_ftyprc - mup.imu_ftyprc) / mup.imu_ftyprc * 100 end,

--	Detail
	hdr.quh_cus1no,	cq1.cbi_cussna,
	hdr.quh_cus2no, cq2.cbi_cussna,
	hdr.quh_qutno,
	hdr.quh_rvsdat,
	hdr.quh_valdat, hdr.quh_valdat,
	hdr.quh_curcde, dtl.qud_cus1sp,
	dtl.qud_basprc,0,
	ltrim(fml.yfi_fmlopt) +  '' - '' + ltrim(fml.yfi_fml),
	qud_fcurcde, qud_ftyprc,
	0,
	''''

---	unit price in diferent

FROM	IMBASINF bas, IMPCKINF pck, SYFMLINF fml, VNBASINF vnb, IMMRKUP mup,
	IMITMDAT dat
	left join QUOTNDTL dtl on dat.iid_cocde = dtl.qud_cocde and dat.iid_itmno = qud_itmno
	and dat.iid_untcde = qud_untcde and dat.iid_inrqty = qud_inrqty and dat.iid_mtrqty = qud_mtrqty
	left join QUOTNHDR hdr on  dat.iid_cocde = hdr.quh_cocde and dtl.qud_qutno = hdr.quh_qutno
	and hdr.quh_valdat > cast(''' + @transdate + ''' as datetime)
	left join CUBASINF cq1 on dat.iid_cocde = cq1.cbi_cocde and hdr.quh_cus1no = cq1.cbi_cusno
	left join CUBASINF cq2 on dat.iid_cocde = cq2.cbi_cocde and hdr.quh_cus2no = cq2.cbi_cusno
WHERE	dat.iid_cocde = ''' + @cocde + '''
and bas.ibi_itmno IN (' + @itmlst + ')
and bas.ibi_venno = vnb.vbi_venno 
and vnb.vbi_cocde = dat.iid_cocde 
and dat.iid_cocde = bas.ibi_cocde and dat.iid_itmno = bas.ibi_itmno
and	dat.iid_cocde = pck.ipi_cocde and dat.iid_itmno = pck.ipi_itmno
and	dat.iid_untcde = pck.ipi_pckunt and dat.iid_inrqty = pck.ipi_inrqty 
and 	dat.iid_mtrqty = pck.ipi_mtrqty
and	pck.ipi_cocde = mup.imu_cocde and pck.ipi_itmno = mup.imu_itmno
and	mup.imu_ventyp = ''D'' and dat.iid_venno = mup.imu_venno and pck.ipi_pckseq = mup.imu_pckseq
and 	mup.imu_fmlopt = fml.yfi_fmlopt and fml.yfi_cocde = mup.imu_cocde 
and	dat.iid_mode = ''UPD'' and dat.iid_stage = ''W'' 
and 	dat.iid_upddat >= cast(''' + @transdate + ''' as datetime) - 1 and dat.iid_upddat <=  cast(''' + @transend + '''  as datetime) + 1
GROUP BY
	bas.ibi_itmno,
	bas.ibi_engdsc, 
	dat.iid_venitm,
	bas.ibi_venno,
	vnb.vbi_vensna,
	bas.ibi_upddat,
	pck.ipi_pckseq,
	pck.ipi_pckunt + ''/ ''+ ltrim(str(pck.ipi_inrqty))+ ''/ '' + ltrim(str(pck.ipi_mtrqty)) + ''/ '' + ltrim(str(pck.ipi_cft,8,2)),
	dat.iid_untcde + ''/ ''+ ltrim(str(dat.iid_inrqty)) + ''/ '' + ltrim(str(dat.iid_mtrqty)) + ''/ '' + ltrim(str(dat.iid_cft,8,2)),
	rtrim(mup.imu_bcurcde) + ltrim(str(mup.imu_basprc,13,4)),
--	dat.iid_ftyprc,
	Case mup.imu_ftyprc when 0 then 0 else (dat.iid_ftyprc - mup.imu_ftyprc) / mup.imu_ftyprc * 100 end,
	hdr.quh_cus1no,	cq1.cbi_cussna,
	hdr.quh_cus2no, cq2.cbi_cussna,
	hdr.quh_qutno,
	hdr.quh_rvsdat,
	hdr.quh_valdat, hdr.quh_valdat,
	hdr.quh_curcde, dtl.qud_cus1sp,
	dtl.qud_basprc,
	ltrim(fml.yfi_fmlopt) +  '' - '' + ltrim(fml.yfi_fml),
	qud_fcurcde, qud_ftyprc
	
HAVING
	pck.ipi_pckunt + ''/ ''+ ltrim(str(pck.ipi_inrqty))+ ''/ '' + ltrim(str(pck.ipi_mtrqty)) + ''/ '' + ltrim(str(pck.ipi_cft,8,2)) <>
	dat.iid_untcde + ''/ ''+ ltrim(str(dat.iid_inrqty)) + ''/ '' + ltrim(str(dat.iid_mtrqty)) + ''/ '' + ltrim(str(dat.iid_cft,8,2))
	OR
	max(rtrim(ISNULL(mup.imu_curcde,'''')) + str(mup.imu_ftyprc)) <>
	max(rtrim(ISNULL(dat.iid_curcde,'''')) + str(dat.iid_ftyprc))

UNION

Select	DISTINCT
	''S'',
--	Header
	bas.ibi_itmno,
	bas.ibi_engdsc, 
	dat.iid_venitm,
	bas.ibi_venno,
	vnb.vbi_vensna,
	bas.ibi_upddat,
	pck.ipi_pckseq,
	pck.ipi_pckunt + ''/ ''+ ltrim(str(pck.ipi_inrqty))+ ''/ '' + ltrim(str(pck.ipi_mtrqty)) + ''/ '' + ltrim(str(pck.ipi_cft,8,2)),
	dat.iid_untcde + ''/ ''+ ltrim(str(dat.iid_inrqty)) + ''/ '' + ltrim(str(dat.iid_mtrqty)) + ''/ '' + ltrim(str(dat.iid_cft,8,2)),
	max(rtrim(ISNULL(mup.imu_curcde,'''')) + ltrim(str(mup.imu_ftyprc,13,4))),
	max(rtrim(ISNULL(dat.iid_curcde,'''')) + ltrim(str(dat.iid_ftyprc,13,4))),
	rtrim(mup.imu_bcurcde) + ltrim(str(mup.imu_basprc,13,4)),
	'''',
--	 dat.iid_ftyprc,
--	new basic price
	Case mup.imu_ftyprc when 0 then  0 else (dat.iid_ftyprc - mup.imu_ftyprc) / mup.imu_ftyprc * 100 end,

--	Detail
	vw.soh_cus1no, cq1.cbi_cussna,
	vw.soh_cus2no, cq2.cbi_cussna,
	vw.soh_ordno,
	vw.soh_issdat,
	vw.sod_shpstr, vw.sod_shpend,
	vw.soh_curcde, vw.sod_untprc,
	vw.sod_itmprc, sum(vw.sod_ordqty),

	ltrim(fml.yfi_fmlopt) +  '' - '' + ltrim(fml.yfi_fml),
	
	vw.sod_fcurcde, vw.sod_ftyprc,
	sum(vw.sod_shpqty),

	isnull(pod_jobord, '''')

---	unit price in diferent

FROM	IMBASINF bas, IMPCKINF pck, SYFMLINF fml, VNBASINF vnb, IMMRKUP mup,
	IMITMDAT dat
	left join vw_select_iar00001 vw on dat.iid_cocde = vw.soh_cocde and dat.iid_itmno =vw. sod_itmno 
	and dat.iid_untcde = vw.sod_pckunt and dat.iid_inrqty = vw.sod_inrctn and dat.iid_mtrqty = vw.sod_mtrctn and vw.soh_ordsts <> ''CLO''
	left join CUBASINF cq1 on dat.iid_cocde = cq1.cbi_cocde and vw.soh_cus1no = cq1.cbi_cusno
	left join CUBASINF cq2 on dat.iid_cocde = cq2.cbi_cocde and vw.soh_cus2no = cq2.cbi_cusno
	left join POORDDTL on dat.iid_cocde = pod_cocde and vw.sod_purord = pod_purord and vw.sod_purseq = pod_purseq
WHERE	dat.iid_cocde = ''' + @cocde + '''
and bas.ibi_itmno IN (' + @itmlst + ')
and bas.ibi_venno = vnb.vbi_venno 
and vnb.vbi_cocde = dat.iid_cocde 
and dat.iid_cocde = bas.ibi_cocde and dat.iid_itmno = bas.ibi_itmno
and	dat.iid_cocde = pck.ipi_cocde and dat.iid_itmno = pck.ipi_itmno
and	dat.iid_untcde = pck.ipi_pckunt and dat.iid_inrqty = pck.ipi_inrqty 
and 	dat.iid_mtrqty = pck.ipi_mtrqty
and	pck.ipi_cocde = mup.imu_cocde and pck.ipi_itmno = mup.imu_itmno
and	mup.imu_ventyp = ''D'' and dat.iid_venno = mup.imu_venno and pck.ipi_pckseq = mup.imu_pckseq
and 	mup.imu_fmlopt = fml.yfi_fmlopt and fml.yfi_cocde = mup.imu_cocde 
and	dat.iid_mode = ''UPD'' and dat.iid_stage = ''W'' 
and 	dat.iid_upddat >= cast(''' + @transdate  + ''' as datetime) -1 and dat.iid_upddat <= cast(''' + @transend  + ''' as datetime) + 1
GROUP BY
	bas.ibi_itmno,
	bas.ibi_engdsc, 
	dat.iid_venitm,
	bas.ibi_venno,
	vnb.vbi_vensna,
	bas.ibi_upddat,
	pck.ipi_pckseq,
	pck.ipi_pckunt + ''/ ''+ ltrim(str(pck.ipi_inrqty))+ ''/ '' + ltrim(str(pck.ipi_mtrqty)) + ''/ '' + ltrim(str(pck.ipi_cft,8,2)),
	dat.iid_untcde + ''/ ''+ ltrim(str(dat.iid_inrqty)) + ''/ '' + ltrim(str(dat.iid_mtrqty)) + ''/ '' + ltrim(str(dat.iid_cft,8,2)),	rtrim(mup.imu_bcurcde) + ltrim(str(mup.imu_basprc,13,4)),
--	dat.iid_ftyprc,
	Case mup.imu_ftyprc when 0 then  0 else (dat.iid_ftyprc - mup.imu_ftyprc) / mup.imu_ftyprc * 100 end,
	vw.soh_cus1no, cq1.cbi_cussna,
	vw.soh_cus2no, cq2.cbi_cussna,
	vw.soh_ordno,
	vw.soh_issdat,
	vw.sod_shpstr, vw.sod_shpend,
	vw.soh_curcde, vw.sod_untprc,
	vw.sod_itmprc, vw.sod_ordqty,
	ltrim(fml.yfi_fmlopt) +  '' - '' + ltrim(fml.yfi_fml),
	vw.sod_fcurcde, vw.sod_ftyprc,
	pod_jobord
HAVING
	pck.ipi_pckunt + ''/ ''+ ltrim(str(pck.ipi_inrqty))+ ''/ '' + ltrim(str(pck.ipi_mtrqty)) + ''/ '' + ltrim(str(pck.ipi_cft,8,2)) <>
	dat.iid_untcde + ''/ ''+ ltrim(str(dat.iid_inrqty)) + ''/ '' + ltrim(str(dat.iid_mtrqty)) + ''/ '' + ltrim(str(dat.iid_cft,8,2))
	OR
	max(rtrim(ISNULL(mup.imu_curcde,'''')) + ltrim(str(mup.imu_ftyprc,13,4))) <>
	max(rtrim(ISNULL(dat.iid_curcde,'''')) + ltrim(str(dat.iid_ftyprc,13,4)))

')
SET ANSI_WARNINGS ON



GO
GRANT EXECUTE ON [dbo].[sp_select_IAR00001_bak] TO [ERPUSER] AS [dbo]
GO
