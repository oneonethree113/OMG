/****** Object:  StoredProcedure [dbo].[sp_list_POORDDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_POORDDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_POORDDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO










/*
=================================================================
Program ID	: sp_list_POORDDTL
Description	: Select data From POORDDTL
Programmer	: Wong Hong
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2002-01-04 	Wong Hong		SP Created
2003-10-27	Allan Yuen		Add Running No.
2004-09-09	Allan Yuen		Add Contain Assorted Item / BOM Itm Flag
2004-10-06	Lester Wu		Show Ship Start, Ship End in Date Format
2005-06-01	Lester Wu		Show PV, Prev Job No., Secondary Cust. Itm No.
2013-07-31	David Yue		Phase 2 Implementation
=================================================================
*/



CREATE procedure [dbo].[sp_list_POORDDTL]
                                                                                                                                                                                                                                                               
@pod_cocde nvarchar(6) ,
@pod_purord nvarchar(20)

AS
BEGIN

SET NOCOUNT ON

select	pod_purseq,
	isnull(pod_prdven,'') + case isnull(pv.vbi_vensna,'') when '' then '' else  ' - ' + isnull(pv.vbi_vensna,'') end as 'pod_prdven',
	isnull(pod_tradeven,'') + case isnull(tv.vbi_vensna,'') when '' then '' else  ' - ' + isnull(tv.vbi_vensna,'') end as 'pod_tradeven',
	isnull(pod_examven,'') + case isnull(ev.vbi_vensna,'') when '' then '' else  ' - ' + isnull(ev.vbi_vensna,'') end as 'pod_examven',
	pod_itmno,	
	isnull(pod_jobord,'') as 'pod_jobord',
	isnull(pod_runno,'') as 'pod_runno',
	isnull(sod_pjobno,'') as 'sod_pjobno',
	isnull(sod_subcde, '') as 'sod_subcde',
	pod_venitm,
	pod_cusitm,
	pod_cussku,
	isnull(pod_seccusitm,'') as 'pod_seccusitm',
	isnull(pod_vencol,'') as 'pod_vencol',
	pod_cuscol,
	pod_coldsc,
	ltrim(pod_untcde)+' / '+ltrim(str(pod_inrctn))+ ' / '+ltrim(str(pod_mtrctn))+' / '+ltrim(str(pod_cubcft,11,4)) as 'packinfo',
	pod_pckitr,
	pod_ordqty,
	pod_recqty,
	pod_ordqty - pod_recqty as 'os_qty',
	poh_curcde,
	pod_ftyprc,
	pod_ctnstr,
	pod_ctnend,
	pod_ttlctn,
	convert(nvarchar(10),pod_shpstr,101) as 'pod_shpstr',
	convert(nvarchar(10),pod_shpend,101) as 'pod_shpend',
	isnull(convert( nvarchar(10), case pod_candat when '1900-01-01' then null else cast(pod_candat as datetime) end,101),'  /  /    ') as 'pod_candat',
	isnull(pod_hrmcde,'') as 'pod_hrmcde',
	pod_dtyrat,
	pod_code1,
	pod_code2,
	pod_code3,
	pod_cususdcur,
	pod_cususd,
	pod_cuscadcur,
	pod_cuscad,
	pod_cocde,
	pod_purord,
	pod_itmsts, 
	pod_engdsc, 
	isnull(pod_chndsc, '') as 'pod_chndsc',
	pod_pckseq,
	pod_untcde,
	pod_inrctn,
	pod_mtrctn,
	pod_cubcft,
	pod_cbm,
	pod_dept,
	pod_cuspno,
	pod_respno,
	pod_lblcde,
	pod_scno,
	pod_lneamt,
	pod_lnecub,
	pod_ttlqty,
	pod_scline,
	pod_assflg,
	pod_typcode,   
	pod_rmk,
	CASE (SELECT COUNT(*) FROM PODTLBOM (nolock) WHERE  PDB_PURORD = POD_PURORD AND PDB_SEQ = POD_PURSEQ)
		WHEN '0' THEN 'N'
		ELSE 'Y'
		END AS 'bom_flg',
	CASE  (SELECT  COUNT(*) FROM PODTLASS (nolock) WHERE PDA_PURORD = POD_PURORD AND PDA_SEQ =  POD_PURSEQ)
		WHEN '0' THEN 'N'
		ELSE 'Y'
		END AS 'assort_flg',
	pod_qutdat,
	pod_imqutdat
from	POORDDTL (nolock)
	left join POORDHDR (nolock) on
		poh_cocde = pod_cocde and
		poh_purord = pod_purord
	left join SCORDDTL (nolock) on
		sod_cocde = pod_cocde and
		sod_ordno = pod_scno and
		sod_ordseq = pod_scline
	left join VNBASINF pv (nolock) on
		pv.vbi_venno = pod_prdven
	left join VNBASINF tv (nolock) on
		tv.vbi_venno = pod_tradeven
	left join VNBASINF ev (nolock) on
		ev.vbi_venno = pod_examven
where	pod_cocde = @pod_cocde and
	pod_purord = @pod_purord
order by pod_purseq

END
















GO
GRANT EXECUTE ON [dbo].[sp_list_POORDDTL] TO [ERPUSER] AS [dbo]
GO
