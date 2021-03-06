/****** Object:  StoredProcedure [dbo].[sp_list_POORDDTL2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_POORDDTL2]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_POORDDTL2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/************************************************************************
Author:		Carlos Lui
Date:		13 Jul, 2012
Description:	Select data From POORDDTL
Parameter:		1. Company
		2. PO No
***********************************************************************

*/

CREATE procedure [dbo].[sp_list_POORDDTL2]
                                                                                                                                                                                                                                                               
@pod_cocde nvarchar(6) ,
@pod_purord nvarchar(20) 

AS

begin

	SET NOCOUNT ON
	
	select	pod_purseq,
		isnull(pod_prdven,'') + case isnull(vbi_vensna,'')
					when '' then ''
					else ' - ' + isnull(vbi_vensna,'')
					end as 'pod_prdven',
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
		isnull(convert( nvarchar(10), case pod_candat
					when '1900-01-01' then null 
					else cast(pod_candat as datetime)
					end,101),'  /  /    ') as 'pod_candat',
		isnull(pod_hrmcde,'') as 'pod_hrmcde',
		pod_dtyrat,
		pod_code1,
		pod_code2,
		pod_code3,
		pod_cususd,
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
		case (	select	count(1)
			from	PODTLBOM
			where	PDB_PURORD = POD_PURORD	AND
				PDB_SEQ = POD_PURSEQ)
				when '0' then 'N'
				else 'Y'
				end as 'bom_flg',
		case (	select	count(1)
			from	PODTLASS
			where	PDA_PURORD = POD_PURORD	AND
				PDA_SEQ =  POD_PURSEQ)
				when '0' then 'N'
				else 'Y'
				end as 'assort_flg',
		pod_qutdat,
		pod_imqutdat,
		pod_cus1no,
		pod_cus2no,
		pod_hkprctrm,
		pod_ftyprctrm,
		pod_trantrm,
		pod_effdat,
		pod_expdat
	from 	POORDDTL
		left join VNBASINF on vbi_venno  = pod_prdven
		left join SCORDDTL on sod_cocde = pod_cocde and	sod_ordno = pod_scno and sod_ordseq = pod_scline
		left join POORDHDR on poh_cocde = pod_cocde and poh_purord = pod_purord
	where	pod_cocde = @pod_cocde	and
		pod_purord = @pod_purord 	
	order by pod_purseq
end







GO
GRANT EXECUTE ON [dbo].[sp_list_POORDDTL2] TO [ERPUSER] AS [dbo]
GO
