/****** Object:  StoredProcedure [dbo].[sp_select_POR00003]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00003]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00003]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








-- Checked by Allan Yuen at 27/07/2003
-- 19/09/2003 Allan Yuen Fix select with po company code.

/*
=============================================================================
Modification History
=============================================================================
Modified on	Modified by	Description
=============================================================================
20th Aug , 2004	Lester Wu		Retrieve Primary Customer No and Job No
				Add sorting by Job No and Item No
1st June, 2005	Lester Wu		Cater PO Dtl with same item no, color but different packing 

=============================================================================
*/

--sp_select_POR00003 'UCP','PR0202457-B001','PR03000090-B001','Y'

CREATE PROCEDURE [dbo].[sp_select_POR00003]
@cocde	nvarchar(6),	
@POfrom	nvarchar(20),	
@POto		nvarchar(20),
@Sup0		nvarchar(1)
,
@Revised		nvarchar(1)

AS
Select	
	@cocde as 'cocde',
	-- VNBASINF
	ven.vbi_cocde,
	ven.vbi_vennam,
	ven.vbi_venno,
	-- SYSETINF
	sys.ysi_dsc,
	sys.ysi_typ,
	sys2.ysi_dsc as 'ysi_dscs',
	-- POBOMHDR
	hdr.pbh_cocde,
	hdr.pbh_bvencty,
	hdr.pbh_oriven,
	hdr.pbh_bompo,
	hdr.pbh_bvenno,
	hdr.pbh_bvenadr,
	hdr.pbh_bvenstt,
	hdr.pbh_bvenpst,
	hdr.pbh_ctp1,
	hdr.pbh_purord,	
	pbh_issdat = ltrim(str(datepart(mm,hdr.pbh_issdat))) + '/' + ltrim(str(datepart(dd,hdr.pbh_issdat))) + '/' + ltrim(str(datepart(yyyy,hdr.pbh_issdat))),
	pbh_rvsdat = ltrim(str(datepart(mm,hdr.pbh_rvsdat))) + '/' + ltrim(str(datepart(dd,hdr.pbh_rvsdat))) + '/' + ltrim(str(datepart(yyyy,hdr.pbh_rvsdat))),
	pbh_candat = ltrim(str(datepart(mm,hdr.pbh_candat))) + '/' + ltrim(str(datepart(dd,hdr.pbh_candat))) + '/' + ltrim(str(datepart(yyyy,hdr.pbh_candat))),
	hdr.pbh_cuspo,
	hdr.pbh_refno,
	hdr.pbh_prctrm,
	hdr.pbh_paytrm,
	hdr.pbh_ttlamt,
	hdr.pbh_disprc,
	hdr.pbh_disamt,
	hdr.pbh_rmk,
	hdr.pbh_curcde,
	-- POBOMDTL
	dtl.pbd_cocde,
	dtl.pbd_bompo,
	dtl.pbd_regitm,
	dtl.pbd_refpo,
	dtl.pbd_itmno,
	dtl.pbd_venitm,
	dtl.pbd_engdsc,
	dtl.pbd_chndsc,
	dtl.pbd_vencol, 
	dtl.pbd_vcodsc,
	dtl.pbd_untcde,	
	dtl.pbd_adjqty,
	dtl.pbd_negprc,
	pbd_bomamt = Round(dtl.pbd_adjqty * dtl.pbd_negprc,2),
	dtl.pbd_ftyprc,
	pbd_shpstr = convert(char(10), pbd_shpstr, 101),
	pbd_shpend = convert(char(10), pbd_shpend, 101),
	pbd_ordqty = str(dtl.pbd_ordqty),
	-- SYSETINF sys5 
	sys5.ysi_dsc as 'ysi_dsc05',
	-- IMVENINF
	imv.ivi_venitm,
	isnull(poh.poh_prmcus,'') as 'PriCustNo',	--6 character
	isnull(pod.pod_jobord,'') as 'JobNo',	--20 character
	@Revised as 'revised'
From	POBOMHDR hdr, POBOMDTL dtl
	left join PODTLBOM pdb (nolock) on 
		dtl.pbd_cocde = pdb.pdb_cocde and 
		dtl.pbd_bompo = pdb.pdb_bompno and 
		dtl.pbd_bomseq = pdb_bpolne
	
	left join POORDDTL pod (nolock) on 	
		pod_cocde = pbd_cocde and
		pod_purord = pdb_purord and
		pod_purseq = pdb_seq
	
	
	left join POORDHDR poh (nolock) on
		pod.pod_cocde = poh.poh_cocde and
		pod.pod_purord = poh.poh_purord
	, VNBASINF ven, SYSETINF sys, SYSETINF sys2, SYSETINF sys5, IMVENINF imv
----------------------------------------------------------------------------------------------------------

Where 
	hdr.pbh_cocde = dtl.pbd_cocde and
	hdr.pbh_bompo = dtl.pbd_bompo and
	hdr.pbh_bvenno = ven.vbi_venno and
	hdr.pbh_bvencty = sys.ysi_cde and
	sys.ysi_typ = '02' and
	sys2.ysi_cde = hdr.pbh_paytrm and
	sys2.ysi_typ = '04' and
	sys5.ysi_cde = dtl.pbd_untcde and
	sys5.ysi_typ = '05' and
	imv.ivi_itmno = dtl.pbd_regitm  and
	imv.ivi_venno = pbh_oriven and
	((@Sup0 = 'Y' and dtl.pbd_ordqty > 0) or @Sup0 = 'N') and
	hdr.pbh_bompo >= @POfrom and hdr.pbh_bompo <= @POto and
	hdr.pbh_cocde = @cocde
	and 
(case poh_pursts when 'OPE' then 'N' 
		 when 'REL' then case poh_signappflg when 'Y' then 'Y' else 'N' end
		 when 'CLO' then 'Y' end) = 'Y'

order by pbh_bompo, isnull(pod.pod_jobord,''), pbd_itmno
-------------------------------------------------






GO
GRANT EXECUTE ON [dbo].[sp_select_POR00003] TO [ERPUSER] AS [dbo]
GO
