/****** Object:  StoredProcedure [dbo].[sp_select_SCR00001_ca]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCR00001_ca]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCR00001_ca]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO















/*
=================================================================
Program ID	: sp_select_SCR00001_ca
Description	: Retrieve Details for SCR00001 Report
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-08-26	David Yue		SP Created
2013-10-21	David Yue		Add Detail Cancel Date
=================================================================
*/


CREATE     PROCEDURE [dbo].[sp_select_SCR00001_ca]
@cocde		nvarchar(6),	
@Heading	nvarchar(4),	
@fty		nvarchar(3),
@ShpFmt		nvarchar(6),
@Sup0		nvarchar(1),
@SCfrom		nvarchar(20),	
@SCto		nvarchar(20),
@sortBy		nvarchar(4),
@UM		nvarchar(3),
@CRmk		nvarchar(1), 
@Rvs		nvarchar(1),
@HTSU		nvarchar(1),
@CV		nvarchar(1),
@printcusals	nvarchar(1),
@printPDF	nvarchar(1),
@usrid		nvarchar(30),
@doctyp		nvarchar(2),
@prityp		nvarchar(20)

AS

declare @tmp_varchar30 varchar(30)
set @tmp_varchar30 = ''

declare @tmp_varchar50 varchar(50)
set @tmp_varchar50 = ''

declare @tmp_varchar100 varchar(100)
set @tmp_varchar100 = ''

declare @tmp_varchar200 varchar(200)
set @tmp_varchar200 = ''

declare @tmp_varchar300 varchar(300)
set @tmp_varchar300 = ''

declare @tmp_varchar400 varchar(400)
set @tmp_varchar400 = ''

declare @tmp_varchar600 varchar(600)
set @tmp_varchar600 = ''

declare @tmp_varchar800 varchar(800)
set @tmp_varchar800 = ''

declare @tmp_varchar1600 varchar(1600)
set @tmp_varchar1600 = ''

declare @tmp_varchar2000 varchar(2000)
set @tmp_varchar2000 = ''

declare @tmp_varchar2400 varchar(2400)
set @tmp_varchar2400 = ''

declare @tmp_nvarchar300 nvarchar(300)
set @tmp_nvarchar300 = ''


declare 
@yco_conam	varchar(50),
@yco_addr	varchar(200),
@yco_logoimgpth	varchar(100),
@yco_phoneno	varchar(50),
@yco_faxno	varchar(50)

select	@yco_conam = yco_conam,	
	@yco_addr = yco_addr,
	@yco_logoimgpth = yco_logoimgpth, 
	@yco_phoneno = yco_phoneno,
	@yco_faxno = yco_faxno 
from	SYCOMINF (nolock)
where	yco_cocde = @cocde

declare
@ftyprc		int,
@sortbyWhich	varchar(6),
@feed		char(2)

set @feed = char(13) + char(10)

select	-- Parameter
	@cocde as 'cocde',
	@yco_conam as 'conam',
	@yco_addr as 'addr',
	@yco_logoimgpth as 'logoimgpth',
	@yco_phoneno as 'phoneno',
	@yco_faxno as 'faxno', 
	@Heading as 'heading',	
	@fty as 'fty',
	@ShpFmt as 'shpFmt',	
	@Sup0 as 'Sup0',	
	@sortBy as 'sortBy',
	@UM as 'UM',
	@prityp as 'price_type',
	case soh_ordsts when 'REL' then @Rvs when 'CLO' then @Rvs when 'CAN' then @Rvs else @Rvs + 'D' end as 'Rvs',
	case @sortBy When 'CUST' then sod_cusitm else '' end as 'CUST',
	case when @printcusals = '1' and sod_cusstyno <> '' then sod_cusstyno + 'x' + sod_itmno
		else ltrim(left(case when sod_itmtyp = 'ASS' then sod_itmno else dbo.groupnewitmno(sod_itmno) end +'          ',20)) end +
		case when isnull(sod_custum,'') <>'' then sod_custum else case when sod_contopc = 'Y' then 'PC' else ltrim(sod_pckunt) end end + 'x' +
		case when sod_contopc = 'Y' then  convert(varchar(40),sod_inrctn * sod_conftr) else convert(varchar(20),sod_inrctn) end + 'x' + 
		case when sod_contopc = 'Y' then  convert(varchar(40),sod_mtrctn * sod_conftr) else convert(varchar(20),sod_mtrctn) end + 'x' + 
		convert(varchar(20),sod_cft)+ 'x' + sod_ftyprctrm + 'x' + sod_hkprctrm + 'x' + sod_trantrm +  'x' + 
		case when sod_contopc = 'Y' then convert(varchar(40),sod_netuntprc/sod_conftr) else convert(varchar(20),sod_netuntprc) end + 'x' +
		ltrim(sod_itmdsc) + 'x' + ltrim(sod_cuspo) as 'sodKey',
	-- Primary Customer
	cus1.cbi_cusno,
/*
	cus1.cbi_cusnam,
	cus1.cbi_cussna,
--	isNull(cus2.cbi_cusnam,'') as 'cbi_cusnamSnd',
*/
	@tmp_varchar50 as 'cbi_cusnam',
	@tmp_varchar30 as 'cbi_cussna',

	-- Secondary Customer
--	isNull(cus2.cbi_cusnam,'') as 'cbi_cusnamSnd',
	@tmp_varchar50 as 'cbi_cusnamSnd',

	-- Shipping Address
	shpadr.ysi_dsc as 'second_shpcty',
	-- Billing Address
	biladr.ysi_cocde,
	biladr.ysi_dsc,
	-- Header
	soh_bilcty,

--	soh_biladr,
	@tmp_varchar200 as 'soh_biladr',

	soh_bilstt,
	soh_bilzip,
	soh_cttper,
	soh_ordno,
	soh_candat = ltrim(str(datepart(mm,soh_candat))) + '/' + ltrim(str(datepart(dd,soh_candat))) + '/' + ltrim(str(datepart(yyyy,soh_candat))),
	soh_issdat = ltrim(str(datepart(mm,soh_issdat))) + '/' + ltrim(str(datepart(dd,soh_issdat))) + '/' + ltrim(str(datepart(yyyy,soh_issdat))),
	soh_rvsdat = ltrim(str(datepart(mm,soh_rvsdat))) + '/' + ltrim(str(datepart(dd,soh_rvsdat))) + '/' + ltrim(str(datepart(yyyy,soh_rvsdat))),
	soh_cuspo,	
	soh_resppo,	
	soh_cpodat = ltrim(str(datepart(mm,soh_cpodat))) + '/' + ltrim(str(datepart(dd,soh_cpodat))) + '/' + ltrim(str(datepart(yyyy,soh_cpodat))),
	--case Len(ltrim(replace(replace(isnull(soh_rmk,''), char(13), ''), char(10), ''))) when 0 then '0' else '1' end as 'soh_rmk',
/*
	case len(ltrim(replace(replace(isnull(soh_rmk,'') + case soh_cusctn when 0 then '' else ltrim(rtrim(str(soh_cusctn))) end, char(13), ''), char(10), ''))) when 0 then '0' else '1' end as 'soh_rmk',
	case soh_cusctn when 0 then '' else 'TOTAL CTN# - ' + ltrim(rtrim(str(soh_cusctn))) + case (soh_dest + soh_rmk) when '' then '' else @feed end end +
		case ltrim(rtrim(soh_dest)) when '' then '' else 'DESTINATION: ' + ltrim(rtrim(soh_dest)) + case (ltrim(rtrim(soh_rmk))) when '' then '' else @feed end end +
		soh_rmk as 'soh_rmk_Memo',
*/
	@tmp_varchar400 as 'soh_rmk',
	@tmp_varchar2400 as 'soh_rmk_Memo',

	soh_ttlamt,

--	soh_shpadr,
	@tmp_varchar200 as 'soh_shpadr',

	soh_shpstt,
	soh_shpcty,
	soh_shpzip,
	-- Agent
	yai_stnam,
	-- PV
	pv.vbi_vensna,
	pv.vbi_venno,
	-- Detail
	sod_purord,
	case when sod_contopc = 'Y' then sod_netuntprc / sod_conftr else sod_netuntprc end as 'sod_netuntprc',
	sod_ordno,
	sod_colcde,
	sod_ordseq,
	case when @printcusals = '1' and sod_cusstyno <> '' then sod_cusstyno
		else case when sod_itmtyp = 'ASS' then sod_itmno else dbo.groupnewitmno(sod_itmno) end end as 'sod_itmno', 
	sod_cusitm,
/*
	sod_itmdsc,
	sod_itmdsc as 'sod_itmdsc_Memo',
*/
	@tmp_varchar800 as 'sod_itmdsc',
	@tmp_varchar800 as 'sod_itmdsc_Memo',

	sod_cususdcur,
	sod_cususd,
	sod_cuscadcur,
	sod_cuscad,
	sod_cuspo,
	sod_resppo,	
	case when sod_contopc = 'Y' then str(sod_inrctn * sod_conftr) else  str(sod_inrctn) end as 'sod_inrctn',
	case when sod_contopc = 'Y' then str(sod_mtrctn * sod_conftr) else  str(sod_mtrctn) end as 'sod_mtrctn',
	sod_cft as 'sod_cft_num',
	sod_ftyprctrm,
	sod_hkprctrm,
	sod_trantrm,
	round(sod_cft * sod_ttlctn,2) as 'line_cft',
/*
	ltrim(replace(replace(sod_rmk, char(13), ''), char(10), '')) + case sod_moqchg when 0 then '' else 'A' end as 'sod_rmrk',
	sod_rmk + case rtrim(sod_rmk) when  ''  then '' else @feed end + case sod_moqchg when 0 then '' else
	'Original Unit Price is ' + rtrim(sod_curcde) + cast(cast(sod_untprc as decimal(13,4)) as varchar(13)) +
	', additional MOQ Charges ' + CAST(CAST(sod_moqchg as int) as varchar(10)) + '%' end as 'sod_Item_rmk',
*/
	@tmp_varchar400 as 'sod_rmrk',
	@tmp_varchar400 as 'sod_Item_rmk',
	@tmp_nvarchar300 as 'sod_pormk',

	sod_cuscol,
--	sod_coldsc,
	@tmp_varchar300 as 'sod_coldsc',

	sod_cussku,
	sod_code1,
	sod_code2,
	sod_code3,
	sod_hrmcde,	
	case when isnull(sod_custum,'') <>'' then sod_custum else case when sod_contopc = 'Y' then 'PC' else sod_pckunt end end as 'sod_pckunt',
	case when sod_contopc = 'Y' then sod_ordqty * sod_conftr else sod_ordqty end as 'sod_ordqty',
	str(case when sod_contopc = 'Y' then sod_ordqty * sod_conftr else sod_ordqty end) as 'sod_ordqtystr',
	sod_curcde,
	sod_ordqty * sod_selprc as 'ordqty_selprc',
	sod_venno,
	sod_venitm,
/*
	isNull(sod_pckitr,'') as 'sod_pckitr',
	sod_pckitr as 'sod_pckitr_Memo',
*/
	@tmp_varchar600 as 'sod_pckitr',
	@tmp_varchar600 as 'sod_pckitr_Memo',

	sod_typcode,
	str(sod_ttlctn) as 'sod_ttlctn',
	sod_fcurcde,
	sod_ftyprc,
	sod_ftyprc_encode = replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(cast(sod_ftyprc as nvarchar(17)),'.', 'D'), '0','K'), '9', 'H'),  '8', 'R') , '7', 'E'), '6', 'T'), '5', 'N'), '4', 'I'), '3', 'P'), '2', 'C'), '1', 'U'),
	sod_curcde_encode = replace(replace(sod_fcurcde,'HKD','2'),'USD','1'),
	str(sod_ctnstr) as 'sod_ctnstr',
	str(sod_ctnend) as 'sod_ctnend',	
	convert(char(10), sod_shpstr, 101) as 'sod_shpstr',
	convert(char(10), sod_shpend, 101) as 'sod_shpend',
	sod_shpstrMM = replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(ltrim(str(datepart(mm,sod_shpstr))),'10','Oct'),'11','Nov'),'12','Dec'),'1','Jan'),'2','Feb'),'3','Mar'),'4','Apr'),'5','May'),'6','Jun'),'7','Jul'),'8','Aug'),'9','Sep'),	
	sod_shpendMM = replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(ltrim(str(datepart(mm,sod_shpend))),'10','Oct'),'11','Nov'),'12','Dec'),'1','Jan'),'2','Feb'),'3','Mar'),'4','Apr'),'5','May'),'6','Jun'),'7','Jul'),'8','Aug'),'9','Sep'),	
	sod_shpstrDD = datepart(dd,sod_shpstr),
	sod_shpendDD = datepart(dd,sod_shpend),
 	sod_shpstrYYYY = ltrim(str(datepart(yyyy,sod_shpstr))),
	sod_shpendYYYY = ltrim(str(datepart(yyyy,sod_shpend))),
	case sod_candat when '1900-01-01' then '' else convert(char(10), sod_candat, 101) end as 'sod_candat',
	-- Sales Rep
	yup_usrnam + ' (' + soh_saltem + ')' as 'ourSal',
	-- Shipmark
	isNull(shpmrkM.ssm_imgpth,'') as 'psm_imgpth_M',
	isNull(shpmrkI.ssm_imgpth,'') as 'psm_imgpth_I',
	isNull(shpmrkS.ssm_imgpth,'') as 'psm_imgpth_S',
/*
	ltrim(replace(replace(isnull(shpmrkM.ssm_engdsc,''), char(13), ''), char(10), '')) as 'MainEng',
	isNull(shpmrkM.ssm_engdsc,'') as 'MainEng_Memo',	
	ltrim(replace(replace(isnull(shpmrkI.ssm_engdsc,''), char(13), ''), char(10), '')) as 'InnerEng',
	isNull(shpmrkI.ssm_engdsc,'') as 'InnerEng_Memo',	
	ltrim(replace(replace(isnull(shpmrkS.ssm_engdsc,''), char(13), ''), char(10), '')) as 'SideEng',
	isNull(shpmrkS.ssm_engdsc,'') as 'SideEng_Memo',
*/
	@tmp_varchar1600 as 'MainEng',
	@tmp_varchar1600 as 'MainEng_Memo',	
	@tmp_varchar1600 as 'InnerEng',
	@tmp_varchar1600 as 'InnerEng_Memo',	
	@tmp_varchar1600 as 'SideEng',
	@tmp_varchar1600 as 'SideEng_Memo',

	case @CRmk when 'Y' then ltrim(replace(replace(isnull(shpmrkM.ssm_chndsc,''), char(13), ''), char(10), '')) else '' end as 'MainChnDsc',
	case @CRmk when 'Y' then ltrim(replace(replace(isnull(shpmrkI.ssm_chndsc,''), char(13), ''), char(10), '')) else '' end as 'InnerChnDsc',
	case @CRmk when 'Y' then ltrim(replace(replace(isnull(shpmrkS.ssm_chndsc,''), char(13), ''), char(10), '')) else '' end as 'SideChnDsc',
	isNull(shpmrkM.ssm_chndsc,'') as 'MainChn_Memo',
	isNull(shpmrkI.ssm_chndsc,'') as 'InnerChn_Memo',
	isNull(shpmrkS.ssm_chndsc,'') as 'SideChn_Memo',
	case @CRmk when 'Y' then ltrim(replace(replace(isnull(shpmrkM.ssm_chnrmk,''), char(13), ''), char(10), '')) else '' end as 'MainChnRmk',
	case @CRmk when 'Y' then ltrim(replace(replace(isnull(shpmrkI.ssm_chnrmk,''), char(13), ''), char(10), '')) else '' end as 'InnerChnRmk',
	case @CRmk when 'Y' then ltrim(replace(replace(isnull(shpmrkS.ssm_chnrmk,''), char(13), ''), char(10), '')) else '' end as 'SideChnRmk',
	isNull(shpmrkM.ssm_chnrmk,'') as 'MainChnRmk_Memo',
	isNull(shpmrkI.ssm_chnrmk,'') as 'InnerChnRmk_Memo',	
	isNull(shpmrkS.ssm_chnrmk,'') as 'SideChnRmk_Memo',
/*
	case len(ltrim(replace(replace(isnull(shpmrkM.ssm_engrmk,''), char(13), ''), char(10), ''))) when 0 then '0' else '1' end as 'MERk',
	case len(ltrim(replace(replace(isnull(shpmrkI.ssm_engrmk,''), char(13), ''), char(10), ''))) when 0 then '0' else '1' end as 'IERk',
	case len(ltrim(replace(replace(isnull(shpmrkS.ssm_engrmk,''), char(13), ''), char(10), ''))) when 0 then '0' else '1' end as 'SERk',
	ltrim(isnull(shpmrkM.ssm_engrmk,'')) as 'MainEngRmk',
	ltrim(isnull(shpmrkI.ssm_engrmk,'')) as 'InnerEngRmk',
	ltrim(isnull(shpmrkS.ssm_engrmk,'')) as 'SideEngRmk',
*/
'0' as 'MERk',
'0' as 'IERk',
'0' as 'SERk',
@tmp_varchar2000 as 'MainEngRmk',
@tmp_varchar1600 as 'InnerEngRmk',
@tmp_varchar1600 as 'SideEngRmk',
	prctrm.ysi_dsc as 'paytrm',
	paytrm.ysi_dsc as 'paytrmDesc',
	case when isnull(sod_custum,'') <> '' then sod_custum else case when sod_contopc = 'Y' then 'PC' else custUM.ysi_dsc end end as 'unit',
	sod_dept as 'dept',
	sod_dtyrat as 'dtyrat',
	case sod_moqchg when 0 then '' else 'Original Unit Price is ' + rtrim(sod_curcde) + cast(cast(sod_untprc as decimal(9,2)) as varchar(13)) +
		', add additional MOQ Charges ' + cast(cast(sod_moqchg as decimal(6,2)) as varchar(10)) + '%' end as 'EXTMRK',
	-- Secondary Customer Item No.
	isnull(sod_seccusitm,'') as 'SecCusItem' ,
	-- Alias Item No.
	isnull(sod_alsitmno,'') as 'sod_alsitmno' ,
	isnull(sod_alscolcde,'') as 'sod_alscolcde' ,
	case when @printcusals = '1' and sod_cusstyno <> '' then '' else case when sod_itmtyp = 'ASS' then isnull(sod_alscolcde,'')
		else dbo.groupnewitmcol(sod_itmno,isnull(sod_alscolcde,''),'N') end end as 'suffix',
	case when @printcusals = '1' and sod_cusstyno <> '' then sod_itmno else '' end as 'oriitm',
	case when @CRmk = 'Y' then isnull(sod_ztnvbeln,'') else '' end as 'sod_ztnvbeln',
	case when @CRmk = 'Y' then isnull(sod_ztnposnr,'') else '' end as 'sod_ztnposnr',

--	isnull(soh_email,'') as 'soh_email',
	@tmp_varchar200 as 'soh_email',

	@printPDF as 'printPDF',
	@HTSU as 'HTSU',
	@CV as 'CV',
	cv.vbi_vennam as 'cv_vennam',
	vci_adr as 'cv_adr',
	vci_stt as 'cv_stt',
	cvadr.ysi_dsc as 'cv_cty',
	ibi_imgpth as 'ibi_imgpth' ,
	case @CRmk when 'N' then '' else  isnull(sod_name_f1,'') + ' : ' + isnull(sod_dsc_f1,'') end as 'name1',
	case @CRmk when 'N' then '' else isnull(sod_name_f2,'') + ' : ' + isnull(sod_dsc_f2,'') end as 'name2',
	case @CRmk when 'N' then '' else isnull(sod_name_f3,'') + ' : ' + isnull(sod_dsc_f3,'') end  as 'name3',
	sod_dtlttlctn as 'sod_dtlttlctn'



into #TEMP_RESULT
from	SCORDDTL (nolock)
	join SCORDHDR (nolock) on
		soh_cocde = sod_cocde and
		soh_ordno = sod_ordno
	left join CUBASINF cus1 (nolock) on
		cus1.cbi_cusno = soh_cus1no
	left join CUBASINF cus2 (nolock) on
		cus2.cbi_cusno = soh_cus2no
	left join SYSETINF shpadr (nolock) on
		shpadr.ysi_typ = '02' and
		shpadr.ysi_cde = soh_shpcty
	left join SYSETINF biladr (nolock) on
		biladr.ysi_typ = '02' and
		biladr.ysi_cde = soh_bilcty
	left join SYAGTINF (nolock) on
		yai_agtcde = soh_agt
	left join VNBASINF pv (nolock) on
		pv.vbi_venno = sod_venno
	left join SYUSRPRF (nolock) on
		yup_usrid = soh_srname
	left join SCSHPMRK shpmrkM (nolock) on
		shpmrkM.ssm_cocde = soh_cocde and
		shpmrkM.ssm_ordno = soh_ordno and
		shpmrkM.ssm_shptyp = 'M'
	left join SCSHPMRK shpmrkI (nolock) on
		shpmrkI.ssm_cocde = soh_cocde and
		shpmrkI.ssm_ordno = soh_ordno and
		shpmrkI.ssm_shptyp = 'I'
	left join SCSHPMRK shpmrkS (nolock) on
		shpmrkS.ssm_cocde = soh_cocde and
		shpmrkS.ssm_ordno = soh_ordno and
		shpmrkS.ssm_shptyp = 'S'
	left join SYSETINF prctrm (nolock) on
		prctrm.ysi_typ = '03' and
		prctrm.ysi_cde = soh_prctrm
	left join SYSETINF paytrm (nolock) on
		paytrm.ysi_typ = '04' and
		paytrm.ysi_cde = soh_paytrm
	left join SYSETINF custUM (nolock) on
		custUM.ysi_typ = '05' and
		custUM.ysi_cde = case when isnull(sod_custum,'') <> '' then sod_custum else case when sod_contopc = 'Y' then 'PC' else sod_pckunt end end
	left join VNBASINF cv (nolock) on
		cv.vbi_venno = sod_cusven
	left join VNCNTINF (nolock) on
		vci_venno = cv.vbi_venno and
		vci_cnttyp = 'M'
	left join SYSETINF cvadr (nolock) on
		cvadr.ysi_typ = '02' and
		cvadr.ysi_cde = vci_cty
	left join IMBASINF (nolock) on ibi_itmno = sod_itmno
where	sod_cocde = @cocde and
	sod_ordno between @SCfrom and @SCto and
	((@Sup0 = 'Y' and sod_ordqty > 0) or (@Sup0 = 'N' )) and
	(	exists (select 1 from SYUSRRIGHT (nolock) where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 0) or
--		soh_saltem in (select yur_para from SYUSRRIGHT (nolock) where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 1) or
--		soh_cus1no in (select yur_para from SYUSRRIGHT (nolock) where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 2)
		cus1.cbi_saltem in (select yur_para from SYUSRRIGHT (nolock) where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 1) or
		cus1.cbi_cusno in (select yur_para from SYUSRRIGHT (nolock) where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 2)
	)




update #TEMP_RESULT set
[soh_rmk] = left(case len(ltrim(replace(replace(isnull(b.soh_rmk,'') + isnull(b.soh_scrmk,'') + case b.soh_cusctn when 0 then '' else ltrim(rtrim(str(b.soh_cusctn))) end + isnull(b.soh_dest,''), char(13), ''), char(10), ''))) when 0 then '0' else '1' end, 400),
[soh_rmk_Memo] = left(case b.soh_cusctn when 0 then '' else 'TOTAL CTN# - ' + ltrim(rtrim(str(b.soh_cusctn))) + case (b.soh_dest + b.soh_rmk) when '' then '' else @feed end end +
		case ltrim(rtrim(b.soh_dest)) when '' then '' else 'DESTINATION: ' + ltrim(rtrim(b.soh_dest)) + case (ltrim(rtrim(b.soh_rmk))) when '' then '' else @feed end end +
		b.soh_rmk + @feed + b.soh_scrmk, 2400),
[soh_email] = left(isnull(b.soh_email,''), 200),
[soh_biladr] = left(b.soh_biladr, 200),
[soh_shpadr] = left(b.soh_shpadr, 200),
[cbi_cusnam] = left(cus1.cbi_cusnam, 50),
[cbi_cussna] = left(cus1.cbi_cussna, 30),
[cbi_cusnamSnd] = left(isNull(cus2.cbi_cusnam,''), 50)
from #TEMP_RESULT a
left join SCORDHDR b on b.soh_cocde = @cocde and a.soh_ordno = b.soh_ordno 
	left join CUBASINF cus1 (nolock) on
		cus1.cbi_cusno = b.soh_cus1no
	left join CUBASINF cus2 (nolock) on
		cus2.cbi_cusno = b.soh_cus2no

update #TEMP_RESULT set
[sod_rmrk] = left(ltrim(replace(replace(b.sod_rmk, char(13), ''), char(10), '')) + case b.sod_moqchg when 0 then '' else 'A' end, 300),
[sod_Item_rmk] = left(b.sod_rmk + case rtrim(b.sod_rmk) when  ''  then '' else @feed end + case b.sod_moqchg when 0 then '' else
				'Original Unit Price is ' + rtrim(b.sod_curcde) + cast(cast(b.sod_untprc as decimal(13,4)) as varchar(13)) +
				', additional MOQ Charges ' + CAST(CAST(b.sod_moqchg as int) as varchar(10)) + '%' end, 700),
[sod_pormk]= case @CRmk when 'Y' then b.sod_pormk else '' end ,
[sod_itmdsc] = b.sod_itmdsc,

[sod_itmdsc_Memo] = b.sod_itmdsc + '1',

--substring(convert(char(800), b.sod_itmdsc + '1'),1,len(convert(char(800), b.sod_itmdsc + '1'))-1),



[sod_pckitr] = isNull(b.sod_pckitr,''),
[sod_pckitr_Memo] = b.sod_pckitr,
[sod_coldsc] = b.sod_coldsc
from #TEMP_RESULT a
left join SCORDDTL b on b.sod_cocde = @cocde and a.sod_ordno = b.sod_ordno and a.sod_ordseq = b.sod_ordseq

update #TEMP_RESULT
set 
[MainEng] = left(ltrim(replace(replace(isnull(shpmrkM.ssm_engdsc,''), char(13), ''), char(10), '')),1600),
[MainEng_Memo] = left(isNull(shpmrkM.ssm_engdsc,''),1600),	
[InnerEng] = left(ltrim(replace(replace(isnull(shpmrkI.ssm_engdsc,''), char(13), ''), char(10), '')),1600),
[InnerEng_Memo] = left(isNull(shpmrkI.ssm_engdsc,''),1600),	
[SideEng] = left(ltrim(replace(replace(isnull(shpmrkS.ssm_engdsc,''), char(13), ''), char(10), '')),1600),
[SideEng_Memo] = left(isNull(shpmrkS.ssm_engdsc,''),1600),
[MERk] = case len(ltrim(replace(replace(isnull(shpmrkM.ssm_engrmk,''), char(13), ''), char(10), ''))) when 0 then '0' else '1' end,
[IERk] = case len(ltrim(replace(replace(isnull(shpmrkI.ssm_engrmk,''), char(13), ''), char(10), ''))) when 0 then '0' else '1' end,
[SERk] = case len(ltrim(replace(replace(isnull(shpmrkS.ssm_engrmk,''), char(13), ''), char(10), ''))) when 0 then '0' else '1' end,
[MainEngRmk] = left(ltrim(isnull(shpmrkM.ssm_engrmk,'')),1600),
[InnerEngRmk] =	left(ltrim(isnull(shpmrkI.ssm_engrmk,'')),1600),
[SideEngRmk] = left(ltrim(isnull(shpmrkS.ssm_engrmk,'')),1600)
from #TEMP_RESULT
	left join SCSHPMRK shpmrkM (nolock) on
		shpmrkM.ssm_cocde = @cocde and
		shpmrkM.ssm_ordno = soh_ordno and
		shpmrkM.ssm_shptyp = 'M'
	left join SCSHPMRK shpmrkI (nolock) on
		shpmrkI.ssm_cocde = @cocde and
		shpmrkI.ssm_ordno = soh_ordno and
		shpmrkI.ssm_shptyp = 'I'
	left join SCSHPMRK shpmrkS (nolock) on
		shpmrkS.ssm_cocde = @cocde and
		shpmrkS.ssm_ordno = soh_ordno and
		shpmrkS.ssm_shptyp = 'S'


select 
* from #TEMP_RESULT





GO
GRANT EXECUTE ON [dbo].[sp_select_SCR00001_ca] TO [ERPUSER] AS [dbo]
GO
