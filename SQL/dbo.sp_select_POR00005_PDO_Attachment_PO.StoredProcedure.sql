/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_PDO_Attachment_PO]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00005_PDO_Attachment_PO]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_PDO_Attachment_PO]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



 

CREATE   PROCEDURE [dbo].[sp_select_POR00005_PDO_Attachment_PO]

@cocde		nvarchar(6),
@jobno		nvarchar(25),	
@batch		nvarchar(23)

AS


select	distinct
	@cocde as 'cocde',
	poh_venno,
	stm_smkno,
	'' as 'filepath'
from	--POJBBDTL (nolock)
	 POORDDTL (nolock) 
	join POORDHDR (nolock) on
		poh_cocde = pod_cocde and
		poh_purord = pod_purord
	join SCTPSMRK (nolock) on
								stm_ordno =pod_scno
											and stm_ordseq =pod_scline
									 and stm_act <> 'DEL'
where	pod_cocde = @cocde and
	pod_jobord = @jobno 
	--pjd_confrm = 'Y'
order by stm_smkno





GO
GRANT EXECUTE ON [dbo].[sp_select_POR00005_PDO_Attachment_PO] TO [ERPUSER] AS [dbo]
GO
