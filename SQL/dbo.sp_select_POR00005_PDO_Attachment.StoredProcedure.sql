/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_PDO_Attachment]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00005_PDO_Attachment]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_PDO_Attachment]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




/*
=================================================================
Program ID	: sp_select_POR00005_PDO_Attachment
Description	: Retrieve Shipmark Attachments
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-11-11	David Yue		SP Created
=================================================================
*/


CREATE   PROCEDURE [dbo].[sp_select_POR00005_PDO_Attachment]

@cocde		nvarchar(6),	
@batch		nvarchar(23)

AS


select	distinct
	@cocde as 'cocde',
	poh_venno,
	fsm_smkno,
	'' as 'filepath'
from	POJBBDTL (nolock)
	join POORDDTL (nolock) on
		pod_cocde = pjd_cocde and
		pod_jobord = pjd_jobord
	join POORDHDR (nolock) on
		poh_cocde = pod_cocde and
		poh_purord = pod_purord
	join FYJOBSMK (nolock) on
		fsm_jobno = pjd_batno + '-' + pjd_batseq
where	pjd_cocde = @cocde and
	pjd_batno = @batch and
	pjd_confrm = 'Y'
order by fsm_smkno




GO
GRANT EXECUTE ON [dbo].[sp_select_POR00005_PDO_Attachment] TO [ERPUSER] AS [dbo]
GO
