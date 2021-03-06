/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_PDO_AttchList]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00005_PDO_AttchList]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_PDO_AttchList]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




/*
=================================================================
Program ID	: sp_select_POR00005_PDO_AttchList
Description	: Retrieve Shipmark Attachment List
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-11-06 	David Yue		SP Created
=================================================================
*/


CREATE   PROCEDURE [dbo].[sp_select_POR00005_PDO_AttchList]

@cocde		nvarchar(6),	
@batch		nvarchar(23)

AS


select	@cocde as 'cocde',
	pjd_batno + '-' + pjd_batseq as 'batch',
	pod_jobord,
	pod_itmno + ltrim(pod_engdsc) +  ysi_dsc + str(pod_inrctn,10,0) + str(pod_mtrctn,10,0) + str(pod_cubcft,10,2) as 'podKey',
	fsm_smkno
from	POJBBDTL (nolock)
	join POORDDTL (nolock) on
		pod_cocde = pjd_cocde and
		pod_jobord = pjd_jobord
	join SYSETINF (nolock) on
		ysi_typ = '05' and
		ysi_cde = pod_untcde
	join FYJOBSMK (nolock) on
		fsm_jobno = pjd_batno + '-' + pjd_batseq
where	pjd_cocde = @cocde and
	pjd_batno = @batch and
	pjd_confrm = 'Y'
order by batch, fsm_smkno




GO
GRANT EXECUTE ON [dbo].[sp_select_POR00005_PDO_AttchList] TO [ERPUSER] AS [dbo]
GO
