/****** Object:  StoredProcedure [dbo].[sp_select_SHCI_PKR00001]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHCI_PKR00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHCI_PKR00001]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO













CREATE procedure [dbo].[sp_select_SHCI_PKR00001]
@cocde nvarchar(6) ,
@opthdr nvarchar(1),
@optitm nvarchar(1),
@optcub nvarchar(1),
@optgnw nvarchar(1),
@optjob nvarchar(1),
@optSKU nvarchar(1),
@optCTR	char(1),
@from nvarchar(20),
@to nvarchar(20) ,         
@printGroup	nvarchar(1),
@printAlias	nvarchar(1)
AS
begin

------------------------------------------------------------------------------------------------------------------------------------------------------
--Lester Wu 2005/03/03 -- Retrieve Company Name, Short Name, Address, Phone No, Fax No, Email Address, Logo Path
------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE
@yco_conam	varchar(100),
@yco_addr		varchar(200),

@yco_phoneno	varchar(50),
@yco_faxno	varchar(50),
@yco_logoimgpth	varchar(100)

set @yco_conam = ''
set @yco_addr = ''

set @yco_phoneno = ''
set @yco_faxno = ''


set @yco_logoimgpth = ''

select
@yco_conam=yco_conam,
@yco_addr=yco_addr,

@yco_phoneno= yco_phoneno,
@yco_faxno = yco_faxno,
@yco_logoimgpth = yco_logoimgpth

from 

SYCOMINF(NOLOCK)

where
yco_cocde = @cocde
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------


Select	
	@opthdr,
	@optitm,
	@optcub,
	@optgnw,
	@optSKU,
	@optCTR,
	hdr.hih_shpno,
	dtl.hid_shpseq,
	hdr.hih_smpshp,
	inv.hiv_invno,
	inv.hiv_cover,
	cus.cbi_cusnam,

	hdr.hih_bilent,
	hdr.hih_biladr, hdr.hih_bilstt, cty.ysi_dsc, hdr.hih_bilzip,
	inv.hiv_paytrm,
	inv.hiv_ftrrmk,
	inv.hiv_doctyp,
	inv.hiv_doc,

	inv.hiv_invdat,
	'FROM ' + hdr.hih_potloa + ' TO ' + hdr.hih_dst,
	hdr.hih_ves,
	hdr.hih_voy,
	hdr.hih_slnonb,
	dtl.hid_pckrmk,
	dtl.hid_ctrcfs,
	dtl.hid_cuspo,
	dtl.hid_ordno,
	dtl.hid_itmshm,
	dtl.hid_mannam,
	dtl.hid_manadr,
	dtl.hid_actvol,
	Case isnull(dtl.hid_cusitm, '') when '' then 
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm  else
	case when @printGroup = '1' then
		dbo.groupnewitmno(dtl.hid_itmno)
		else
		ltrim(rtrim(dtl.hid_itmno))
		end
end
	else dtl.hid_cusitm  end   ,
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm  else
	case when @printGroup = '1' then
		dbo.groupnewitmno(dtl.hid_itmno)
		else
		ltrim(rtrim(dtl.hid_itmno))
		end end as 'dtl.hid_itmno',
	
	case when @printAlias = '0' then '' else isnull(hid_alsitmno,'') end as 'dtl.hid_alsitmno',
	convert(nvarchar(100), isnull(sod.sod_itmdsc, '')),
	convert(nvarchar(100), isnull(substring(sod.sod_itmdsc, 101, 200), '')), 
	Case ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) when ' ' then Case ltrim(pod_vencol) when 'N/A' then 'N/A' else ltrim(pod_vencol) end else ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) end,
case when dtl.hid_contopc = 'Y' and isnull(dtl.hid_custum,'') <> '' then
	CASE ltrim(str(dtl.hid_inrctn)) WHEN '0' THEN
		'                       ' + ltrim( str(dtl.hid_mtrctn*dtl.hid_conftr)) +  ' ' + cde.ysi_dsc
	ELSE
		case len(cde.ysi_dsc) when 6 then
			ltrim(str(dtl.hid_inrctn*dtl.hid_conftr)) + ' ' + cde.ysi_dsc +'    ' + ltrim( str(dtl.hid_mtrctn*dtl.hid_conftr)) + ' ' + cde.ysi_dsc
		else	
			ltrim(str(dtl.hid_inrctn*dtl.hid_conftr)) + ' ' + cde.ysi_dsc +'          ' +ltrim( str(dtl.hid_mtrctn*dtl.hid_conftr)) + ' ' + cde.ysi_dsc
		end
	END

else

case  when dtl.hid_contopc  = 'Y' and isnull(dtl.hid_custum,'') = '' then
	CASE ltrim(str(dtl.hid_inrctn)) WHEN '0' THEN
		'                       ' + ltrim( str(dtl.hid_mtrctn*dtl.hid_conftr)) + ' PC'
	ELSE
		ltrim(str(dtl.hid_inrctn*dtl.hid_conftr)) + ' PC          ' +ltrim( str(dtl.hid_mtrctn*dtl.hid_conftr)) + ' PC'
	END

else
	CASE ltrim(str(dtl.hid_inrctn)) WHEN '0' THEN
		'                       ' + ltrim( str(dtl.hid_mtrctn)) + ' ' + cde.ysi_dsc
	ELSE
		case len(cde.ysi_dsc) when 6 then
			ltrim(str(dtl.hid_inrctn)) + ' ' + cde.ysi_dsc +'    ' + ltrim( str(dtl.hid_mtrctn)) + ' ' + cde.ysi_dsc
		else	
			ltrim(str(dtl.hid_inrctn)) + ' ' + cde.ysi_dsc +'          ' +ltrim( str(dtl.hid_mtrctn)) + ' ' + cde.ysi_dsc
		end
	END
END END,

	dtl.hid_grswgt,
	dtl.hid_netwgt,
	ltrim(str(dtl.hid_mtrdcm,10,2)),
	ltrim(str(dtl.hid_mtrwcm,10,2)),
	ltrim(str(dtl.hid_mtrhcm,10,2)),
	dtl.hid_ttlctn,
	case dtl.hid_contopc when 'Y' then dtl.hid_shpqty*dtl.hid_conftr else dtl.hid_shpqty end ,
	dtl.hid_untsel,
	case dtl.hid_contopc when 'Y' then dtl.hid_pcprc else dtl.hid_selprc end ,
	dtl.hid_ttlamt,
	@cocde,
	hdr.hih_cus1no,
	sod.sod_typcode,
	sod.sod_Code1,
	sod.sod_Code2,
	sod.sod_Code3,
	dtl.hid_ctrsiz,
	hdr.hih_bilrmk,
	vw.hid_ttlcub,
	case dtl.hid_contopc when 'Y' then dtl.hid_inrctn*dtl.hid_conftr else dtl.hid_inrctn end , 
	case dtl.hid_contopc when 'Y' then dtl.hid_mtrctn*dtl.hid_conftr else dtl.hid_mtrctn end , 
	dtl.hid_ttlgrs,
	dtl.hid_sealno,
	case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case dtl.hid_contopc when 'Y' then 'PC' else cde.ysi_dsc end end , 
 	 shm.hsm_imgpth,
	left(ltrim(shm.hsm_engdsc),1),
	Case ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) when ' ' then Case ltrim(pod_vencol) when 'N/A' then '' else ltrim(pod_vencol) end else ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) end,
	ltrim(dtl.hid_jobno) + '(' + ltrim(dtl.hid_venno) + ')',
	@optjob,
	dtl.hid_ttlctn * dtl.hid_grswgt,
	dtl.hid_ttlctn * dtl.hid_netwgt,
	dtl.hid_ctnstr,
	vw.hid_ttlcub,
	isnull(sod.sod_cussku, ''),
	shm.hsm_engdsc,
	@yco_conam,
	@yco_addr,
	
	@yco_phoneno,
	@yco_faxno,
	@yco_logoimgpth,
	@printAlias,
	case when len(hdr.hih_bilrmk)>0 then '' else 'H' end as 'flg_hih_bilrmk',
	Case isnull(dtl.hid_cusitm, '') when '' then 
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm  +  char(13) + char(10) +  '(' + dtl.hid_itmno  +')'  else
	case when @printGroup = '1' then
		dbo.groupnewitmno(dtl.hid_itmno)
		else
		ltrim(rtrim(dtl.hid_itmno))
		end
end 
	else dtl.hid_cusitm  end as 'DisplayItemNo'  

From 	
SHCI_SHIPGHDR hdr 
left join SYSETINF cty on hdr.hih_bilcty = cty.ysi_cde and cty.ysi_typ = '02'
, 
SHCI_SHIPGDTL dtl
left join SHPCUSSTY ca on ca.ica_itmno = dtl.hid_itmno and ca.ica_apvsts = 'Y'  and ca.sod_ordno  =  dtl.hid_ordno and ca.sod_ordseq  =  dtl.hid_ordseq
,
SHCI_SHINVHDR inv
left join SHCI_SHSHPMRK shm on shm.hsm_cocde = inv.hiv_cocde and shm.hsm_invno = inv.hiv_invno and shm.hsm_shptyp = 'M'
, CUBASINF cus, SCORDDTL sod, SYSETINF cde,  POORDDTL, 
	(select hid_cocde, hid_invno, hid_ctrcfs, hid_ttlcub = sum(hid_ttlcub) from v_select_shci_pkr00001 group by hid_cocde, hid_invno, hid_ctrcfs) vw
WHERE 	
hdr.hih_cocde = inv.hiv_cocde and hdr.hih_shpno = inv.hiv_shpno
and	inv.hiv_cocde = dtl.hid_cocde and inv.hiv_shpno = dtl.hid_shpno and inv.hiv_invno = dtl.hid_invno
and 	hdr.hih_cus1no = cus.cbi_cusno
and	dtl.hid_cocde = pod_cocde and dtl.hid_purord = pod_purord and dtl.hid_purseq = pod_purseq
and 	case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case when dtl.hid_contopc = 'Y' then 'PC' else dtl.hid_untcde end end  = cde.ysi_cde and cde.ysi_typ = '05'
and	dtl.hid_cocde = vw.hid_cocde and dtl.hid_invno = vw.hid_invno and dtl.hid_ctrcfs = vw.hid_ctrcfs
and	hdr.hih_cocde =  @cocde 
and 	sod.sod_cocde = hdr.hih_cocde and sod.sod_ordno = dtl.hid_ordno 
and 	sod.sod_ordseq = dtl.hid_ordseq
and inv.hiv_invno >= @from 
and inv.hiv_invno <= @to


end





GO
GRANT EXECUTE ON [dbo].[sp_select_SHCI_PKR00001] TO [ERPUSER] AS [dbo]
GO
