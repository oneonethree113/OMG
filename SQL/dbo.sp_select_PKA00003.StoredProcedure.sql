/****** Object:  StoredProcedure [dbo].[sp_select_PKA00003]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PKA00003]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PKA00003]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/*
=================================================================
Program ID	: sp_select_PKA00003
Description	: Retrieve Data for Packaging Report (By Packaging Item)
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2015-05-21 	David Yue		SP Created
=================================================================
*/

CREATE procedure [dbo].[sp_select_PKA00003] 
@cocde		nvarchar(6) , 
@pod_pkgitm	nvarchar(30)

AS    
BEGIN    

select	poh_cocde,
	isnull(yco_conam, '') as 'yco_conam',
	poh_ordno, 
	poh_pkgven,
	isnull(vbi_vensna,'') as 'vbi_vensna',
	poh_issdat,
	poh_revdat,
	pod_seq,
	pod_pkgitm,
	pod_engdsc,
	pod_status,
	pod_ordqty,
	pod_stkqty,
	pod_bonqty as 'pod_wasper',
	pod_bonqty,
	pod_ttlordqty,
	pod_qtyum as 'um',
	pod_curcde,
	pod_untprc,
	pod_ttlamtqty,
	poh_ver
from	PKORDDTL (nolock)
	left join SYCOMINF (nolock) on
		yco_cocde = pod_cocde
	left join PKORDHDR (nolock) on 
		pod_ordno = poh_ordno
	left join VNBASINF (nolock) on 
		poh_pkgven = vbi_venno
where	pod_pkgitm = @pod_pkgitm and
	pod_cocde = @cocde
order by poh_ordno


END



GO
GRANT EXECUTE ON [dbo].[sp_select_PKA00003] TO [ERPUSER] AS [dbo]
GO
