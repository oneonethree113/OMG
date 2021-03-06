/****** Object:  StoredProcedure [dbo].[sp_select_PKR00001B]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PKR00001B]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PKR00001B]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


















CREATE procedure [dbo].[sp_select_PKR00001B]
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

/*

@vw_sumttlctn int

set @vw_sumttlctn = 0
select @vw_sumttlctn = sum(hid_ttlctn) from v_select_inr00001_wNewItmNo_wm vw 
where vw.hid_cocde = @cocde and vw.grp = @printGroup and vw.hid_invno = @from

*/


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


CREATE TABLE #MINSHPSEQ
(
	_shpno nvarchar(50),
	_cusitm nvarchar(50),	
	_minshpseq int,
)

CREATE TABLE #MINSEQDATA
(
	_shpno nvarchar(50),
	_cusitm nvarchar(50),
	_mtrdcm numeric(11,4),
	_mtrwcm numeric(11,4),
	_mtrhcm numeric(11,4)
)

insert into #MINSHPSEQ
select hid_shpno, hid_cusitm, min(hid_shpseq)
From SHINVHDR inv (nolock), SHIPGDTL dtl (nolock)
Where
inv.hiv_cocde = @cocde and    
inv.hiv_invno >= @from and inv.hiv_invno <= @to and    
inv.hiv_shpno = dtl.hid_shpno and     
inv.hiv_invno = dtl.hid_invno    
group by hid_shpno, hid_cusitm

insert into #MINSEQDATA
select hid_shpno, hid_cusitm, hid_mtrdcm, hid_mtrwcm, hid_mtrhcm 
from SHIPGDTL (nolock), #MINSHPSEQ (nolock)
where hid_shpno = _shpno and hid_shpseq = _minshpseq and hid_cusitm = _cusitm

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

---	For Packing List, Group by Container #
	dtl.hid_pckrmk,
	dtl.hid_ctrcfs ,
---	Total of Cartons for Container

---	For Invoice, Group by Customer PO# and Sales Confirmation #
	dtl.hid_cuspo,
	
---	Customer PO Date
	dtl.hid_ordno,
	
---	SC Revise Date


---	Details Shipmark
	dtl.hid_itmshm,
---	Carton Details

---	Manufacturers Name & Address
	dtl.hid_mannam,
	dtl.hid_manadr,
	dtl.hid_actvol,

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
	else dtl.hid_cusitm  end   ,
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
		dbo.groupnewitmno(dtl.hid_itmno)


		else
		ltrim(rtrim(dtl.hid_itmno))
		end end as 'dtl.hid_itmno',
	
	case when @printAlias = '0' then '' else isnull(hid_alsitmno,'') end as 'dtl.hid_alsitmno',


	dtl.hid_itmdsc,
--	convert(nvarchar(100), isnull(sod.sod_itmdsc, '')),
	convert(nvarchar(100), isnull(substring(sod.sod_itmdsc, 101, 200), '')), 
--	dtl.hid_colcde,
--	Case ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) when ' ' then Case ltrim(pod_vencol) when 'N/A' then '' else ltrim(pod_vencol) end else ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) end,
	Case ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) when ' ' then Case ltrim(pod_vencol) when 'N/A' then 'N/A' else ltrim(pod_vencol) end else ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) end,

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
END END,

	dtl.hid_grswgt,
	dtl.hid_netwgt,

---	Master Dim are concat.
--	ltrim(str(dtl.hid_mtrdcm,10,2)),
--	ltrim(str(dtl.hid_mtrwcm,10,2)),
--	ltrim(str(dtl.hid_mtrhcm,10,2)),

--	Frankie 20101011 
	case when _mtrdcm = convert(int,_mtrdcm) then ltrim(str(_mtrdcm,10,0)) else ltrim(str(_mtrdcm,10,2)) end,
	case when _mtrwcm = convert(int,_mtrwcm) then ltrim(str(_mtrwcm,10,0)) else ltrim(str(_mtrwcm,10,2)) end,
	case when _mtrhcm = convert(int,_mtrhcm) then ltrim(str(_mtrhcm,10,0)) else ltrim(str(_mtrhcm,10,2)) end,

	ltrim(str(_mtrdcm*0.3937,10,2)),--mtrdin
	ltrim(str(_mtrwcm*0.3937,10,2)),--mtrwin
	ltrim(str(_mtrhcm*0.3937,10,2)),--mtrhin

---	Harmonized Code

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
	
--	round(dtl.hid_actvol * dtl.hid_ttlctn,2),
	vw.hid_ttlcub,
	vw.hid_ttlcub*dtl.hid_ttlctn,
	case dtl.hid_contopc when 'Y' then dtl.hid_inrctn*dtl.hid_conftr else dtl.hid_inrctn end , 
	case dtl.hid_contopc when 'Y' then dtl.hid_mtrctn*dtl.hid_conftr else dtl.hid_mtrctn end , 
	dtl.hid_ttlgrs,
	dtl.hid_sealno,
--Edited by Mark Lau 20080616
	case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case dtl.hid_contopc when 'Y' then 'PC' else cde.ysi_dsc end end , 
 	 shm.hsm_imgpth,
	left(ltrim(shm.hsm_engdsc),1),
	Case ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) when ' ' then Case ltrim(pod_vencol) when 'N/A' then '' else ltrim(pod_vencol) end else ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) end,
	/*
	--Added by Mark Lau 20060927
	case when @printGroup = '1' then
		case when len(ltrim(rtrim(dtl.hid_itmno)) ) < 11 or charindex('-',ltrim(rtrim(dtl.hid_itmno)) ) > 0 or charindex('/',ltrim(rtrim(dtl.hid_itmno)) ) >0 or (Upper(substring(ltrim(rtrim(dtl.hid_itmno)) ,3,1)) not in ('A','B','U')) or substring(ltrim(rtrim(d
tl.hid_itmno)) ,7,2) = 'AS' then ''
	
		else 
		case when upper(substring(ltrim(rtrim(dtl.hid_itmno)) , 3, 1)) = 'A' then + '(' + substring(ltrim(rtrim(dtl.hid_itmno)) ,12, len(dtl.hid_itmno) - 11) +  ') ' --and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (s
ubstring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)
			else 
			case when upper(substring(ltrim(rtrim(dtl.hid_itmno)) , 3, 1)) = 'B' and (substring(ltrim(rtrim(dtl.hid_itmno)) , 4, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)) , 4, 1) <= '9' ) And (substring(ltrim(rtrim(dtl.hid_itmno)) , 5, 1) >= '0' And subs
tring(ltrim(rtrim(dtl.hid_itmno)) , 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)) , 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)) , 6, 1) <= '9') then  '(' +  substring(ltrim(rtrim(dtl.hid_itmno)) ,12,len(ltrim(rtrim(dtl.hid_itmno)) 
) - 11) + ') ' 
				else 
				case when upper(substring(ltrim(rtrim(dtl.hid_itmno)) , 3, 1)) = 'B' and (upper(substring(ltrim(rtrim(dtl.hid_itmno)) , 4, 1)) >= 'A' And upper(substring(ltrim(rtrim(dtl.hid_itmno)) , 4, 1)) <= 'Z' ) And (substring(ltrim(rtrim(dtl.hid_itmno)) , 5, 1) 
>= '0' And substring(ltrim(rtrim(dtl.hid_itmno)) , 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)) , 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)) , 6, 1) <= '9') then  '(' + substring(ltrim(rtrim(dtl.hid_itmno)) ,12,len(ltrim(rtrim(dt
l.hid_itmno)) ) - 11) + ') ' 
					else ''
				 end
			end
		end
		end
		else
		''
		end +

	Case ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) when ' ' then Case ltrim(pod_vencol) when 'N/A' then 'N/A' else ltrim(pod_vencol) end else ltrim(dtl.hid_coldsc) + ' ' + ltrim(dtl.hid_cuscol) end,*/
	ltrim(dtl.hid_jobno) + '(' + ltrim(dtl.hid_venno) + ')',
	@optjob,
	dtl.hid_ttlctn * dtl.hid_grswgt,
	dtl.hid_ttlctn * dtl.hid_netwgt,
	dtl.hid_ctnstr,
	vw.hid_ttlcub,






	isnull(sod.sod_cussku, ''),
--	shm.hsm_engdsc,
--	Frankie Cheung 20100916
	isnull((select top 1 hsm_engdsc from SHSHPMRK sh1 where sh1.hsm_shpno = shm.hsm_shpno and sh1.hsm_engdsc <> ''),'') as 'shm.hsm_engdsc',
---	Packing Remarks Details
---	To concat. all packing remarks of the invoice
	--2005/03/17 Lester Wu -- Retrieve Company Name , Short Name , Address, Phone, Fax, Email
	@yco_conam,
	@yco_addr,
	
	@yco_phoneno,
	@yco_faxno,
	@yco_logoimgpth,
	@yco_venid, -- Frankie Cheung 22 Oct 2008
	--	
	--Added by Mark Lau 20060929
	@printAlias,
	--Added by Mark Lau 20070724
	case when len(hdr.hih_bilrmk)>0 then '' else 'H' end as 'flg_hih_bilrmk',



	Case isnull(dtl.hid_cusitm, '') when '' then 

case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm  +  char(13) + char(10) +  '(' + dtl.hid_itmno  +')'  else
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
	else dtl.hid_cusitm  end as 'DisplayItemNo' ,
  ltrim(rtrim(hdr.hih_potloa)),
  ltrim(rtrim(hdr.hih_dst)),
  ltrim(sod.sod_dept),
  hid_ttlsumcub,
  vw_ttlctn = vw3.hid_ttlctn,    
  vw_shpqty = 
	case isnull(dtl.hid_contopc,'') when 'Y' then
	 	vw3.hid_shpqty*dtl.hid_conftr
	else
		vw3.hid_shpqty
	end,


right('0' +ltrim(rtrim(str(day(inv.hiv_credat)))),2) + '-' + 
CASE WHEN (MONTH(inv.hiv_credat) = 1) THEN  'Jan'
WHEN (MONTH(inv.hiv_credat) = 2) THEN  'Feb'
WHEN (MONTH(inv.hiv_credat) = 3) THEN  'Mar'
WHEN (MONTH(inv.hiv_credat) = 4) THEN  'Apr'
WHEN (MONTH(inv.hiv_credat) = 5) THEN  'May'
WHEN (MONTH(inv.hiv_credat) = 6) THEN  'Jun'
WHEN (MONTH(inv.hiv_credat) = 7) THEN  'Jul'
WHEN (MONTH(inv.hiv_credat) = 8) THEN  'Aug'
WHEN (MONTH(inv.hiv_credat) = 9) THEN  'Sep'
WHEN (MONTH(inv.hiv_credat) = 10) THEN  'Oct'
WHEN (MONTH(inv.hiv_credat) = 11) THEN  'Nov'
WHEN (MONTH(inv.hiv_credat) = 12) THEN  'Dec'
END 
+ '-' +right(ltrim(rtrim(str(year(inv.hiv_credat)))),2) as 'inv.hiv_credat',



hdr.hih_cntyorgn

From 	
SHIPGHDR hdr (nolock) 
left join SHINVHDR inv (nolock) on (hdr.hih_cocde = inv.hiv_cocde and hdr.hih_shpno = inv.hiv_shpno)
left join SHIPGDTL dtl (nolock) on (inv.hiv_cocde = dtl.hid_cocde and inv.hiv_shpno = dtl.hid_shpno and inv.hiv_invno = dtl.hid_invno)
left join SHSHPMRK shm (nolock) on (shm.hsm_cocde = inv.hiv_cocde and shm.hsm_invno = inv.hiv_invno and shm.hsm_shptyp = 'M')
left join SHPCUSSTY ca (nolock) on (ca.ica_itmno = dtl.hid_itmno and ca.ica_apvsts = 'Y'  and ca.sod_ordno  =  dtl.hid_ordno and ca.sod_ordseq  =  dtl.hid_ordseq)
left join CUBASINF cus (nolock) on (hdr.hih_cus1no = cus.cbi_cusno)
left join POORDDTL (nolock) on (dtl.hid_cocde = pod_cocde and dtl.hid_purord = pod_purord and dtl.hid_purseq = pod_purseq)
left join SYSETINF cty (nolock) on (hdr.hih_bilcty = cty.ysi_cde and cty.ysi_typ = '02')
left join (select hid_cocde, hid_invno, hid_ctrcfs, hid_ttlcub = sum(hid_ttlcub) from v_select_pkr00001 (nolock) group by hid_cocde, hid_invno, hid_ctrcfs) vw
	on (dtl.hid_cocde = vw.hid_cocde and dtl.hid_invno = vw.hid_invno and dtl.hid_ctrcfs = vw.hid_ctrcfs)
--left join (select hid_cocde, hid_invno, hid_ttlcub = sum(hid_ttlcub) from v_select_pkr00001_wm group by hid_cocde, hid_invno) vw
--	on (dtl.hid_cocde = vw.hid_cocde and dtl.hid_invno = vw.hid_invno)
left join (select hid_cocde, hid_invno, hid_ttlsumcub = sum(hid_ttlcub) from v_select_pkr00001 (nolock) group by hid_cocde, hid_invno) vw2
	on (dtl.hid_cocde = vw2.hid_cocde and dtl.hid_invno = vw2.hid_invno)
--left join (select hid_cocde, hid_invno, hid_ttlsumcub = sum(hid_ttlcub) from v_select_pkr00001_wm group by hid_cocde, hid_invno) vw2
--	on (dtl.hid_cocde = vw2.hid_cocde and dtl.hid_invno = vw2.hid_invno)
left join SCORDDTL sod (nolock) on  (sod.sod_cocde = hdr.hih_cocde and sod.sod_ordno = dtl.hid_ordno and sod.sod_ordseq = dtl.hid_ordseq)
left join SYSETINF cde (nolock) on (case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case when dtl.hid_contopc = 'Y' then 'PC' else dtl.hid_untcde end end  = cde.ysi_cde and cde.ysi_typ = '05')

left join v_select_inr00001_cusitm_wNewItmNo_wm vw3 (nolock) on  vw3.hid_cocde =@cocde and  
  vw3.grp = @printgroup and  
      vw3.hid_invno = inv.hiv_invno  and     
 -- AY Fix Grouping Problem in Printing at 31/12/2002    
 --     soh.soh_cuspo = vw.soh_cuspo and     
      dtl.hid_cuspo = vw3.hid_cuspo and    
      dtl.hid_ordno = vw3.hid_ordno and     
--      Frankie Cheung 20100916 	
--      dtl.hid_mannam = vw3.hid_mannam and     
--      dtl.hid_itmno = vw.hid_itmno and     
		--Added by Mark Lau 20080516, Add CDTVX
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm
else
case when @printGroup = '1' then  


-- Changed by Mark Lau 20090402, use function to perform the logic
/*
  case when len(ltrim(rtrim(dtl.hid_itmno))) < 11 or charindex('-',ltrim(rtrim(dtl.hid_itmno))) > 0 or charindex('/',ltrim(rtrim(dtl.hid_itmno))) >0 or (Upper(substring(ltrim(rtrim(dtl.hid_itmno)),3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(ltrim(rtrim(dtl.hid_itmno)),7,2) = 'AS' then ltrim(rtrim(dtl.hid_itmno))  
  else
  case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'A'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'C'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'D' or upper(substring(dtl.hid_itmno, 3, 1)) = 'T' or upper(substring(dtl.hid_itmno, 3, 1)) = 'X' or upper(substring(dtl.hid_itmno, 3, 1)) = 'V'  then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)--and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)   
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
  end end = vw3.hid_itmno and   
      dtl.hid_itmdsc = vw3.hid_itmdsc and      
      dtl.hid_inrctn = vw3.hid_inrctn and     
      dtl.hid_mtrctn = vw3.hid_mtrctn    
 -- AY - Bug Fix SelPrc Grouping Item at 24/12/2002    
      and dtl.hid_selprc = vw3.hid_selprc      
-- added by Mark Lau 20070427  
	--Modified by Mark Lau 20080314, change hid_untcde to ysi_dsc
	     and cde.ysi_dsc = vw3.ysi_dsc
 -- Lester Wu 2005-09-30, add group by gw, nw, and measurement,     
 -- ** Rememeber to modify v_select_inr00001 as well in order to match the following codes    
      and     
      ltrim(str(dtl.hid_grswgt,10,2)) = vw3.hid_grswgt and     
      ltrim(str(dtl.hid_netwgt,10,2)) = vw3.hid_netwgt and      
      ltrim(str(dtl.hid_mtrdcm,10,2)) + ' X ' + ltrim(str( dtl.hid_mtrwcm,10,2)) + ' X ' + ltrim(str(dtl.hid_mtrhcm,10,2)) = vw3.MEAS and  
      ltrim( dtl.hid_cusitm) = vw3.hid_cusitm and  
      vw3.hid_invno between @from and @to    
  left join #MINSEQDATA mcm (nolock) on mcm._shpno = dtl.hid_shpno and mcm._cusitm = dtl.hid_cusitm



WHERE 	
hdr.hih_cocde =  @cocde 
and inv.hiv_invno >= @from 
and inv.hiv_invno <= @to
/*
-- Join vw3
and 	vw3.hid_cocde =@cocde
and  	vw3.grp = @printgroup 
and   	vw3.hid_invno = inv.hiv_invno 
and      dtl.hid_cuspo = vw3.hid_cuspo
and      dtl.hid_ordno = vw3.hid_ordno
and      dtl.hid_mannam = vw3.hid_mannam 
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm
else
case when @printGroup = '1' then  
dbo.groupnewitmno(dtl.hid_itmno)
else  
ltrim(rtrim(dtl.hid_itmno))  
end end = vw3.hid_itmno 

and      dtl.hid_itmdsc = vw3.hid_itmdsc
and      dtl.hid_inrctn = vw3.hid_inrctn
and      dtl.hid_mtrctn = vw3.hid_mtrctn    
and 	dtl.hid_selprc = vw3.hid_selprc      
and cde.ysi_dsc = vw3.ysi_dsc
 and     
      ltrim(str(dtl.hid_grswgt,10,2)) = vw3.hid_grswgt and     
      ltrim(str(dtl.hid_netwgt,10,2)) = vw3.hid_netwgt and      
      ltrim(str(dtl.hid_mtrdcm,10,2)) + ' X ' + ltrim(str( dtl.hid_mtrwcm,10,2)) + ' X ' + ltrim(str(dtl.hid_mtrhcm,10,2)) = vw3.MEAS and  
      ltrim( dtl.hid_cusitm) = vw3.hid_cusitm and  
      vw3.hid_invno between @from and @to        
*/

drop TABLE #MINSHPSEQ
drop TABLE #MINSEQDATA

end

GO
GRANT EXECUTE ON [dbo].[sp_select_PKR00001B] TO [ERPUSER] AS [dbo]
GO
