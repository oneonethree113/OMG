/****** Object:  StoredProcedure [dbo].[sp_select_POR00001]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00001]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/*
=================================================================
Program ID	: sp_select_POR00001
Description	: Select Data for PO Report
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-08-30	David Yue	SP Created
=================================================================
*/


CREATE    PROCEDURE [dbo].[sp_select_POR00001]

@cocde		nvarchar(6),
@Sup0		nvarchar(1),
@POfrom		nvarchar(20),	
@POto		nvarchar(20),
@Rvs		nvarchar(1),
@sortBy		nvarchar(4),
@printGroup	nvarchar(1),
@printAmt	nvarchar(1),
@POCheck	nvarchar(1),
@usrid		nvarchar(30),
@doctyp		nvarchar(2)

AS

declare @feed	varchar(10)
set @feed = '
'

-- Read Company Information --
declare 
@yco_conam	varchar(50),
@yco_addr	nvarchar(200),
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

---------------------------------------------

set @POCheck = 'Y' 

create table #TEMP_PO_LIST
(
tmp_purord	nvarchar(20)
)

insert into #TEMP_PO_LIST
select	poh_purord
from	POORDHDR (nolock)
	left join CUBASINF (nolock) on
		cbi_cusno = poh_prmcus
where	poh_purord between @POfrom and @POto and
	poh_cocde = @cocde and
	(	
		exists (select 1 from SYUSRRIGHT (nolock) where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 0) or
		cbi_saltem in (select yur_para from SYUSRRIGHT (nolock) where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 1) or
		cbi_cusno  in (select yur_para from SYUSRRIGHT (nolock) where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 2)
	)

Select	-- Parameter 
	@cocde as 'cocde',
	@yco_conam as 'conam',
	@yco_addr as 'addr',
	@yco_logoimgpth as 'logoimgpth',
	@yco_phoneno as 'phoneno',
	@yco_faxno as 'faxno',
	@Sup0 as 'Sup0',
	@POfrom as 'POfrom',	
	@POto as 'POto',
	@Rvs as 'Rvs',
	@sortBy as 'sortBy',	
	@printAmt as 'printAmt',
	cbi_cusno,
	case @sortBy when 'CUST' then pod_cusitm else '' end as 'Sorting',
	case when @printGroup = '1' then case when len(pod_itmno) < 11 or charindex('-',pod_itmno) > 0 or charindex('/',pod_itmno) > 0 or 
		(upper(substring(pod_itmno,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(pod_itmno,7,2) = 'AS' then pod_itmno 
		else  case when upper(substring(pod_itmno, 3, 1)) = 'A' or upper(substring(pod_itmno, 3, 1)) = 'C' or 
		upper(substring(pod_itmno, 3, 1)) = 'D' or upper(substring(pod_itmno, 3, 1)) = 'T' or upper(substring(pod_itmno, 3, 1)) = 'X' or 
		upper(substring(pod_itmno, 3, 1)) = 'V' then substring(pod_itmno,1,11) else case when upper(substring(pod_itmno, 3, 1)) = 'B' and 
		(substring(pod_itmno, 4, 1) >= '0' and substring(pod_itmno, 4, 1) <= '9' ) and (substring(pod_itmno, 5, 1) >= '0' and 
		substring(pod_itmno, 5, 1) <= '9' ) and  (substring(pod_itmno, 6, 1) >= '0' and substring(pod_itmno, 6, 1) <= '9') then 
		substring(pod_itmno,1,11) else case when upper(substring(pod_itmno, 3, 1)) = 'B' and (upper(substring(pod_itmno, 4, 1)) >= 'A' and 
		upper(substring(pod_itmno, 4, 1)) <= 'Z' ) and (substring(pod_itmno, 5, 1) >= '0' and substring(pod_itmno, 5, 1) <= '9' ) and 
		(substring(pod_itmno, 6, 1) >= '0' and substring(pod_itmno, 6, 1) <= '9') then substring(pod_itmno,1,11) else pod_itmno end end 
		end end else pod_itmno end + 'x' + ltrim(pod_engdsc) + 'x' + pod_untcde + 'x' + ltrim(str(pod_inrctn)) + 'x' + 
		ltrim(str(pod_mtrctn)) + 'x' + ltrim(cast(pod_cubcft as nvarchar(99))) + 'x' + ltrim(cast(pod_ftyprc as nvarchar(99))) + 'x' +
		ltrim(pod_cuspno) + 'x' + ltrim(rtrim(pod_ftyprctrm)) + 'x' + ltrim(rtrim(pod_trantrm)) as 'podKey',
	case when v.vbi_vennam = '' and v.vbi_venchnnam <> '' then v.vbi_venchnnam else case when v.vbi_vennam <> '' and v.vbi_venchnnam = '' then v.vbi_vennam
		else case when v.vbi_vennam <> '' and  v.vbi_venchnnam <> '' then v.vbi_vennam +  ' (' + v.vbi_venchnnam + ')'  end end end as 'vbi_vennam',
	purcty.ysi_dsc,
	poh_curcde,
	poh_spoflg,
	case when poh_puradr = '' and poh_purchnadr <> '' then poh_purchnadr else case when poh_puradr <> '' and  poh_purchnadr = '' then poh_puradr
		else case when poh_puradr <> '' and poh_purchnadr <> '' then poh_purchnadr + char(13) + char(10) + char(13) + char(10) + poh_puradr
		end end end as 'poh_puradr',
	poh_purstt,
	poh_purpst,
	poh_porctp,	
	poh_purord,	
	poh_credat = convert(char(10), poh_credat, 101),
	poh_issdat = convert(char(10), poh_issdat, 101) + ' ' + convert(char(10), poh_issdat, 108),
	poh_pocdat = Case convert(char(10), poh_pocdat, 101) when '01/01/1900' then '' else convert(char(10), poh_pocdat, 101) end,
	poh_pocdatend = Case convert(char(10), poh_pocdatend, 101) when '01/01/1900' then '' else convert(char(10), poh_pocdatend, 101) end,
	poh_cuspno,
	poh_reppno,
	poh_salrep,
	poh_prctrm,
/*
	case @cocde when 'EW' then poh_rmk when 'HX' then poh_rmk when 'TT' then ltrim(rtrim('This P.O. is issued on behalf of NEW LEADER. ' +
		char(10) + char(13) + '此張採購單乃代表 「聯通」發出。' + char(10) + char(13)+ poh_rmk)) else case vbi_bvennam when 'NO' then poh_rmk 
		else ltrim(rtrim('This P.O. is issued on behalf of ' + vbi_bvennam + '. ' + char(10) + char(13) + '此張採購單乃代表 「' + vbi_bvennamc +
		'」發出。' + char(10) + char(13)+ poh_rmk)) end end as 'poh_rmk',
*/

/*
	case @cocde	when 'EW' then case when poh_cusctn > 0 then 'TOTAL CTN# - ' + ltrim(rtrim(str(poh_cusctn))) end + case when (poh_cusctn > 0 and poh_dest <> '') then char(10) + char(13) + 'DESTINATION: ' + ltrim(rtrim(poh_dest)) end + case when (poh_cusctn > 0 or poh_dest <> '') and poh_rmk <> '' then char(10) + char(13) + poh_rmk end
			when 'HX' then case when poh_cusctn > 0 then 'TOTAL CTN# - ' + ltrim(rtrim(str(poh_cusctn))) end + case when (poh_cusctn > 0 and poh_dest <> '') then char(10) + char(13) + 'DESTINATION: ' + ltrim(rtrim(poh_dest)) end + case when (poh_cusctn > 0 or poh_dest <> '') and poh_rmk <> '' then char(10) + char(13) + poh_rmk end
			when 'TT' then ltrim(rtrim('This P.O. is issued on behalf of NEW LEADER. ' + char(10) + char(13) + '此張採購單乃代表 「聯通」發出。' + char(10) + char(13)+ case when poh_cusctn > 0 then 'TOTAL CTN# - ' + ltrim(rtrim(str(poh_cusctn))) end + case when (poh_cusctn > 0 and poh_dest <> '') then char(10) + char(13) + 'DESTINATION: ' + ltrim(rtrim(poh_dest)) end + case when (poh_cusctn > 0 or poh_dest <> '') and poh_rmk <> '' then char(10) + char(13) + poh_rmk end))
			else case vbi_bvennam
				when 'NO' then case when poh_cusctn > 0 then 'TOTAL CTN# - ' + ltrim(rtrim(str(poh_cusctn))) end + case when (poh_cusctn > 0 and poh_dest <> '') then char(10) + char(13) + 'DESTINATION: ' + ltrim(rtrim(poh_dest)) end + case when (poh_cusctn > 0 or poh_dest <> '') and poh_rmk <> '' then char(10) + char(13) + poh_rmk end 
				--when 'NO' then isnull(case when poh_cusctn > 0 then 'TOTAL CTN# - ' + ltrim(rtrim(str(poh_cusctn))) end,'') + isnull(case when (poh_cusctn > 0 and poh_dest <> '') then char(10) + char(13) + 'DESTINATION: ' + ltrim(rtrim(poh_dest)) end,'') + case when (isnull(poh_cusctn,0) > 0 or poh_dest <> '') and poh_rmk <> '' then char(10) + char(13) + poh_rmk end
				else ltrim(rtrim('This P.O. is issued on behalf of ' + vbi_bvennam + '. ' + char(10) + char(13) + '此張採購單乃代表 「' + vbi_bvennamc + '」發出。' + char(10) + char(13)+ case when poh_cusctn > 0 then 'TOTAL CTN# - ' + ltrim(rtrim(str(poh_cusctn))) end + case when (poh_cusctn > 0 and poh_dest <> '') then char(10) + char(13) + 'DESTINATION: ' + ltrim(rtrim(poh_dest)) end + case when (poh_cusctn > 0 or poh_dest <> '') and poh_rmk <> '' then char(10) + char(13) + poh_rmk end))
				end
			end as 'poh_rmk',
*/			
	ltrim(rtrim(case @cocde when 'TT' then 'This P.O. is issued on behalf of NEW LEADER. ' + char(10) + char(13) + '此張採購單乃代表 「聯通」發出。' + char(10) + char(13)
		else case v.vbi_bvennam when 'NO' then '' else 'This P.O. is issued on behalf of ' + v.vbi_bvennam + '. ' + char(10) + char(13) + '此張採購單乃代表 「' + v.vbi_bvennamc + '」發出。' + char(10) + char(13) end end + 
		case poh_cusctn when 0 then '' else 'TOTAL CTN# - ' + ltrim(rtrim(str(poh_cusctn))) + char(10) + char(13) end + case poh_dest when '' then '' else 'DESTINATION: ' + ltrim(rtrim(poh_dest)) + char(10) + char(13) end +
		poh_rmk)) as 'poh_rmk',
		
/*
	case @cocde when 'EW' then poh_rmk when 'HX' then poh_rmk when 'TT' then ltrim(rtrim('This P.O. is issued on behalf of NEW LEADER. ' +
		char(10) + char(13) + '此張採購單乃代表 「聯通」發出。' + char(10) + char(13)+ poh_rmk)) else case vbi_bvennam when 'NO' then poh_rmk 
		else ltrim(rtrim('This P.O. is issued on behalf of ' + vbi_bvennam + '. ' + char(10) + char(13) + '此張採購單乃代表 「' + vbi_bvennamc +
		'」發出。' + char(10) + char(13)+ poh_rmk)) end end as 'poh_rmk_Memo',
*/
/*
	case @cocde	when 'EW' then case when poh_cusctn > 0 then 'TOTAL CTN# - ' + ltrim(rtrim(str(poh_cusctn))) end + case when (poh_cusctn > 0 and poh_dest <> '') then char(10) + char(13) + 'DESTINATION: ' + ltrim(rtrim(poh_dest)) end + case when (poh_cusctn > 0 or poh_dest <> '') and poh_rmk <> '' then char(10) + char(13) + poh_rmk end
			when 'HX' then case when poh_cusctn > 0 then 'TOTAL CTN# - ' + ltrim(rtrim(str(poh_cusctn))) end + case when (poh_cusctn > 0 and poh_dest <> '') then char(10) + char(13) + 'DESTINATION: ' + ltrim(rtrim(poh_dest)) end + case when (poh_cusctn > 0 or poh_dest <> '') and poh_rmk <> '' then char(10) + char(13) + poh_rmk end
			when 'TT' then ltrim(rtrim('This P.O. is issued on behalf of NEW LEADER. ' + char(10) + char(13) + '此張採購單乃代表 「聯通」發出。' + char(10) + char(13)+ case when poh_cusctn > 0 then 'TOTAL CTN# - ' + ltrim(rtrim(str(poh_cusctn))) end + case when (poh_cusctn > 0 and poh_dest <> '') then char(10) + char(13) + 'DESTINATION: ' + ltrim(rtrim(poh_dest)) end + case when (poh_cusctn > 0 or poh_dest <> '') and poh_rmk <> '' then char(10) + char(13) + poh_rmk end))
			else case vbi_bvennam
				when 'NO' then case when poh_cusctn > 0 then 'TOTAL CTN# - ' + ltrim(rtrim(str(poh_cusctn))) end + case when (poh_cusctn > 0 and poh_dest <> '') then char(10) + char(13) + 'DESTINATION: ' + ltrim(rtrim(poh_dest)) end + case when (poh_cusctn > 0 or poh_dest <> '') and poh_rmk <> '' then char(10) + char(13) + poh_rmk end 
				else ltrim(rtrim('This P.O. is issued on behalf of ' + vbi_bvennam + '. ' + char(10) + char(13) + '此張採購單乃代表 「' + vbi_bvennamc + '」發出。' + char(10) + char(13)+ case when poh_cusctn > 0 then 'TOTAL CTN# - ' + ltrim(rtrim(str(poh_cusctn))) end + case when (poh_cusctn > 0 and poh_dest <> '') then char(10) + char(13) + 'DESTINATION: ' + ltrim(rtrim(poh_dest)) end + case when (poh_cusctn > 0 or poh_dest <> '') and poh_rmk <> '' then char(10) + char(13) + poh_rmk end))
				end
			end as 'poh_rmk_Memo',
*/
	ltrim(rtrim(case @cocde when 'TT' then 'This P.O. is issued on behalf of NEW LEADER. ' + char(10) + char(13) + '此張採購單乃代表 「聯通」發出。' + char(10) + char(13)
		else case v.vbi_bvennam when 'NO' then '' else 'This P.O. is issued on behalf of ' + v.vbi_bvennam + '. ' + char(10) + char(13) + '此張採購單乃代表 「' + v.vbi_bvennamc + '」發出。' + char(10) + char(13) end end+ 
		case poh_cusctn when 0 then '' else 'TOTAL CTN# - ' + ltrim(rtrim(str(poh_cusctn))) + char(10) + char(13) end + case poh_dest when '' then '' else 'DESTINATION: ' + ltrim(rtrim(poh_dest)) + char(10) + char(13) end +
		poh_rmk)) as 'poh_rmk_Memo',
	poh_paytrm,
	poh_discnt = str(poh_discnt,10,1),
	-- Detail --
	pod_purord,
	pod_purseq,
	case when @printGroup = '1' then case when len(pod_itmno) < 11 or charindex('-',pod_itmno) > 0 or charindex('/',pod_itmno) > 0 or
		(upper(substring(pod_itmno,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(pod_itmno,7,2) = 'AS' then
		isnull(pod_vencol,'') else case when upper(substring(pod_itmno, 3, 1)) = 'A' or upper(substring(pod_itmno, 3, 1)) = 'C'  or
		upper(substring(pod_itmno, 3, 1)) = 'D' or upper(substring(pod_itmno, 3, 1)) = 'T' or upper(substring(pod_itmno, 3, 1)) = 'X' or
		upper(substring(pod_itmno, 3, 1)) = 'V' then + '(' + substring(pod_itmno,12, len(pod_itmno) - 11) +  ') ' + isnull(pod_vencol,'')
		else case when upper(substring(pod_itmno, 3, 1)) = 'B' and (substring(pod_itmno, 4, 1) >= '0' and substring(pod_itmno, 4, 1) <= '9' )
		and (substring(pod_itmno, 5, 1) >= '0' and substring(pod_itmno, 5, 1) <= '9' ) and  (substring(pod_itmno, 6, 1) >= '0' and
		substring(pod_itmno, 6, 1) <= '9') then  '(' +  substring(pod_itmno,12,len(pod_itmno) - 11) + ') ' + isnull(pod_vencol,'') else 
		case when upper(substring(pod_itmno, 3, 1)) = 'B' and (upper(substring(pod_itmno, 4, 1)) >= 'A' and
		upper(substring(pod_itmno, 4, 1)) <= 'Z' ) and (substring(pod_itmno, 5, 1) >= '0' and substring(pod_itmno, 5, 1) <= '9' ) and
		(substring(pod_itmno, 6, 1) >= '0' and substring(pod_itmno, 6, 1) <= '9') then '(' + substring(pod_itmno,12,len(pod_itmno) - 11)
		+ ') ' + isnull(pod_vencol,'') else isnull(pod_vencol,'') end end end end else isnull(pod_vencol,'') end as 'pod_vencol',
	case when @printGroup = '1' then case when len(pod_itmno) < 11 or charindex('-',pod_itmno) > 0 or charindex('/',pod_itmno) > 0 or
		(upper(substring(pod_itmno,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(pod_itmno,7,2) = 'AS' then
		pod_itmno else case when upper(substring(pod_itmno, 3, 1)) = 'A' or upper(substring(pod_itmno, 3, 1)) = 'C'  or
		upper(substring(pod_itmno, 3, 1)) = 'D' or upper(substring(pod_itmno, 3, 1)) = 'T' or upper(substring(pod_itmno, 3, 1)) = 'X' or
		upper(substring(pod_itmno, 3, 1)) = 'V' then substring(pod_itmno,1,11) else case when upper(substring(pod_itmno, 3, 1)) = 'B' and
		(substring(pod_itmno, 4, 1) >= '0' and substring(pod_itmno, 4, 1) <= '9' ) and (substring(pod_itmno, 5, 1) >= '0' and
		substring(pod_itmno, 5, 1) <= '9' ) and (substring(pod_itmno, 6, 1) >= '0' and substring(pod_itmno, 6, 1) <= '9') then
		substring(pod_itmno,1,11) else case when upper(substring(pod_itmno, 3, 1)) = 'B' and (upper(substring(pod_itmno, 4, 1)) >= 'A' and
		upper(substring(pod_itmno, 4, 1)) <= 'Z' ) and (substring(pod_itmno, 5, 1) >= '0' and substring(pod_itmno, 5, 1) <= '9' ) and 
		(substring(pod_itmno, 6, 1) >= '0' and substring(pod_itmno, 6, 1) <= '9') then substring(pod_itmno,1,11) else pod_itmno end
		end end end else pod_itmno end as 'pod_itmno',
	case when v.vbi_ventyp = 'E' then pod_venitm else case when @printGroup = '1' then case when len(pod_venitm) < 11 or charindex('-',pod_venitm) > 0 or 
		charindex('/',pod_venitm) > 0 or (upper(substring(pod_venitm,3,1)) not in ('A','B','U','C','D','T','V','X')) or 
		substring(pod_venitm,7,2) = 'AS' then pod_venitm else case when upper(substring(pod_venitm, 3, 1)) = 'A' or 
		upper(substring(pod_itmno, 3, 1)) = 'C' or upper(substring(pod_itmno, 3, 1)) = 'D' or upper(substring(pod_itmno, 3, 1)) = 'T' or 
		upper(substring(pod_itmno, 3, 1)) = 'X' or upper(substring(pod_itmno, 3, 1)) = 'V' then substring(pod_venitm,1,11) else 
		case when upper(substring(pod_venitm, 3, 1)) = 'B' and (substring(pod_venitm, 4, 1) >= '0' and substring(pod_venitm, 4, 1) <= '9' ) and 
		(substring(pod_venitm, 5, 1) >= '0' and substring(pod_venitm, 5, 1) <= '9' ) and  (substring(pod_venitm, 6, 1) >= '0' and 
		substring(pod_venitm, 6, 1) <= '9') then substring(pod_venitm,1,11) else case when upper(substring(pod_venitm, 3, 1)) = 'B' and 
		(upper(substring(pod_venitm, 4, 1)) >= 'A' and upper(substring(pod_venitm, 4, 1)) <= 'Z' ) and (substring(pod_venitm, 5, 1) >= '0' and 
		substring(pod_venitm, 5, 1) <= '9' ) and  (substring(pod_venitm, 6, 1) >= '0' and substring(pod_venitm, 6, 1) <= '9') then 
		substring(pod_venitm,1,11) else pod_venitm end end end end else pod_venitm end end as 'pod_venitm',
	pod_engdsc,
	pod_engdsc as 'pod_engdsc_Memo',
	pod_chndsc,
	pod_chndsc as 'pod_chndsc_Memo',
	pod_cususdcur,
	pod_cususd,
	pod_cuscadcur,
	pod_cuscad,
	pod_cuspno,
	pod_respno,
	pod_jobord,
	str(pod_inrctn)as  'pod_inrctn',
	str(pod_mtrctn)as 'pod_mtrctn',	
	ltrim(str(pod_cubcft,10,2)) as 'pod_cubcft',
	pod_cubcft as 'pod_cubcft_num',
	case isnull(sod_pjobno,'') when '' then pod_rmk else '取代 Job # ' + sod_pjobno + case isnull(pod_rmk,'') when '' then '' else char(13) +
		pod_rmk end end as 'pod_rmk',
	case isnull(sod_pjobno,'') when '' then pod_rmk else '取代 Job # ' + sod_pjobno + case isnull(pod_rmk,'') when '' then '' else char(13) +
		pod_rmk end end as 'pod_rmk_memo',
	pod_cusitm,
	pod_cuscol, 
	pod_coldsc,
	pod_cussku,
	pod_code1, 
	pod_code2,
	pod_code3,
	pod_hrmcde,
	pod_untcde,
	pod_ordqty,
	str(pod_ordqty) as 'pod_ordqtyStr',
	pod_lneamt,
	pod_scno,
	pod_ftyprc,	
	str(pod_ttlctn * pod_cubcft) as 'pod_tolcft',
	pod_ttlctn * pod_cubcft 'tolcft',
	round(pod_cubcft * pod_ttlctn,2) as 'lne_cft',
	pod_pckitr, 
	ltrim(isnull(pod_pckitr,'')) as 'pod_pckitr_Memo',
	pod_typcode,
	convert(char(10), pod_shpstr, 101) as 'shipstr',
	convert(char(10), pod_shpstr, 101) as 'shipend',
	case pod_candat when '1900-01-01' then '' else convert(char(10), pod_candat, 101) end as 'pod_candat',
	replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(ltrim(str(datepart(mm,pod_shpstr))),'1','Jan'),'2','Feb'),'3','Mar'),'4','Apr'),'5','May'),'6','Jun'),'7','Jul'),'8','Aug'),'9','Sep'),'10','Oct'),'11','Nov'),'12','Dec') as 'pod_shpstrMM',	
	replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(ltrim(str(datepart(mm,pod_shpend))),'1','Jan'),'2','Feb'),'3','Mar'),'4','Apr'),'5','May'),'6','Jun'),'7','Jul'),'8','Aug'),'9','Sep'),'10','Oct'),'11','Nov'),'12','Dec') as 'pod_shpendMM',
	datepart(dd,pod_shpstr) as 'pod_shpstrDD',
	datepart(dd,pod_shpend) as 'pod_shpendDD',
	yup_usrnam as 'ouSal',
	-- Shipmark : Image Path --
	isNull(shpmrkM.psm_imgpth,'') as 'psm_imgpth_M', 
	isNull(shpmrkI.psm_imgpth,'') as 'psm_imgpth_I',
	isNull(shpmrkS.psm_imgpth,'') as 'psm_imgpth_S',
	-- Shipmark : English Description
	isnull(ltrim(shpmrkM.psm_engdsc),'') as 'MainEng',
	isnull(ltrim(shpmrkI.psm_engdsc),'') as 'InnerEng',
	isnull(ltrim(shpmrkS.psm_engdsc),'') as 'SideEng',
	isnull(shpmrkM.psm_engdsc,'') as 'MainEng_Memo',
	isnull(shpmrkI.psm_engdsc,'') as 'InnerEng_Memo',
	isnull(shpmrkS.psm_engdsc,'') as 'SideEng_Memo',
	-- Shipmark : Chinese Description
	isnull(ltrim(shpmrkM.psm_chndsc),'') as 'MainChn', 
	isnull(ltrim(shpmrkI.psm_chndsc),'') as 'InnerChn',
	isnull(ltrim(shpmrkS.psm_chndsc),'') as 'SideChn',
	isnull(shpmrkM.psm_chndsc,'') as 'MainChn_Memo',
	isnull(shpmrkI.psm_chndsc,'') as 'InnerChn_Memo',
	isnull(shpmrkS.psm_chndsc,'') as 'SideChn_Memo',
	-- Shipmark : Chinese Remark
	isnull(shpmrkM.psm_chnrmk,'') as 'MainChnRmk',
	isnull(shpmrkI.psm_chnrmk,'') as 'InnerChnRmk', 
	isnull(shpmrkS.psm_chnrmk,'') as 'SideChnRmk', 
	isnull(shpmrkM.psm_chnrmk,'') as 'MainChnRmk_Memo',
	isnull(shpmrkI.psm_chnrmk,'') as 'InnerChnRmk_Memo', 
	isnull(shpmrkS.psm_chnrmk,'') as 'SideChnRmk_Memo', 
	-- Shipmark : English Remark
	isnull(shpmrkM.psm_engrmk,'') as 'MainEngRmk_Memo', 
	isnull(shpmrkI.psm_engrmk,'') as 'InnerEngRmk_Memo', 
	isnull(shpmrkS.psm_engrmk,'') as 'SideEngRmk_Memo', 
	ltrim(isnull(shpmrkM.psm_engrmk,'')) as 'MainEngRmk', 
	ltrim(isnull(shpmrkI.psm_engrmk,'')) as 'InnerEngRmk', 
	ltrim(isnull(shpmrkS.psm_engrmk,'')) as 'SideEngRmk',
	-- Price Term
	hdrPrcTrm.ysi_dsc as 'prctrm',
	-- Pay Term
	paytrm.ysi_dsc as 'paytrmDesc',
	-- SC Sub Code
	sod_subcde,
	um.ysi_dsc as 'unitcode',
	pod_dept,
	pod_dtyrat as 'dtyrat',
	case poh_venno when '0005' then cbi_cussna when '0007' then cbi_cussna else '' end as 'cbi_cussna',
	isnull(pod_prdven,'') as 'pod_prdven',
	isnull(pod_seccusitm,'') as 'pod_seccusitm',
	isnull(poh_signappflg,'') as 'poh_sigappflg',
	right(convert(varchar(4),year(poh_appdat)),2) + case month(poh_appdat) when 1 then 'A' when 2 then 'B' when 3 then 'C' when 4 then 'D' 
		when 5 then 'E' when 6 then 'F' when 7 then 'G' when 8 then 'H' when 9 then 'I' when 10 then 'J' when 11 then 'K'
		when 12 then 'L' else 'Z'end + convert(varchar(2),day(poh_appdat)) as 'poh_appdat',
	poh_ttlcbm,
	poh_ttlamt,
	poh_netamt,
	--pod_ftyprctrm
	isnull(ftyPrcTrm.ysi_dsc,'') as 'pod_ftyprctrm' ,
	cbi_cussna as 'cbi_cussna_new',
	poh_cpodat,
	poh_upddat,
	pod_ttlctn,
	pod_prdven + ' - ' + pv.vbi_vensna as 'pod_pvnam'
from	POORDDTL (nolock)
	left join POORDHDR (nolock) on
		poh_cocde = pod_cocde and
		poh_purord = pod_purord
	left join CUBASINF (nolock) on
		cbi_cusno = poh_prmcus
	join VNBASINF v (nolock) on
		v.vbi_venno = poh_venno
	left join SYSETINF purcty (nolock) on
		purcty.ysi_typ = '02' and
		purcty.ysi_cde = poh_purcty
	left join SCORDDTL (nolock) on
		sod_cocde = pod_cocde and
		sod_ordno = pod_scno and
		sod_ordseq = pod_scline
	left join SYUSRPRF (nolock) on
		poh_srname = yup_usrid
	left join POSHPMRK shpmrkM (nolock) on
		shpmrkM.psm_cocde = pod_cocde and
		shpmrkM.psm_purord = pod_purord and
		shpmrkM.psm_shptyp = 'M'
	left join POSHPMRK shpmrkI (nolock) on
		shpmrkI.psm_cocde = pod_cocde and
		shpmrkI.psm_purord = pod_purord and
		shpmrkI.psm_shptyp = 'I'
	left join POSHPMRK shpmrkS (nolock) on
		shpmrkS.psm_cocde = pod_cocde and
		shpmrkS.psm_purord = pod_purord and
		shpmrkS.psm_shptyp = 'S'
	left join SYSETINF hdrPrcTrm (nolock) on
		hdrPrcTrm.ysi_typ = '03' and
		hdrPrcTrm.ysi_cde = poh_prctrm
	left join SYSETINF paytrm (nolock) on
		paytrm.ysi_typ = '04' and
		paytrm.ysi_cde = poh_paytrm
	left join SYSETINF um (nolock) on 
		um.ysi_typ = '05' and
		um.ysi_cde = pod_untcde
	left join SYSETINF ftyPrcTrm (nolock) on
		ftyPrcTrm.ysi_typ = '03' and
		ftyPrcTrm.ysi_cde = pod_ftyprctrm
	left join VNBASINF pv (nolock) on pv.vbi_venno = pod_prdven
where	pod_cocde = @cocde and
	pod_purord between @POfrom and @POto and
	((@Sup0 = 'Y' and pod_ordqty > 0) or @Sup0 = 'N') and
	(@POCheck = 'N' or (@POCheck = 'Y' and poh_purord in (select tmp_purord from #TEMP_PO_LIST)))











GO
GRANT EXECUTE ON [dbo].[sp_select_POR00001] TO [ERPUSER] AS [dbo]
GO
