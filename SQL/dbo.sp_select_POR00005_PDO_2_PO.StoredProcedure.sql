/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_PDO_2_PO]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00005_PDO_2_PO]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_PDO_2_PO]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





/*
=================================================================
Program ID	: sp_select_POR00005_PDO_2_PO
Description	: Retrieve PO Data for PDO Report Generation
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-11-01 	David Yue		SP Created
=================================================================
*/


CREATE   PROCEDURE [dbo].[sp_select_POR00005_PDO_2_PO]

@cocde		nvarchar(6),	
@jobno		nvarchar(25),
@batch		nvarchar(23)

AS

declare	@bufferdays int
set @bufferdays = 14

declare
@yco_conam	varchar(50),	
@yco_addr	nvarchar(200),
--@yco_logoimgpth	varchar(100),
@yco_phoneno	varchar(50),
@yco_faxno	varchar(50)

-- Read Company Information --
select	@yco_conam = yco_conam,	
	@yco_addr = yco_addr,
	--@yco_logoimgpth = yco_logoimgpth, 
	@yco_phoneno = yco_phoneno,
	@yco_faxno = yco_faxno
from	SYCOMINF (nolock)
where	yco_cocde = @cocde
------------------------------

select	@cocde as 'cocde',
	@yco_conam as 'conam',
	@yco_addr as 'yco_addr',
	@yco_phoneno as 'yco_phoneno',
	@yco_faxno as 'yco_faxno',
	@batch as 'batch',
	-- Vendors
	case when isnull(cv.vbi_venchnnam,'') <> '' then cv.vbi_venchnnam else cv.vbi_vennam end as 'cv_vennam',
	cv.vbi_vensna as 'cv_vensna',
	case when isnull(pv.vbi_venchnnam,'') <> '' then pv.vbi_venchnnam else pv.vbi_vennam end as 'pv_vennam',
	pv.vbi_vensna as 'pv_vensna',
	-- Customer
	cbi_cussna,
	-- PO Header
	poh_porctp,
	poh_prmcus,
	poh_venno,
	right('0' + ltrim(str(datepart(mm, poh_credat))),2) + '/' + right('0' + ltrim(str(datepart(dd, poh_credat))),2) + '/' + ltrim(str(datepart(yyyy, poh_credat))) as 'poh_credat',
	right('0' + ltrim(str(datepart(mm, poh_issdat))),2) + '/' + right('0' + ltrim(str(datepart(dd, poh_issdat))),2) + '/' + ltrim(str(datepart(yyyy, poh_issdat))) as 'poh_issdat',
	right('0' + ltrim(str(datepart(mm, poh_pocdat))),2) + '/' + right('0' + ltrim(str(datepart(dd, poh_pocdat))),2) + '/' + ltrim(str(datepart(yyyy, poh_pocdat))) as 'poh_pocdat',
	right('0' + ltrim(str(datepart(mm, poh_pocdatend))),2) + '/' + right('0' + ltrim(str(datepart(dd, poh_pocdatend))),2) + '/' + ltrim(str(datepart(yyyy, poh_pocdatend))) as 'poh_pocdatend',
	poh_cuspno,
	poh_reppno,
	right('0' + ltrim(str(datepart(mm, poh_cpodat))),2) + '/' + right('0' + ltrim(str(datepart(dd, poh_cpodat))),2) + '/' + ltrim(str(datepart(yyyy, poh_cpodat))) as 'poh_cpodat',
	poh_purord,
	poh_curcde,
	ltrim(rtrim(case @cocde when 'EW' then '' when 'HX' then '' when 'TT' then 'This P.O. is issued on behalf of NEW LEADER. ' + char(10) +
		char(13) + '此張採購單乃代表 「聯通」發出。' + char(10) + char(13) else case cv.vbi_bvennam when 'NO' then '' else 
		'This production note is issued on behalf of ' + cv.vbi_bvennam + '. ' + char(10) + char(13) + '此張生產單乃代表 「' +cv.vbi_bvennamc + 
		'」發出。' + char(10) + char(13) end end + case poh_cusctn when 0 then '' else 'TOTAL CTN# - ' + ltrim(rtrim(str(poh_cusctn))) + Char(10) + 
		char(13) end + case poh_dest when '' then '' else 'DESTINATION: ' + poh_dest + char(10) + char(13) end + poh_rmk))  as 'poh_rmk',
	-- PO Detail
	pod_scno,
	pod_itmno,
	pod_venitm,
	pod_engdsc,
	pod_chndsc,
	ysi_dsc as 'pod_untcde',
	pod_inrctn,
	pod_mtrctn,
	pod_cubcft,
	pod_jobord,
	pod_hrmcde,
	pod_typcode,
	pod_code1,
	pod_code2,
	pod_code3,
	pod_dept,
	pod_dtyrat,
	pod_cusitm,
	pod_cuscol,
	pod_cussku,
	pod_cuspno,
	pod_respno,
	pod_seccusitm,
	pod_cususdcur,
	pod_cususd,
	pod_cuscadcur,
	pod_cuscad,
	pod_vencol,
	pod_coldsc,
	pod_purseq,
	ltrim(rtrim(case isnull(sod_pjobno, '') when '' then '' else '取代 Job # ' + sod_pjobno + char(10) + char(13) end + pod_rmk)) as 'pod_rmk',
	pod_itmno + ltrim(pod_engdsc) +  ysi_dsc + str(pod_inrctn,10,0) + str(pod_mtrctn,10,0) + str(pod_cubcft,10,2) as 'podKey',
	ltrim(str(datepart(mm, pod_shpstr))) + '/' + ltrim(str(datepart(dd, pod_shpstr))) + '/' + ltrim(str(datepart(yyyy, pod_shpstr))) as 'pod_shpstr',
	ltrim(str(datepart(mm, pod_shpstr))) + '/' + ltrim(str(datepart(dd, pod_shpstr))) + '/' + ltrim(str(datepart(yyyy, pod_shpstr))) as 'pod_shpend',
	case pod_candat when '1900-01-01' then '' else right('0' + ltrim(str(datepart(mm, pod_candat))), 2) + '/' + right('0' + ltrim(str(datepart(dd, pod_candat))), 2) + '/' + ltrim(str(datepart(yyyy, pod_candat))) end as 'pod_candat',
	ltrim(str(datepart(mm, pod_shpstr - @bufferdays))) + '/' + ltrim(str(datepart(dd, pod_shpstr - @bufferdays))) + '/' + ltrim(str(datepart(yyyy, pod_shpstr - @bufferdays))) as 'fac_shpstr',
	pod_ctnstr,
	pod_ctnend,
	pod_ttlctn,
	pod_ordqty,
	pod_pckitr,
	pod_prdven,
	pod_prdsubcde,
	pod_ftyprc,
	-- Shipmark
	isNull(main.psm_imgpth,'') as 'MainMrk',
	--replace(Case isNull(main.psm_engdsc, '') When '' then '' Else 'ξ' + replace(main.psm_engdsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end, ',','，') as 'MainEng',
	--replace(Case isNull(main.psm_chndsc, '') When '' then '' Else 'ξ' + replace(main.psm_chndsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end, ',','，') as 'MainChn',
	isnull(main.psm_engdsc,'') as 'MainEng',
	isnull(main.psm_chndsc,'') as 'MainChn',
	replace(isNull(main.psm_chnrmk,''), ',','，') as 'MainChnRmk',
	replace(isNull(main.psm_engrmk,''), ',','，') as 'MainEngRmk',
	isNull(side.psm_imgpth,'') as 'SideMrk',
	--replace(Case isNull(side.psm_engdsc, '') When '' then '' Else 'ξ' + replace(side.psm_engdsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end, ',','，') as 'SideEng',
	--replace(Case isNull(side.psm_chndsc, '') When '' then '' Else 'ξ' + replace(side.psm_chndsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end, ',','，') as 'SideChn',
	isnull(side.psm_engdsc,'') as 'SideEng',
	isnull(side.psm_chndsc,'') as 'SideChn',
	replace(isNull(side.psm_chnrmk,''), ',','，') as 'SideChnRmk',
	replace(isNull(side.psm_engrmk,''), ',','，') as 'SideEngRmk',
	isNull(innr.psm_imgpth,'') as 'InnerMrk',
	--replace(Case isNull(innr.psm_engdsc, '') When '' then '' Else 'ξ' + replace(innr.psm_engdsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end, ',','，') as 'InnerEng',
	--replace(Case isNull(innr.psm_chndsc, '') When '' then '' Else 'ξ' + replace(innr.psm_chndsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end, ',','，') as 'InnerChn',
	isnull(innr.psm_engdsc,'') as 'InnerEng',
	isnull(innr.psm_chndsc,'') as 'InnerChn',
	replace(isNull(innr.psm_chnrmk,''), ',','，') as 'InnerChnRmk',
	replace(isNull(innr.psm_engrmk,''), ',','，') as 'InnerEngRmk',
	sod_subcde,
	'N' as 'assortment',
	'N' as 'attachlist',
	'N' as 'attachment',
	sod_zorvbeln,
	sod_zorposnr,
	sod_ordno,
	sod_ordseq
	
from	--POJBBDTL (nolock)
	 POORDDTL (nolock) 
		
	join POORDHDR (nolock) on
		poh_cocde = pod_cocde and
		poh_purord = pod_purord
	left join VNBASINF cv (nolock) on
		cv.vbi_venno = poh_venno
	left join VNBASINF pv (nolock) on
		pv.vbi_venno = pod_prdven
	left join CUBASINF (nolock) on
		cbi_cusno = poh_prmcus
	left join SCORDDTL (nolock) on
		sod_cocde = pod_cocde and
		sod_ordno = pod_scno and
		sod_ordseq = pod_scline
	join SYSETINF (nolock) on
		ysi_typ = '05' and
		ysi_cde = pod_untcde
	left join POSHPMRK main (nolock) on
		main.psm_cocde = pod_cocde and
		main.psm_purord = pod_purord and
		main.psm_shptyp = 'M'
	left join POSHPMRK side (nolock) on
		side.psm_cocde = pod_cocde and
		side.psm_purord = pod_purord and
		side.psm_shptyp = 'S'
	left join POSHPMRK innr (nolock) on
		innr.psm_cocde = pod_cocde and
		innr.psm_purord = pod_purord and
		innr.psm_shptyp = 'I'
where	
	pod_cocde = @cocde and
	pod_jobord = @jobno
	--pjd_confrm = 'Y'
--order by poh_venno





GO
GRANT EXECUTE ON [dbo].[sp_select_POR00005_PDO_2_PO] TO [ERPUSER] AS [dbo]
GO
