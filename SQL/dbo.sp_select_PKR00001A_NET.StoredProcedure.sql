/****** Object:  StoredProcedure [dbo].[sp_select_PKR00001A_NET]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PKR00001A_NET]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PKR00001A_NET]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE          procedure [dbo].[sp_select_PKR00001A_NET]
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
@yco_logoimgpth	varchar(100),
@yco_venid	varchar(7)

set @yco_venid = ''
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
@yco_logoimgpth = yco_logoimgpth,
@yco_venid = yco_venid

from 

SYCOMINF(NOLOCK)

where
yco_cocde = @cocde
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------


Select	
	@opthdr as 'opthdr',
	@optitm as 'optitm',
	@optcub as 'optcub',
	@optgnw as 'optgnw',
	@optSKU as 'optSKU',
	@optCTR as 'optCTR',
	hdr.hih_shpno as 'hdr.hih_shpno',
	cast(dtl.hid_shpseq as nvarchar(20)) as 'dtl.hid_shpseq',
	hdr.hih_smpshp as 'hdr.hih_smpshp',
	inv.hiv_invno as 'inv.hiv_invno',
	inv.hiv_cover as 'inv.hiv_cover',
	cus.cbi_cusnam as 'cus.cbi_cusnam',

	hdr.hih_bilent as 'hdr.hih_bilent',
	hdr.hih_biladr as 'hdr.hih_biladr', 
	hdr.hih_bilstt as 'hdr.hih_bilstt', 
	cty.ysi_dsc as 'cty.ysi_dsc', 
	hdr.hih_bilzip as 'hdr.hih_bilzip',
	inv.hiv_paytrm as 'inv.hiv_paytrm',
	inv.hiv_ftrrmk as 'inv.hiv_ftrrmk',
	inv.hiv_doctyp as 'inv.hiv_doctyp',
	inv.hiv_doc as 'inv.hiv_doc',

	inv.hiv_invdat as 'inv.hiv_invdat',
	'FROM ' + hdr.hih_potloa + ' TO ' + hdr.hih_dst  as 'hdr.hih_potloa_hih_dst',
	hdr.hih_ves as 'hdr.hih_ves',
	hdr.hih_voy as 'hdr.hih_voy',
	hdr.hih_slnonb as 'hdr.hih_slnonb',
---	For Packing List, Group by Container #
	dtl.hid_pckrmk as 'dtl.hid_pckrmk',
	dtl.hid_ctrcfs  as 'dtl.hid_ctrcfs',
---	Total of Cartons for Container
---	For Invoice, Group by Customer PO# and Sales Confirmation #
	dtl.hid_cuspo as 'dtl.hid_cuspo',
---	Customer PO Date
	dtl.hid_ordno as 'dtl.hid_ordno',
---	SC Revise Date
---	Details Shipmark
	dtl.hid_itmshm as 'dtl.hid_itmshm',
---	Carton Details
---	Manufacturers Name & Address
	dtl.hid_mannam as 'dtl.hid_mannam',
	dtl.hid_manadr as 'dtl.hid_manadr',
--	dtl.hid_actvol as 'dtl.hid_actvol',
	hpd_cbm_cm as 'dtl.hid_actvol',

	Case isnull(dtl.hid_cusitm, '') when '' then 
		case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm  else

	--dtl.hid_itmno
	--Added by Mark Lau 20060927
		--Added by Mark Lau 20080516, Add CDTVX

	case when @printGroup = '1' then

		-- Changed by Mark Lau 20090402, use function to perform the logic
		/*
		case when len(ltrim(rtrim(dtl.hid_itmno))) < 11 or charindex('-',ltrim(rtrim(dtl.hid_itmno))) > 0 or charindex('/',ltrim(rtrim(dtl.hid_itmno))) >0 or (Upper(substring(ltrim(rtrim(dtl.hid_itmno)),3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(ltrim(rtrim(dtl.hid_itmno)),7,2) = 'AS' then ltrim(rtrim(dtl.hid_itmno))
	
		else 
		case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'A'   or upper(substring(dtl.hid_itmno, 3, 1)) = 'C'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'D' or upper(substring(dtl.hid_itmno, 3, 1)) = 'T' or upper(substring(dtl.hid_itmno, 3, 1)) = 'X' or upper(substring(dtl.hid_itmno, 3, 1)) = 'V'  then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)--and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)
			else 
			case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) <= '9' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)
				else 
				case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) >= 'A' And upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) <= 'Z' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)
					else ltrim(rtrim(dtl.hid_itmno))
				 end
			end
		end
		end
		*/
		dbo.groupnewitmno(dtl.hid_itmno)
		else
		ltrim(rtrim(dtl.hid_itmno))
		end


end
	else dtl.hid_cusitm  end    as 'dtl.hid_cusitm',

	--dtl.hid_itmno,


	--Added by Mark Lau 20060927
		--Added by Mark Lau 20080516, Add CDTVX
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm  else
	case when @printGroup = '1' then


		-- Changed by Mark Lau 20090402, use function to perform the logic
		/*
		case when len(ltrim(rtrim(dtl.hid_itmno))) < 11 or charindex('-',ltrim(rtrim(dtl.hid_itmno))) > 0 or charindex('/',ltrim(rtrim(dtl.hid_itmno))) >0 or (Upper(substring(ltrim(rtrim(dtl.hid_itmno)),3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(ltrim(rtrim(dtl.hid_itmno)),7,2) = 'AS' then ltrim(rtrim(dtl.hid_itmno))
	
		else 
		case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'A'    or upper(substring(dtl.hid_itmno, 3, 1)) = 'C'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'D' or upper(substring(dtl.hid_itmno, 3, 1)) = 'T' or upper(substring(dtl.hid_itmno, 3, 1)) = 'X' or upper(substring(dtl.hid_itmno, 3, 1)) = 'V'  then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)--and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)
			else 
			case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) <= '9' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)
				else 
				case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) >= 'A' And upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) <= 'Z' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)
					else ltrim(rtrim(dtl.hid_itmno))
				 end
			end
		end
		end
		*/
		--dbo.groupnewitmno(dtl.hid_itmno)
		--20150707
		ltrim(rtrim(dtl.hid_itmno))

		else
		ltrim(rtrim(dtl.hid_itmno))
		end end as 'dtl.hid_itmno',
	
	case when @printAlias = '0' then '' else isnull(hid_alsitmno,'') end as 'dtl.hid_alsitmno',


--	dtl.hid_itmdsc,
	convert(nvarchar(100), isnull(sod.sod_itmdsc, '')) as 'dtl.hid_itmdsc',
	convert(nvarchar(100), isnull(substring(sod.sod_itmdsc, 101, 200), '')) as 'dtl.hid_itmdsc2', 
--	dtl.hid_colcde,
--	Case ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) when ' ' then Case ltrim(pod_vencol) when 'N/A' then '' else ltrim(pod_vencol) end else ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) end,
	Case ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) when ' ' then Case ltrim(pod_vencol) when 'N/A' then 'N/A' else ltrim(pod_vencol) end else ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) end as 'dtl.hid_colcde',

---	Assortment Details
---	Component Breakdown
	
---	Packing: change all to string and concat.
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
END END as 'dtl.packing',

--	dtl.hid_grswgt as 'dtl.hid_grswgt',
	hpd_gw_kg as 'dtl.hid_grswgt',
--	dtl.hid_netwgt as 'dtl.hid_netwgt',
	hpd_nw_kg as 'dtl.hid_netwgt',

---	Master Dim are concat.
--	ltrim(str(dtl.hid_mtrdcm,10,2)) as 'dtl.hid_mtrdcm',
	ltrim(str(hpd_l_cm,10,2)) as 'dtl.hid_mtrdcm',
--	ltrim(str(dtl.hid_mtrwcm,10,2)) as 'dtl.hid_mtrwcm',
	ltrim(str(hpd_w_cm,10,2)) as 'dtl.hid_mtrwcm',
--	ltrim(str(dtl.hid_mtrhcm,10,2)) as 'dtl.hid_mtrhcm',
	ltrim(str(hpd_h_cm,10,2)) as 'dtl.hid_mtrhcm',

--	ltrim(str(dtl.hid_mtrdcm*0.3937,10,2)) as 'mtrdin',--mtrdin --temp name
	ltrim(str(hpd_l_in,10,2)) as 'mtrdin',
--	ltrim(str(dtl.hid_mtrwcm*0.3937,10,2)) as 'mtrwin',--mtrwin
	ltrim(str(hpd_w_in,10,2)) as 'mtrwin',
--	ltrim(str(dtl.hid_mtrhcm*0.3937,10,2)) as 'mtrhin',--mtrhin
	ltrim(str(hpd_h_in,10,2)) as 'mtrhin',

	dtl.hid_ttlctn as 'dtl.hid_ttlctn',
	case dtl.hid_contopc when 'Y' then dtl.hid_shpqty*dtl.hid_conftr else dtl.hid_shpqty end  as 'dtl.hid_shpqty',
	dtl.hid_untsel as 'dtl.hid_untsel',
	case dtl.hid_contopc when 'Y' then dtl.hid_pcprc else dtl.hid_selprc end  as 'dtl.hid_selprc',
	dtl.hid_ttlamt as 'dtl.hid_ttlamt',
	@cocde as 'cocde',
	hdr.hih_cus1no as 'hdr.hih_cus1no',
	sod.sod_typcode as 'sod.sod_typcode',
	sod.sod_Code1 as 'sod.sod_Code1',
	sod.sod_Code2 as 'sod.sod_Code2',
	sod.sod_Code3 as 'sod.sod_Code3',
	dtl.hid_ctrsiz as 'dtl.hid_ctrsiz',
	inv.hiv_plrmk as 'hdr.hih_bilrmk',
--	hdr.hih_bilrmk as 'hdr.hih_bilrmk',
	--vw.hid_ttlcub as 'dtl.hid_cbm',
	hpd_cbm_cm as 'dtl.hid_cbm',
--	vw.hid_ttlcub*dtl.hid_ttlctn as 'TEMP1ERGRRRET3ERT',
	hpd_cbm_cm*dtl.hid_ttlctn as 'TEMP1ERGRRRET3ERT',
	case dtl.hid_contopc when 'Y' then dtl.hid_inrctn*dtl.hid_conftr else dtl.hid_inrctn end  as 'dtl.hid_inrctn', 
	case dtl.hid_contopc when 'Y' then dtl.hid_mtrctn*dtl.hid_conftr else dtl.hid_mtrctn end  as 'dtl.hid_mtrctn', 
	dtl.hid_ttlgrs as 'dtl.hid_ttlgrs',
	dtl.hid_sealno as 'dtl.hid_sealno',
	case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case dtl.hid_contopc when 'Y' then 'PC' else cde.ysi_dsc end end  as 'cde.ysi_dsc', 
 	 shm.hsm_imgpth as 'shm.hsm_imgpth',
	left(ltrim(shm.hsm_engdsc),1) as 'shm.hsm_engdsc',
	Case ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) when ' ' then Case ltrim(pod_vencol) when 'N/A' then '' else ltrim(pod_vencol) end else ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) end as 'dtl.hid_color',
	ltrim(dtl.hid_jobno) + '(' + ltrim(dtl.hid_venno) + ')' as 'dtl.hid_jobno',
	@optjob as 'optjob',
	--dtl.hid_ttlctn * dtl.hid_grswgt as 'dtl.hid_ttlgw',
	dtl.hid_ttlctn * hpd_gw_kg as 'dtl.hid_ttlgw',
	--dtl.hid_ttlctn * dtl.hid_netwgt as 'dtl.hid_ttlnw',
	dtl.hid_ttlctn * hpd_nw_kg as 'dtl.hid_ttlnw',
	dtl.hid_ctnstr as 'dtl.hid_ctnstr',
	vw.hid_ttlcub as 'vw.hid_ttlcub',
	isnull(sod.sod_cussku, '') as 'sod_cussku',
	shm.hsm_engdsc as 'shm.hsm_engdscM',
	@yco_conam as 'yco_conam',
	@yco_addr as 'yco_addr',
	@yco_phoneno as 'yco_phoneno',
	@yco_faxno as 'yco_faxno',
	@yco_logoimgpth as 'yco_logoimgpth',
	@yco_logoimgpth  as 'logoimgpth',  
	@yco_venid as 'yco_venid',
	@printAlias as '@printAlias',
	case when len(hdr.hih_bilrmk)>0 then '' else 'H' end as 'flg_hih_bilrmk',
	Case isnull(dtl.hid_cusitm, '') when '' then 
		case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm  +  char(13) + char(10) +  '(' + dtl.hid_itmno  +')'  else
			case when @printGroup = '1' then
				dbo.groupnewitmno(dtl.hid_itmno)
				else
				ltrim(rtrim(dtl.hid_itmno))
				end
		end 
	else dtl.hid_cusitm  end as 'DisplayItemNo' ,
  ltrim(rtrim(hdr.hih_potloa)) as 'hdr.hih_potloa',
  ltrim(rtrim(hdr.hih_dst)) as 'hdr.hih_dst',
  ltrim(sod.sod_dept) as 'sod.sod_dept',
  hid_ttlsumcub as 'hid_ttlsumcub',
	
CASE WHEN (MONTH(inv.hiv_invdat) = 1) THEN  'Jan'
WHEN (MONTH(inv.hiv_invdat) = 2) THEN  'Feb'
WHEN (MONTH(inv.hiv_invdat) = 3) THEN  'Mar'
WHEN (MONTH(inv.hiv_invdat) = 4) THEN  'Apr'
WHEN (MONTH(inv.hiv_invdat) = 5) THEN  'May'
WHEN (MONTH(inv.hiv_invdat) = 6) THEN  'Jun'
WHEN (MONTH(inv.hiv_invdat) = 7) THEN  'Jul'
WHEN (MONTH(inv.hiv_invdat) = 8) THEN  'Aug'
WHEN (MONTH(inv.hiv_invdat) = 9) THEN  'Sep'
WHEN (MONTH(inv.hiv_invdat) = 10) THEN  'Oct'
WHEN (MONTH(inv.hiv_invdat) = 11) THEN  'Nov'
WHEN (MONTH(inv.hiv_invdat) = 12) THEN  'Dec'
END 
+ '/' +
right('0' +ltrim(rtrim(str(day(inv.hiv_invdat)))),2) + '/' + 
ltrim(rtrim(str(year(inv.hiv_invdat)))) as 'inv.hiv_invdat_text',

CASE WHEN (MONTH(hdr.hih_slnonb) = 1) THEN  'Jan'
WHEN (MONTH(hdr.hih_slnonb) = 2) THEN  'Feb'
WHEN (MONTH(hdr.hih_slnonb) = 3) THEN  'Mar'
WHEN (MONTH(hdr.hih_slnonb) = 4) THEN  'Apr'
WHEN (MONTH(hdr.hih_slnonb) = 5) THEN  'May'
WHEN (MONTH(hdr.hih_slnonb) = 6) THEN  'Jun'
WHEN (MONTH(hdr.hih_slnonb) = 7) THEN  'Jul'
WHEN (MONTH(hdr.hih_slnonb) = 8) THEN  'Aug'
WHEN (MONTH(hdr.hih_slnonb) = 9) THEN  'Sep'
WHEN (MONTH(hdr.hih_slnonb) = 10) THEN  'Oct'
WHEN (MONTH(hdr.hih_slnonb) = 11) THEN  'Nov'
WHEN (MONTH(hdr.hih_slnonb) = 12) THEN  'Dec'
END 
+ '/' +
right('0' +ltrim(rtrim(str(day(hdr.hih_slnonb)))),2) + '/' + 
ltrim(rtrim(str(year(hdr.hih_slnonb)))) as 'hdr.hih_slnonb_text',
sod_seccusitm as 'sod_seccusitm'
	



From 	
SHIPGHDR hdr
left join SYSETINF cty on hdr.hih_bilcty = cty.ysi_cde and cty.ysi_typ = '02'
, 
SHIPGDTL dtl 
left join SHPCUSSTY ca on ca.ica_itmno = dtl.hid_itmno and ca.ica_apvsts = 'Y' and ca.sod_ordno = dtl.hid_ordno and ca.sod_ordseq = dtl.hid_ordseq
,
shpckdim pdm ,
SHINVHDR inv
left join SHSHPMRK shm on shm.hsm_cocde = inv.hiv_cocde and shm.hsm_invno = inv.hiv_invno and shm.hsm_shptyp = 'M'
, 
CUBASINF cus, 
SCORDDTL sod, 
SYSETINF cde, 
POORDDTL, 
(select hid_cocde, hid_invno, hid_ctrcfs, hid_ttlcub = sum(hid_ttlcub) from v_select_pkr00001 group by hid_cocde, hid_invno, hid_ctrcfs) vw,
(select hid_cocde, hid_invno, hid_ttlsumcub = sum(hid_ttlcub) from v_select_pkr00001 group by hid_cocde, hid_invno) vw2
WHERE 	
hdr.hih_cocde = inv.hiv_cocde and hdr.hih_shpno = inv.hiv_shpno
and	inv.hiv_cocde = dtl.hid_cocde and inv.hiv_shpno = dtl.hid_shpno and inv.hiv_invno = dtl.hid_invno
and 	hdr.hih_cus1no = cus.cbi_cusno
and	dtl.hid_cocde = pod_cocde and dtl.hid_purord = pod_purord and dtl.hid_purseq = pod_purseq
and 	case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case when dtl.hid_contopc = 'Y' then 'PC' else dtl.hid_untcde end end  = cde.ysi_cde and cde.ysi_typ = '05'
and	dtl.hid_cocde = vw.hid_cocde and dtl.hid_invno = vw.hid_invno and dtl.hid_ctrcfs = vw.hid_ctrcfs
and	dtl.hid_cocde = vw2.hid_cocde and dtl.hid_invno = vw2.hid_invno
and	hdr.hih_cocde =  @cocde 
and 	sod.sod_cocde = hdr.hih_cocde and sod.sod_ordno = dtl.hid_ordno 
and 	sod.sod_ordseq = dtl.hid_ordseq
and inv.hiv_invno >= @from 
and inv.hiv_invno <= @to
and	 pdm.hpd_shpno = hid_shpno and pdm.hpd_shpseq = hid_shpseq
		and pdm.hpd_dimtyp = 'Mod'
		and (
			(dtl.hid_ctnftr = 1 and ( pdm.hpd_pdnum = 5 or pdm.hpd_pdnum = 6 )) 
			or (dtl.hid_ctnftr = 2 and ( pdm.hpd_pdnum = 1 or pdm.hpd_pdnum = 2 or pdm.hpd_pdnum = 3 or pdm.hpd_pdnum = 4 ))   
			)

end





















GO
GRANT EXECUTE ON [dbo].[sp_select_PKR00001A_NET] TO [ERPUSER] AS [dbo]
GO
