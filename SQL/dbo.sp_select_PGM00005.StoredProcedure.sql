/****** Object:  StoredProcedure [dbo].[sp_select_PGM00005]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PGM00005]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PGM00005]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


------------------------------------------------- 
CREATE PROCEDURE [dbo].[sp_select_PGM00005] 

@cocde  	nvarchar(6),
@from	  	nvarchar(20),
@to		nvarchar(20)

AS

select 
pod_ordno,
pod_seq,
pod_itemno,
pod_pckunt + '/' + convert(varchar(10), pod_inrqty) + '/' + convert(varchar(10), pod_mtrqty) + '/' + pod_ftyprctrm + '/'+pod_hkprctrm + '/' + pod_trantrm as 'pod_packing',
pod_pkgitm,
pod_pkgven,
vbi_vensna,
'Y' as 'pjd_confrm',
'' as 'pjd_batseq',
'new' as 'pjd_recsts',
'' as 'vencde',
pod_credat,
pod_upddat,
pod_updusr
from PKORDDTL (nolock)
left join VNBASINF (nolock) on vbi_venno = pod_pkgven
where pod_cocde = @cocde and pod_ordno between @from and @to
order by pod_seq
/*

select 
'11' as 'pod_ordno',
'22' as 'pod_seq',
'33' as 'pod_reqno',
'44' as 'pod_reqseq',
'' as 'vbi_vensna',
'Y' as 'pjd_confrm',
'' as 'pjd_batseq',
'new' as 'pjd_recsts',
'' as 'vencde'
--from PKORDDTL (nolock)
--where pod_cocde = @cocde and pod_ordno between @from and @to
--order by pod_seq

*/





GO
GRANT EXECUTE ON [dbo].[sp_select_PGM00005] TO [ERPUSER] AS [dbo]
GO
