/****** Object:  StoredProcedure [dbo].[sp_select_PKMAPDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PKMAPDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PKMAPDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





------------------------------------------------- 
Create PROCEDURE [dbo].[sp_select_PKMAPDTL] 

@cocde  	nvarchar(6),
@pmd_ordno  nvarchar(20),
@gsUsrID	nvarchar(30)

AS

BEGIN
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
prd_curcde


from PKMAPDTL (nolock)
left join PKREQDTL (nolock) on pmd_cocde = prd_cocde and pmd_reqno = prd_reqno and pmd_reqseq = prd_seq
left join PKREQHDR (nolock) on prd_reqno = prh_reqno
left join VNBASINF (nolock) on vbi_venno = prd_pkgven
left join PKORDDTL (nolock) on pod_ordno = prd_ordno and pod_seq = prd_ordseq
where pmd_cocde = @cocde and pmd_ordno = @pmd_ordno --and pod_status = 'OPE'
order by pmd_ordno
end


GO
GRANT EXECUTE ON [dbo].[sp_select_PKMAPDTL] TO [ERPUSER] AS [dbo]
GO
