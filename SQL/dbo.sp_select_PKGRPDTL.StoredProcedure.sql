/****** Object:  StoredProcedure [dbo].[sp_select_PKGRPDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PKGRPDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PKGRPDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





------------------------------------------------- 
CREATE PROCEDURE [dbo].[sp_select_PKGRPDTL] 

@cocde  	nvarchar(6),
@batno	nvarchar(20),
@gsUsrID	nvarchar(10)

AS

/*
select 
pgd_grpseq,
pgd_ordno,
pgd_ordseq,
pgd_reqno,
pgd_reqseq,
'',0,'old',''
from PKGRPDTL (nolock)
where pgd_cocde = @cocde and pgd_grpno = @batno
order by pgd_grpseq
*/

select 
prd_reqno as 'pod_ordno',
prd_seq as 'pod_seq',
prh_scno,
prh_tono,
prd_itemno as 'pod_itemno',
prd_assitm as 'pod_assitm',
prd_pckunt + '/' + convert(varchar(10), prd_inrqty) + '/' + convert(varchar(10), prd_mtrqty) + '/' + prd_ftyprctrm + '/'+prd_hkprctrm + '/' + prd_trantrm as 'pod_packing',
prd_sku,
prd_cusitm,
prd_pkgitm as 'pod_pkgitm',
prd_pkgven as 'pod_pkgven',
vbi_vensna,
'Y' as 'pjd_confrm',
prd_ordno as 'R_pod_ordno',
prd_ordseq as 'R_pod_ordseq',
'' as 'pjd_batseq',
'old' as 'pjd_recsts',
'' as 'vencde',
prd_sctoqty,
prd_ordqty as 'pod_ttlordqty' ,
prd_bonqty,
cast(prd_untprc as numeric(13,5)) as 'pod_untprc',
prd_cate as 'pod_cate',
prd_curcde,
prd_credat,
prd_upddat,
prd_updusr


from PKGRPDTL (nolock)
left join PKREQDTL (nolock) on pgd_cocde = prd_cocde and pgd_reqno = prd_reqno and pgd_reqseq = prd_seq
left join PKREQHDR (nolock) on prd_reqno = prh_reqno
left join VNBASINF (nolock) on vbi_venno = prd_pkgven
left join PKORDDTL (nolock) on pod_ordno = prd_ordno and pod_seq = prd_ordseq
where pgd_cocde = @cocde and pgd_grpno = @batno --and pod_status = 'OPE'
order by pgd_grpno

/*
SELECT 
	pod_scno,
	pod_jobord,
	pod_runno,
	pod_itmno,
	vbi_vensna,
	pjd_confrm,
	pjd_batseq,
	'old' as pjd_recsts,
	vbi_venno as vencde
FROM 
	POJBBDTL, POORDDTL, POORDHDR, VNBASINF
WHERE 
	pjd_cocde = @cocde AND
	pjd_batno = @batno AND
	pjd_jobord = pod_jobord AND
	pod_purord = poh_purord AND
	poh_cocde = pjd_cocde AND
	poh_venno = vbi_venno 
	--and vbi_cocde = pjd_cocde
order by 
	pjd_batseq

*/





GO
GRANT EXECUTE ON [dbo].[sp_select_PKGRPDTL] TO [ERPUSER] AS [dbo]
GO
