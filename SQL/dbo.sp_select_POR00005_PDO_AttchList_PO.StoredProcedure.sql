/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_PDO_AttchList_PO]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00005_PDO_AttchList_PO]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_PDO_AttchList_PO]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE   PROCEDURE [dbo].[sp_select_POR00005_PDO_AttchList_PO]

@cocde		nvarchar(6),	
@jobno		nvarchar(23),
@batch		nvarchar(25)

AS


select	@cocde as 'cocde',
	--pjd_batno + '-' + pjd_batseq as 'batch',
	@batch as 'batch',
	pod_jobord,
	pod_itmno + ltrim(pod_engdsc) +  ysi_dsc + str(pod_inrctn,10,0) + str(pod_mtrctn,10,0) + str(pod_cubcft,10,2) as 'podKey',
	stm_smkno--fsm_smkno
from	--POJBBDTL (nolock)
	POORDDTL (nolock) 
	join SYSETINF (nolock) on
		ysi_typ = '05' and
		ysi_cde = pod_untcde
	--join FYJOBSMK (nolock) on
		--fsm_jobno = pjd_batno + '-' + pjd_batseq
	join SCTPSMRK (nolock) on
								stm_ordno =pod_scno
											and stm_ordseq =pod_scline
									 and stm_act <> 'DEL'
where	pod_cocde = @cocde and
	pod_jobord = @jobno
	--pjd_confrm = 'Y'
order by batch, stm_smkno





GO
GRANT EXECUTE ON [dbo].[sp_select_POR00005_PDO_AttchList_PO] TO [ERPUSER] AS [dbo]
GO
